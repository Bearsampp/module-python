<p align="center"><a href="https://bearsampp.com/contribute" target="_blank"><img width="250" src="img/Bearsampp-logo.svg"></a></p>

<div align="center">

[![GitHub release](https://img.shields.io/github/release/bearsampp/module-python.svg?style=flat-square)](https://github.com/bearsampp/module-python/releases/latest)
![Total downloads](https://img.shields.io/github/downloads/bearsampp/module-python/total.svg?style=flat-square)
[![CI/CD Tests](https://img.shields.io/github/actions/workflow/status/bearsampp/module-python/python-test.yml?branch=main&label=tests&style=flat-square)](https://github.com/bearsampp/module-python/actions/workflows/python-test.yml)

</div>

# Bearsampp Module - Python

This is a module of [Bearsampp project](https://github.com/bearsampp/bearsampp) involving Python.

## About

This module provides Python integration for Bearsampp, supporting multiple Python versions with automatic PIP upgrades and wheel package management.

## Documentation and Downloads

https://bearsampp.com/module/python

## Build System

This module uses a pure Gradle build system (no wrapper, no Ant dependencies) for packaging Python releases.

### Quick Start

```bash
# Verify your build environment
gradle verify

# List available Python versions
gradle listVersions

# Build a release for a specific version
gradle release "-PbundleVersion=3.13.5"

# View all available tasks
gradle tasks
```

### Prerequisites

- Java 8 or higher
- Gradle 7.0 or higher
- 7-Zip (for archive creation)

### Documentation

Comprehensive build system documentation is available in the [`.gradle-docs/`](.gradle-docs/) directory:

- **[Getting Started Guide](.gradle-docs/GETTING_STARTED.md)** - Setup and basic usage
- **[Build System Guide](.gradle-docs/BUILD_SYSTEM.md)** - Detailed build system information
- **[Task Reference](.gradle-docs/TASK_REFERENCE.md)** - Complete task documentation
- **[Configuration Guide](.gradle-docs/CONFIGURATION.md)** - Configuration options and tuning

### Common Tasks

```bash
# Display build information
gradle info

# Verify build environment
gradle verify

# List available Python versions
gradle listVersions

# Build a release (interactive)
gradle release

# Build a release (non-interactive)
gradle release "-PbundleVersion=3.13.5"

# Clean build artifacts
gradle clean

# Validate Python version structure
gradle validatePythonVersion "-PbundleVersion=3.13.5"

# Show wheel package information
gradle showWheelInfo "-PbundleVersion=3.13.5"
```

## Features

- ✅ Pure Gradle build system (no wrapper, no Ant)
- ✅ Support for multiple Python versions
- ✅ Automatic PIP upgrades during build
- ✅ Wheel package download and installation
- ✅ Build caching for faster builds
- ✅ Parallel execution support
- ✅ Interactive and non-interactive build modes
- ✅ Comprehensive verification and validation tasks
- ✅ Automated CI/CD testing for all Python versions

## CI/CD System

This module includes automated CI/CD testing that validates Python modules.

### Automated Testing

The CI/CD pipeline automatically:

- 🔍 Detects Python versions from pre-release files in PRs
- 📥 Downloads and extracts Python modules
- ✅ Verifies executables (python.exe, pip.exe)
- 🧪 Tests basic functionality (version, pip, imports)
- 📊 Generates detailed test reports
- 💬 Comments on pull requests with results

### Triggering Tests

Tests run automatically when:
- Pull requests include pre-release `.7z` files (e.g., `bearsampp-python-3.13.5-2025.8.21.7z`)
- PR titles contain version numbers as fallback (e.g., "Add Python 3.13.5")
- Pushes to main branch (tests latest version only)
- Manual workflow dispatch

See [CI/CD Workflow Documentation](.github/workflows/README.md) for details.

## Project Structure

```
module-python/
├── .gradle-docs/          # Build system documentation
├── bin/                   # Python version directories
│   └── python{version}/
│       ├── bin/
│       ├── wheel/
│       └── bearsampp.conf
├── build.gradle           # Main build script
├── settings.gradle        # Gradle settings
├── gradle.properties      # Gradle configuration
├── build.properties       # Bundle configuration
└── releases.properties    # Available Python releases
```

## Issues

Issues must be reported on [Bearsampp repository](https://github.com/bearsampp/bearsampp/issues).

## Contributing

Contributions are welcome! Please read the build system documentation before contributing.

## License

See [LICENSE](LICENSE) file for details.
