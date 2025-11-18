# Getting Started with Bearsampp Module Python Build

This guide will help you get started with building the Bearsampp Python module using Gradle.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Java Development Kit (JDK) 8 or higher**
   - Required to run Gradle
   - Check version: `java -version`

2. **Gradle 7.0 or higher**
   - Install from: https://gradle.org/install/
   - Check version: `gradle --version`
   - **Note**: This project uses pure Gradle without wrapper scripts

3. **7-Zip**
   - Required for creating release archives
   - Install from: https://www.7-zip.org/
   - Ensure `7z` command is available in your PATH

4. **Python**
   - Python versions should be placed in the `bin/` directory
   - Each version should follow the naming convention: `python{version}`
   - Example: `bin/python3.13.5/`

## Project Structure

```
module-python/
├── bin/                          # Python version directories
│   ├── python3.13.5/
│   │   ├── bin/
│   │   │   └── python.bat
│   │   ├── wheel/
│   │   │   ├── wheel.properties
│   │   │   └── install.bat
│   │   └── bearsampp.conf
│   └── python3.12.9/
├── build.gradle                  # Main Gradle build script
├── settings.gradle               # Gradle settings
├── gradle.properties             # Gradle configuration
├── build.properties              # Bundle configuration
└── releases.properties           # Available releases
```

## Quick Start

### 1. Verify Your Environment

First, verify that your build environment is properly configured:

```bash
gradle verify
```

This will check:
- Java version
- Required files
- Dev directory structure
- Available Python versions
- 7-Zip availability

### 2. List Available Python Versions

To see which Python versions are available for building:

```bash
gradle listVersions
```

### 3. Build a Release

To build a release for a specific Python version:

```bash
gradle release "-PbundleVersion=3.13.5"
```

Or run interactively to see available versions:

```bash
gradle release
```

### 4. View Build Information

To display detailed build configuration:

```bash
gradle info
```

## Common Tasks

### List All Available Tasks

```bash
gradle tasks
```

### Clean Build Artifacts

```bash
gradle clean
```

### Validate Build Properties

```bash
gradle validateProperties
```

### Validate Python Version Structure

```bash
gradle validatePythonVersion "-PbundleVersion=3.13.5"
```

### Show Wheel Package Information

```bash
gradle showWheelInfo "-PbundleVersion=3.13.5"
```

### List Available Releases

```bash
gradle listReleases
```

## Build Process

When you run `gradle release`, the following steps are executed:

1. **Validation**: Verifies the specified Python version exists
2. **Copy Files**: Copies bundle files to temporary directory
3. **Upgrade PIP**: Upgrades PIP to the latest version
4. **Download Wheels**: Downloads wheel packages specified in `wheel.properties`
5. **Install Wheels**: Installs wheel packages using `install.bat`
6. **Create Archive**: Creates a 7z archive of the bundle
7. **Cleanup**: Removes temporary files

## Configuration Files

### build.properties

Main bundle configuration:

```properties
bundle.name = python
bundle.release = 2025.8.21
bundle.type = tools
bundle.format = 7z
```

### gradle.properties

Gradle build configuration:

```properties
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m
```

### wheel.properties

Located in each Python version's `wheel/` directory:

```properties
wheel=https://example.com/path/to/wheel-package.whl
```

## Troubleshooting

### Build Fails with "Dev path not found"

Ensure the `dev` project exists in the parent directory:
```
Bearsampp-development/
├── module-python/
└── dev/
```

### Build Fails with "7-Zip not found"

Install 7-Zip and ensure the `7z` command is in your PATH.

### Python Version Not Found

Ensure the Python version directory exists in `bin/` and follows the naming convention:
```
bin/python{version}/
```

### PIP Upgrade Fails

Ensure the Python installation is valid and `bin/python.bat` exists.

## Next Steps

- Read the [Build System Guide](BUILD_SYSTEM.md) for detailed information
- Check [Task Reference](TASK_REFERENCE.md) for all available tasks
- See [Configuration Guide](CONFIGURATION.md) for advanced configuration options

## Getting Help

- View all tasks: `gradle tasks --all`
- View build info: `gradle info`
- Check environment: `gradle verify`

For issues, please report on the [Bearsampp repository](https://github.com/bearsampp/bearsampp/issues).
