# CI/CD Workflows

This directory contains GitHub Actions workflows for automated testing.

## Workflows

### python-test.yml

Automated testing workflow for Python modules that:

1. **Detects versions to test** based on:
   - Pre-release files in PR (e.g., `bearsampp-python-3.13.5-2025.8.21.7z`)
   - Version numbers in PR titles (fallback)
   - Manual workflow dispatch with specific version

2. **Tests each Python version** through multiple phases:
   - **Phase 1.1**: Download and extract Python module
   - **Phase 1.2**: Verify Python installation and executables
   - **Phase 2**: Test basic functionality (version, pip, imports)

3. **Reports results**:
   - Generates test summary with badges
   - Comments on pull requests
   - Uploads test artifacts

## Triggering Tests

### Automatic Triggers

Tests run automatically when:

- **Push to main**: Tests latest version only
- **Pull Request with pre-release files**: Tests versions detected from `.7z` filenames
- **Pull Request with version in title**: Tests versions mentioned in PR title (fallback)
- **Manual workflow dispatch**: Tests specified version or all versions

### Manual Trigger

You can manually trigger tests:

1. Go to the Actions tab
2. Select "Python Module Tests"
3. Click "Run workflow"
4. Optionally specify a version to test

### PR Title Format

To test specific versions in a PR, include version numbers in the title:

- ✅ `Add Python 3.13.5 support`
- ✅ `Update docs for 3.12.9`
- ✅ `Fix issue with Python 3.13.3 and 3.12.6.0`
- ❌ `Update documentation` (no version, won't trigger tests unless releases.properties changed)

## Test Phases

### Phase 1: Installation Validation

**Phase 1.1 - Download and Extract**
- Reads version from `releases.properties`
- Downloads the `.7z` archive
- Extracts to test directory
- Verifies Python directory structure

**Phase 1.2 - Verify Executables**
- Checks for `python.exe`
- Checks for `pip.exe` (in root or Scripts directory)
- Validates executable paths

### Phase 2: Basic Functionality

- Tests `python --version`
- Tests `pip --version` (via `python -m pip`)
- Tests Python import system
- Validates all critical components work

## Test Results

### Artifacts

Test results are uploaded as artifacts:

- `test-results-python-{version}`: Individual version test results

Artifacts are retained for 30 days.

### PR Comments

For pull requests, the workflow posts a comment with:

- Overall test status
- Version-specific badges (PASS/FAIL)
- Detailed results for failed tests
- Links to artifacts

### Status Badges

Each version gets a badge:

- 🟢 ![PASS](https://img.shields.io/badge/Python_3.13.5-PASS-success?style=flat-square&logo=python&logoColor=white)
- 🔴 ![FAIL](https://img.shields.io/badge/Python_3.13.5-FAIL-critical?style=flat-square&logo=python&logoColor=white)
- ⚪ ![NO RESULTS](https://img.shields.io/badge/Python_3.13.5-NO_RESULTS-inactive?style=flat-square&logo=python&logoColor=white)

## Configuration

### releases.properties Format

```properties
# Version = Download URL
3.13.5 = https://github.com/Bearsampp/module-python/releases/download/2025.8.21/bearsampp-python-3.13.5-2025.8.21.7z
3.12.9 = https://github.com/Bearsampp/module-python/releases/download/2025.4.19/bearsampp-python-3.12.9-2025.4.19.7z
```

### Required Archive Structure

The `.7z` archive must contain:

```
bearsampp-python-X.X.X-YYYY.MM.DD.7z
└── python-X.X.X/
    ├── python.exe          # Required
    ├── python3.dll         # Required
    ├── python3XX.dll       # Required
    ├── Scripts/
    │   └── pip.exe        # Optional but recommended
    └── Lib/               # Required
```

## Troubleshooting

### Tests Not Running

**Problem**: Tests skipped on PR

**Solutions**:
- Add version number to PR title
- Modify `releases.properties`
- Manually trigger workflow

### Download Failures

**Problem**: Download fails with 404

**Solutions**:
- Verify URL in `releases.properties` is correct
- Check that release exists on GitHub
- Ensure URL is publicly accessible

### Extraction Failures

**Problem**: Archive extraction fails

**Solutions**:
- Verify `.7z` archive is valid
- Check archive structure matches expected format
- Ensure archive is not corrupted

### Executable Not Found

**Problem**: `python.exe` not found after extraction

**Solutions**:
- Verify archive contains `python-X.X.X/` directory
- Check that `python.exe` is in the root of that directory
- Ensure extraction completed successfully

## Permissions

The workflow requires these permissions:

- `contents: read` - Read repository contents
- `pull-requests: write` - Comment on PRs
- `issues: write` - Update issue comments

## Best Practices

1. **Test locally first**: Verify changes work before pushing
2. **Use descriptive PR titles**: Include version numbers when relevant
3. **Check workflow logs**: Review detailed logs for failures
4. **Update documentation**: Keep docs in sync with code changes
5. **Monitor artifacts**: Download and review test results

## Support

For issues with the CI/CD workflow:

1. Check workflow logs in the Actions tab
2. Review this README for troubleshooting tips
3. Open an issue with workflow run details
4. Include error messages and relevant logs
