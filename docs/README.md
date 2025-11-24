# CI/CD Workflows

This directory contains GitHub Actions workflows for automated testing.

## Workflows

### python-test.yml

Automated testing workflow for Python modules with **Smart Version Detection** that:

1. **Intelligently detects versions to test** using a three-tier approach:
   - **Primary Method**: Extracts version numbers from changed files in `/bin` directory (e.g., `bin/python3.19.1/`)
   - **Fallback Method**: Extracts version numbers from PR title if no `/bin` changes detected
   - **Final Fallback**: Tests the latest 5 versions if no versions detected by either method

2. **Tests each Python version** through multiple phases:
   - **Phase 1.1**: Download and extract Python module
   - **Phase 1.2**: Verify Python installation and executables
   - **Phase 2**: Test basic functionality (version, pip, imports)

3. **Reports results**:
   - Generates test summary with badges
   - Comments on pull requests
   - Uploads test artifacts

## Smart Version Detection

The workflow uses an intelligent three-tier detection system to identify which Python versions need testing:

### How It Works

When a PR is created from a pre-release branch (e.g., "November") to main:

1. **New versions are created** and added to a pre-release (tagged with date, e.g., "2025.11.23")
2. **Version directories are created** in `/bin` (e.g., `bin/python3.19.1/`, `bin/python3.25.0/`)
3. **The releases.properties file is updated** via the releases.properties workflow
4. **A PR is created** from the release branch to main
5. **This workflow detects changed files** in `/bin` and extracts version numbers from directory names
6. **Tests are run** against the version(s) found in releases.properties from that PR branch

### Typical Workflow Process

Here's how the smart detection works in a typical release workflow:

1. **Pre-release Creation**: New Python versions (e.g., 3.19.1, 3.25.0) are added to a pre-release tagged with the date (e.g., "2025.11.23")

2. **Directory Structure**: Version directories are created in `/bin`:
   ```
   bin/
   ├── python3.19.1/
   │   └── (version files)
   └── python3.25.0/
       └── (version files)
   ```

3. **Properties Update**: The `releases.properties` file is updated via the update-releases-properties workflow

4. **PR Creation**: A PR is created from a release branch (e.g., "November") to main

5. **Smart Detection**: The workflow automatically:
   - Scans changed files in the PR
   - Detects `bin/python3.19.1/` and `bin/python3.25.0/`
   - Extracts versions: `3.19.1` and `3.25.0`
   - Verifies these versions exist in `releases.properties`
   - Runs tests only for these 2 versions (not all versions)

6. **Efficiency**: Instead of testing 20+ versions, only the 2 new versions are tested, reducing CI time from 30+ minutes to ~10-20 minutes

### Detection Methods

#### 🥇 Primary Method: /bin Directory Detection

The workflow scans for changes in the `/bin` directory and extracts version numbers from directory names:

```
bin/python3.19.1/some-file.txt  →  Detects version: 3.19.1
bin/python3.25.0/another.txt    →  Detects version: 3.25.0
```

**Advantages:**
- Most accurate - directly tied to actual version changes
- Reduces CI runtime by testing only relevant versions
- Automatically handles multiple versions in a single PR

#### 🥈 Fallback Method: PR Title Detection

If no `/bin` changes are detected, the workflow extracts version numbers from the PR title:

```
"Add Python 3.13.5 support"     →  Detects version: 3.13.5
"Update 3.12.9 and 3.13.3"      →  Detects versions: 3.12.9, 3.13.3
```

**Use cases:**
- Documentation updates mentioning specific versions
- Configuration changes for specific versions
- Manual testing requests

#### 🥉 Final Fallback: Latest 5 Versions

If no versions are detected by either method, the workflow tests the latest 5 versions from releases.properties:

**Use cases:**
- General infrastructure changes
- Workflow updates
- Changes that might affect all versions

## Triggering Tests

### Automatic Triggers

Tests run automatically when:

- **Push to main**: Tests latest version only
- **Pull Request with /bin changes**: Tests versions detected from `/bin/pythonX.X.X/` directory names (Primary Method)
- **Pull Request with version in title**: Tests versions mentioned in PR title (Fallback Method)
- **Pull Request with other changes**: Tests latest 5 versions (Final Fallback)
- **Manual workflow dispatch**: Tests specified version

### Manual Trigger

You can manually trigger tests:

1. Go to the Actions tab
2. Select "Python Module Tests"
3. Click "Run workflow"
4. Optionally specify a version to test (e.g., `3.13.5`)

### PR Title Format (Fallback Method)

If your PR doesn't include `/bin` directory changes, you can trigger tests by including version numbers in the PR title:

- ✅ `Add Python 3.13.5 support`
- ✅ `Update docs for 3.12.9`
- ✅ `Fix issue with Python 3.13.3 and 3.12.6.0`
- ✅ `Documentation update` (will test latest 5 versions as final fallback)

### Efficiency Benefits

The smart detection system significantly reduces CI runtime:

- **Before**: All versions tested on every PR (~30+ minutes)
- **After**: Only relevant versions tested (~5-10 minutes per version)
- **Example**: PR with 2 new versions = ~10-20 minutes instead of 30+ minutes

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
