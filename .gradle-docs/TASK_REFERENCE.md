# Task Reference

Complete reference for all Gradle tasks available in the Bearsampp Python module build system.

## Task Groups

- [Build Tasks](#build-tasks)
- [Verification Tasks](#verification-tasks)
- [Help Tasks](#help-tasks)

---

## Build Tasks

### release

Build a release package for a specific Python version.

**Group**: build

**Description**: Build release package (interactive or use -PbundleVersion=X.X.X for non-interactive)

**Usage**:
```bash
# Interactive mode - lists available versions
gradle release

# Non-interactive mode - specify version
gradle release "-PbundleVersion=3.13.5"
```

**Parameters**:
- `bundleVersion` (optional): Python version to build (e.g., "3.13.5")

**Process**:
1. Validates Python version exists in `bin/` directory
2. Creates temporary build directory
3. Copies bundle files (excludes pyqt5)
4. Upgrades PIP to latest version
5. Downloads wheel packages from wheel.properties
6. Installs wheel packages using install.bat
7. Creates 7z archive in release directory
8. Cleans up temporary files

**Output**:
- Release archive: `{buildPath}/release/python{version}.7z`

**Example**:
```bash
gradle release "-PbundleVersion=3.13.5"
```

**Exit Codes**:
- 0: Success
- 1: Version not found
- 2: PIP upgrade failed
- 3: Wheel installation failed
- 4: Archive creation failed

---

### clean

Clean build artifacts and temporary files.

**Group**: build

**Description**: Clean build artifacts and temporary files

**Usage**:
```bash
gradle clean
```

**Cleans**:
- `build/` directory (Gradle build output)
- Temporary build directories in configured build path

**Example**:
```bash
gradle clean
```

---

## Verification Tasks

### verify

Verify build environment and dependencies.

**Group**: verification

**Description**: Verify build environment and dependencies

**Usage**:
```bash
gradle verify
```

**Checks**:
- ✓ Java 8+ installed
- ✓ build.gradle exists
- ✓ build.properties exists
- ✓ releases.properties exists
- ✓ dev directory exists
- ✓ bin directory exists
- ✓ Python versions available
- ✓ 7-Zip command available

**Output**:
```
Environment Check Results:
------------------------------------------------------------
  [PASS]     Java 8+
  [PASS]     build.gradle
  [PASS]     build.properties
  [PASS]     releases.properties
  [PASS]     dev directory
  [PASS]     bin directory
  [PASS]     Python versions available
  [PASS]     7-Zip available
------------------------------------------------------------

[SUCCESS] All checks passed! Build environment is ready.
```

**Example**:
```bash
gradle verify
```

---

### validateProperties

Validate build.properties configuration.

**Group**: verification

**Description**: Validate build.properties configuration

**Usage**:
```bash
gradle validateProperties
```

**Validates**:
- `bundle.name` is present and not empty
- `bundle.release` is present and not empty
- `bundle.type` is present and not empty
- `bundle.format` is present and not empty

**Output**:
```
Validating build.properties...
[SUCCESS] All required properties are present:
    bundle.name = python
    bundle.release = 2025.8.21
    bundle.type = tools
    bundle.format = 7z
```

**Example**:
```bash
gradle validateProperties
```

---

### validatePythonVersion

Validate Python version directory structure.

**Group**: verification

**Description**: Validate Python version directory structure (use -PbundleVersion=X.X.X)

**Usage**:
```bash
gradle validatePythonVersion "-PbundleVersion=3.13.5"
```

**Parameters**:
- `bundleVersion` (required): Python version to validate

**Checks**:
- ✓ Version directory exists
- ✓ bin/ subdirectory exists
- ✓ wheel/ subdirectory exists
- ✓ bearsampp.conf file exists
- ✓ bin/python.bat file exists
- ✓ wheel.properties file exists
- ✓ install.bat file exists
- ✓ Wheel URL is defined in wheel.properties

**Output**:
```
Validating Python version 3.13.5...
------------------------------------------------------------

Validation Results:
------------------------------------------------------------
  [PASS]     bin directory
  [PASS]     wheel directory
  [PASS]     bearsampp.conf
  [PASS]     bin/python.bat
  [PASS]     wheel.properties
  [PASS]     install.bat
  [PASS]     wheel URL defined
------------------------------------------------------------

[SUCCESS] Python version 3.13.5 structure is valid
```

**Example**:
```bash
gradle validatePythonVersion "-PbundleVersion=3.13.5"
```

---

## Help Tasks

### info

Display build configuration information.

**Group**: help

**Description**: Display build configuration information

**Usage**:
```bash
gradle info
```

**Displays**:
- Project name, version, description
- Bundle properties (name, release, type, format)
- Path configuration
- Java version and home
- Gradle version and home
- Python build features
- Available task groups
- Quick start commands

**Example**:
```bash
gradle info
```

---

### listVersions

List all available Python bundle versions in bin/ directory.

**Group**: help

**Description**: List all available Python bundle versions in bin/ directory

**Usage**:
```bash
gradle listVersions
```

**Output**:
```
Available python versions in bin/:
------------------------------------------------------------
  3.10.6
  3.10.9
  3.11.5
  3.11.8
  3.12.2
  3.12.9 [wheel: PyQt5-5.15.9-cp312-cp312-win_amd64.whl]
  3.13.2
  3.13.3
  3.13.5 [wheel: PyQt5-5.15.9-cp313-cp313-win_amd64.whl]
------------------------------------------------------------
Total versions: 9

To build a specific version:
  gradle release "-PbundleVersion=3.13.5"
```

**Example**:
```bash
gradle listVersions
```

---

### listReleases

List all available releases from releases.properties.

**Group**: help

**Description**: List all available releases from releases.properties

**Usage**:
```bash
gradle listReleases
```

**Output**:
```
Available Python Releases:
--------------------------------------------------------------------------------
  3.10.6          -> https://www.python.org/ftp/python/3.10.6/python-3.10.6-amd64.exe
  3.10.9          -> https://www.python.org/ftp/python/3.10.9/python-3.10.9-amd64.exe
  3.11.5          -> https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe
  ...
--------------------------------------------------------------------------------
Total releases: 12
```

**Example**:
```bash
gradle listReleases
```

---

### showWheelInfo

Display wheel package information for a Python version.

**Group**: help

**Description**: Display wheel package information for a Python version (use -PbundleVersion=X.X.X)

**Usage**:
```bash
gradle showWheelInfo "-PbundleVersion=3.13.5"
```

**Parameters**:
- `bundleVersion` (required): Python version to check

**Output**:
```
Wheel Information for Python 3.13.5:
======================================================================
  Wheel URL:  https://files.pythonhosted.org/packages/.../PyQt5-5.15.9-cp313-cp313-win_amd64.whl
  Wheel File: PyQt5-5.15.9-cp313-cp313-win_amd64.whl
  Location:   E:/Bearsampp-development/module-python/bin/python3.13.5/wheel

  Install Script: E:/Bearsampp-development/module-python/bin/python3.13.5/wheel/install.bat
  Content:
  ------------------------------------------------------------------
  @echo off
  cd ..
  bin\python.bat -m pip install wheel\PyQt5-5.15.9-cp313-cp313-win_amd64.whl
======================================================================
```

**Example**:
```bash
gradle showWheelInfo "-PbundleVersion=3.13.5"
```

---

### tasks

List all available tasks (built-in Gradle task).

**Group**: help

**Description**: Displays the tasks runnable from root project 'module-python'

**Usage**:
```bash
# List main tasks
gradle tasks

# List all tasks including internal tasks
gradle tasks --all
```

**Example**:
```bash
gradle tasks
```

---

## Task Dependencies

### Dependency Graph

```
release
  (no dependencies)

clean
  (no dependencies)

verify
  (no dependencies)

validateProperties
  (no dependencies)

validatePythonVersion
  (no dependencies)

info
  (no dependencies)

listVersions
  (no dependencies)

listReleases
  (no dependencies)

showWheelInfo
  (no dependencies)
```

---

## Common Task Combinations

### Full Build Workflow

```bash
# 1. Verify environment
gradle verify

# 2. List available versions
gradle listVersions

# 3. Validate specific version
gradle validatePythonVersion "-PbundleVersion=3.13.5"

# 4. Build release
gradle release "-PbundleVersion=3.13.5"
```

### Development Workflow

```bash
# Check configuration
gradle validateProperties

# View build info
gradle info

# Build and test
gradle release "-PbundleVersion=3.13.5"

# Clean up
gradle clean
```

### Troubleshooting Workflow

```bash
# Verify environment
gradle verify

# Check version structure
gradle validatePythonVersion "-PbundleVersion=3.13.5"

# Check wheel configuration
gradle showWheelInfo "-PbundleVersion=3.13.5"

# Try build with debug output
gradle release "-PbundleVersion=3.13.5" --debug
```

---

## Task Options

### Global Options

These options work with any task:

```bash
# Show stack traces
gradle <task> --stacktrace

# Show full stack traces
gradle <task> --full-stacktrace

# Debug output
gradle <task> --debug

# Info output
gradle <task> --info

# Quiet output
gradle <task> --quiet

# Dry run (don't execute)
gradle <task> --dry-run

# Continue on failure
gradle <task> --continue

# Refresh dependencies
gradle <task> --refresh-dependencies

# No daemon
gradle <task> --no-daemon

# Offline mode
gradle <task> --offline
```

### Performance Options

```bash
# Parallel execution
gradle <task> --parallel

# Max workers
gradle <task> --max-workers=4

# Build cache
gradle <task> --build-cache

# No build cache
gradle <task> --no-build-cache

# Configuration cache
gradle <task> --configuration-cache

# No configuration cache
gradle <task> --no-configuration-cache
```

---

## Exit Codes

All tasks follow standard exit code conventions:

- **0**: Success
- **1**: General error
- **2**: Configuration error
- **3**: Execution error
- **4**: Validation error

---

## Task Output

### Success Output

```
================================================================
  Bearsampp Module Python - Pure Gradle Build
================================================================

Building release for python version 3.13.5...
======================================================================
Bundle path: E:/Bearsampp-development/module-python/bin/python3.13.5

Python-specific build steps:
  1. Copying bundle files...
  2. Upgrading PIP to latest version...
  3. Processing wheel packages...
     Downloading: PyQt5-5.15.9-cp313-cp313-win_amd64.whl
     Installing wheel packages...
  4. Creating release archive...

======================================================================
[SUCCESS] Release build completed successfully for version 3.13.5
Release file: C:/Users/user/Bearsampp-build/release/python3.13.5.7z
======================================================================
```

### Error Output

```
FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':release'.
> Bundle version not found: E:/Bearsampp-development/module-python/bin/python3.13.5

Available versions in bin/:
  - 3.12.9
  - 3.13.3

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.
```

---

## See Also

- [Getting Started Guide](GETTING_STARTED.md)
- [Build System Guide](BUILD_SYSTEM.md)
- [Configuration Guide](CONFIGURATION.md)
- [Gradle Documentation](https://docs.gradle.org/)
