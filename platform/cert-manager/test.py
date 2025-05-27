import os
import sys
import pytest
from unittest.mock import patch, mock_open

# Import the module to test
# You might need to adjust this import based on your actual package structure
sys.path.insert(0, '.')
from your_package.healthcheck import (
    check_health, check_required_directories,
    check_input_directory_populated, check_logs_for_errors
)

class TestHealthCheck:

    def setup_directory_structure(self, tmp_path):
        """Helper to create a standard directory structure for tests"""
        # Create the required directories
        input_dir = tmp_path / "input"
        output_dir = tmp_path / "output"
        logs_dir = tmp_path / "logs"

        input_dir.mkdir()
        output_dir.mkdir()
        logs_dir.mkdir()

        # Add a sample file to input dir
        sample_file = input_dir / "sample.txt"
        sample_file.write_text("Sample content")

        return {
            "root": tmp_path,
            "input": input_dir,
            "output": output_dir,
            "logs": logs_dir,
            "sample_file": sample_file
        }

    @pytest.fixture
    def mock_env_vars(self, monkeypatch):
        """Set up environment variables for testing"""
        monkeypatch.setenv("TIMESTAMP", "test_timestamp")

    def test_check_health_all_checks_pass(self, tmp_path, monkeypatch):
        """Test that check_health returns 0 when all checks pass"""
        dirs = self.setup_directory_structure(tmp_path)

        # Create a clean log file
        log_file = dirs["output"] / "your_package_test_timestamp.log"
        log_file.write_text("INFO: Everything is fine")

        # Patch the directory paths
        monkeypatch.setenv("TIMESTAMP", "test_timestamp")
        with patch('os.path.exists', return_value=True), \
             patch('your_package.healthcheck.check_required_directories', return_value=True), \
             patch('your_package.healthcheck.check_input_directory_populated', return_value=True), \
             patch('your_package.healthcheck.check_logs_for_errors', return_value=True):

            assert check_health() == 0

    def test_check_health_one_check_fails(self, tmp_path, monkeypatch):
        """Test that check_health returns 1 when any check fails"""
        dirs = self.setup_directory_structure(tmp_path)

        # Test with each function failing individually
        with patch('your_package.healthcheck.check_required_directories', return_value=False), \
             patch('your_package.healthcheck.check_input_directory_populated', return_value=True), \
             patch('your_package.healthcheck.check_logs_for_errors', return_value=True):

            assert check_health() == 1

        with patch('your_package.healthcheck.check_required_directories', return_value=True), \
             patch('your_package.healthcheck.check_input_directory_populated', return_value=False), \
             patch('your_package.healthcheck.check_logs_for_errors', return_value=True):

            assert check_health() == 1

        with patch('your_package.healthcheck.check_required_directories', return_value=True), \
             patch('your_package.healthcheck.check_input_directory_populated', return_value=True), \
             patch('your_package.healthcheck.check_logs_for_errors', return_value=False):

            assert check_health() == 1

    def test_check_required_directories_all_exist(self, tmp_path, monkeypatch):
        """Test check_required_directories when all required directories exist"""
        dirs = self.setup_directory_structure(tmp_path)

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        assert check_required_directories() is True

    def test_check_required_directories_missing(self, tmp_path, monkeypatch):
        """Test check_required_directories when a required directory is missing"""
        dirs = self.setup_directory_structure(tmp_path)

        # Remove one of the required directories
        os.rmdir(dirs["output"])

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        assert check_required_directories() is False

    def test_check_required_directories_is_file(self, tmp_path, monkeypatch):
        """Test check_required_directories when a required directory is actually a file"""
        dirs = self.setup_directory_structure(tmp_path)

        # Remove one of the required directories and create a file with the same name
        os.rmdir(dirs["output"])
        with open(dirs["root"] / "output", "w") as f:
            f.write("This is a file, not a directory")

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        assert check_required_directories() is False

    def test_check_input_directory_populated(self, tmp_path, monkeypatch):
        """Test check_input_directory_populated when input directory has files"""
        dirs = self.setup_directory_structure(tmp_path)

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        assert check_input_directory_populated() is True

    def test_check_input_directory_empty(self, tmp_path, monkeypatch):
        """Test check_input_directory_populated when input directory is empty"""
        dirs = self.setup_directory_structure(tmp_path)

        # Remove the sample file to make the directory empty
        os.unlink(dirs["sample_file"])

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        assert check_input_directory_populated() is False

    def test_check_input_directory_missing(self, tmp_path, monkeypatch):
        """Test check_input_directory_populated when input directory doesn't exist"""
        dirs = self.setup_directory_structure(tmp_path)

        # Remove the input directory
        os.unlink(dirs["sample_file"])
        os.rmdir(dirs["input"])

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        assert check_input_directory_populated() is False

    def test_check_logs_for_errors_clean_log(self, tmp_path, monkeypatch, mock_env_vars):
        """Test check_logs_for_errors with a clean log file"""
        dirs = self.setup_directory_structure(tmp_path)

        # Create a clean log file
        log_file = dirs["output"] / "your_package_test_timestamp.log"
        log_file.write_text("INFO: Everything is fine\nDEBUG: Some debug info")

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        assert check_logs_for_errors() is True

    @pytest.mark.parametrize("error_content,expected", [
        ("2023-05-21 10:15:30 root.ERROR: Something went wrong", False),
        ("2023-05-21 10:15:30 INFO: Started\nTraceback (most recent call last):\n  File...", False),
        ("2023-05-21 10:15:30 WARN: Warning message\nValueException: Invalid value", False),
        ("2023-05-21 10:15:30 INFO: Normal log with Exception word in text", False),
    ])
    def test_check_logs_for_errors_with_errors(self, tmp_path, monkeypatch, mock_env_vars, error_content, expected):
        """Test check_logs_for_errors with different error patterns in log file"""
        dirs = self.setup_directory_structure(tmp_path)

        # Create a log file with error content
        log_file = dirs["output"] / "your_package_test_timestamp.log"
        log_file.write_text(error_content)

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        assert check_logs_for_errors() is expected

    def test_check_logs_for_errors_no_log_file(self, tmp_path, monkeypatch, mock_env_vars):
        """Test check_logs_for_errors when log file doesn't exist"""
        dirs = self.setup_directory_structure(tmp_path)

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        assert check_logs_for_errors() is False

    def test_check_logs_for_errors_permission_error(self, tmp_path, monkeypatch, mock_env_vars):
        """Test check_logs_for_errors when there's a permission error reading the log"""
        dirs = self.setup_directory_structure(tmp_path)

        # Create a log file
        log_file = dirs["output"] / "your_package_test_timestamp.log"
        log_file.write_text("INFO: Everything is fine")

        # Change working directory to the temp path
        monkeypatch.chdir(dirs["root"])

        # Mock open to raise permission error
        m = mock_open()
        m.side_effect = PermissionError("Permission denied")

        with patch("builtins.open", m):
            assert check_logs_for_errors() is False