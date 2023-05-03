import os
import subprocess


def run_test(test_file):
    result = subprocess.run(
        ["./http09_parser", test_file], capture_output=True, text=True
    )
    return result.returncode, result.stdout


def test_passes(test_file):
    returncode, output = run_test(test_file)
    if returncode != 0:
        print(f"FAILED: {test_file}\n{output}")
        return False
    return True


def test_fails(test_file):
    returncode, output = run_test(test_file)
    if returncode == 0:
        print(f"FAILED: {test_file}\n{output}")
        return False
    return True


if __name__ == "__main__":
    test_root = "tests"

    should_pass_tests = os.listdir(os.path.join(test_root, "should_pass"))
    should_fail_tests = os.listdir(os.path.join(test_root, "should_fail"))

    all_tests_passed = True

    for test in should_pass_tests:
        test_file = os.path.join(test_root, "should_pass", test)
        if not test_passes(test_file):
            all_tests_passed = False

    for test in should_fail_tests:
        test_file = os.path.join(test_root, "should_fail", test)
        if not test_fails(test_file):
            all_tests_passed = False

    if all_tests_passed:
        print("All tests passed!")
    else:
        print("Some tests failed. Please check the output above.")
        exit(1)
