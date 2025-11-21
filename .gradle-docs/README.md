# Gradle Build System Documentation

Complete documentation for the Bearsampp Python module Gradle build system.

## Overview

This directory contains comprehensive documentation for building the Bearsampp Python module using pure Gradle (no wrapper, no Ant dependencies).

## Documentation Structure

### 🚀 [Quick Reference Card](QUICK_REFERENCE.md)

**Essential commands and quick tips.**

- Essential commands (build, verify, info)
- Common workflows
- Configuration file examples
- Task groups overview
- Gradle options
- Quick tips

**Best for**: Quick lookup, command reference

### 📘 [Getting Started Guide](GETTING_STARTED.md)

**Start here if you're new to the build system.**

- Prerequisites and installation
- Project structure overview
- Quick start guide
- Common tasks
- Build process explanation
- Configuration files overview
- Troubleshooting basics

**Best for**: First-time users, setup and installation

### 🏗️ [Build System Guide](BUILD_SYSTEM.md)

**Deep dive into the build system architecture.**

- Build system overview
- Architecture and components
- Build tasks in detail
- Build lifecycle
- Advanced features (caching, parallel execution)
- Customization options
- Performance optimization
- Troubleshooting and debugging

**Best for**: Understanding how the build works, advanced usage

### 📋 [Task Reference](TASK_REFERENCE.md)

**Complete reference for all available tasks.**

- Build tasks (release, clean)
- Verification tasks (verify, validate*)
- Help tasks (info, list*, show*)
- Task parameters and options
- Task dependencies
- Common task combinations
- Exit codes and output

**Best for**: Quick reference, finding specific tasks

### ⚙️ [Configuration Guide](CONFIGURATION.md)

**Detailed configuration options and settings.**

- Configuration files (build.properties, gradle.properties, etc.)
- Python version configuration
- Build path configuration
- Archive format options
- JVM configuration
- Performance tuning
- Environment variables
- Advanced configuration

**Best for**: Customizing the build, performance tuning

## Quick Reference

### Essential Commands

```bash
# Verify environment
gradle verify

# List available Python versions
gradle listVersions

# Build a release
gradle release "-PbundleVersion=3.13.5"

# Clean build artifacts
gradle clean

# View build information
gradle info

# List all tasks
gradle tasks
```

### Key Files

| File | Purpose |
|------|---------|
| `build.gradle` | Main build script |
| `settings.gradle` | Gradle settings |
| `gradle.properties` | Gradle configuration |
| `build.properties` | Bundle configuration |
| `releases.properties` | Available Python releases |

### Directory Structure

```
module-python/
├── .gradle-docs/          # This documentation
├── bin/                   # Python versions
│   └── python{version}/
│       ├── bin/
│       ├── wheel/
│       └── bearsampp.conf
├── build.gradle           # Build script
├── settings.gradle        # Settings
├── gradle.properties      # Gradle config
└── build.properties       # Bundle config
```

## Documentation Index

### By Topic

#### Getting Started
- [Prerequisites](GETTING_STARTED.md#prerequisites)
- [Quick Start](GETTING_STARTED.md#quick-start)
- [Common Tasks](GETTING_STARTED.md#common-tasks)

#### Build Tasks
- [Release Task](TASK_REFERENCE.md#release)
- [Clean Task](TASK_REFERENCE.md#clean)
- [Build Process](BUILD_SYSTEM.md#build-tasks)

#### Configuration
- [Build Properties](CONFIGURATION.md#buildproperties)
- [Gradle Properties](CONFIGURATION.md#gradleproperties)
- [Python Version Config](CONFIGURATION.md#python-version-configuration)

#### Verification
- [Environment Verification](TASK_REFERENCE.md#verify)
- [Property Validation](TASK_REFERENCE.md#validateproperties)
- [Version Validation](TASK_REFERENCE.md#validatepythonversion)

#### Advanced Topics
- [Build System Architecture](BUILD_SYSTEM.md#architecture)
- [Performance Optimization](BUILD_SYSTEM.md#performance-optimization)
- [Custom Tasks](BUILD_SYSTEM.md#customization)

### By User Type

#### New Users
1. [Getting Started Guide](GETTING_STARTED.md)
2. [Quick Start](GETTING_STARTED.md#quick-start)
3. [Common Tasks](GETTING_STARTED.md#common-tasks)

#### Developers
1. [Build System Guide](BUILD_SYSTEM.md)
2. [Task Reference](TASK_REFERENCE.md)
3. [Configuration Guide](CONFIGURATION.md)

#### Build Engineers
1. [Build System Architecture](BUILD_SYSTEM.md#architecture)
2. [Performance Optimization](BUILD_SYSTEM.md#performance-optimization)
3. [Advanced Configuration](CONFIGURATION.md#advanced-configuration)

## Features

### Pure Gradle Build
- ✅ No Gradle wrapper scripts
- ✅ No Ant dependencies
- ✅ Native Gradle implementation
- ✅ Modern build practices

### Python-Specific Features
- ✅ Automatic PIP upgrades
- ✅ Wheel package management
- ✅ Multiple version support
- ✅ PyQt5 exclusion handling

### Build Features
- ✅ Incremental builds
- ✅ Build caching
- ✅ Parallel execution
- ✅ Configuration cache
- ✅ Interactive & non-interactive modes

### Verification Features
- ✅ Environment verification
- ✅ Property validation
- ✅ Version structure validation
- ✅ Dependency checking

## Common Workflows

### First-Time Setup

```bash
# 1. Verify environment
gradle verify

# 2. View available versions
gradle listVersions

# 3. Validate a version
gradle validatePythonVersion "-PbundleVersion=3.13.5"

# 4. Build release
gradle release "-PbundleVersion=3.13.5"
```

### Daily Development

```bash
# Check configuration
gradle validateProperties

# Build release
gradle release "-PbundleVersion=3.13.5"

# Clean up
gradle clean
```

### Troubleshooting

```bash
# Verify environment
gradle verify

# Check version structure
gradle validatePythonVersion "-PbundleVersion=3.13.5"

# Check wheel info
gradle showWheelInfo "-PbundleVersion=3.13.5"

# Build with debug output
gradle release "-PbundleVersion=3.13.5" --debug
```

## Migration from Ant

This build system replaces the previous Ant-based build:

### What Changed
- ❌ Removed: `build.xml` (Ant build file)
- ❌ Removed: Ant task imports
- ❌ Removed: Ant dependencies
- ✅ Added: Pure Gradle implementation
- ✅ Added: Native Gradle tasks
- ✅ Added: Comprehensive documentation

### Migration Benefits
- Faster builds with caching
- Better dependency management
- Modern build practices
- Improved maintainability
- Better IDE integration

### Compatibility
- Same build output
- Same directory structure
- Same Python version support
- Same wheel package handling

## Requirements

### Software Requirements
- Java 8 or higher
- Gradle 7.0 or higher
- 7-Zip (for archive creation)
- Python (versions in bin/ directory)

### System Requirements
- Windows (primary platform)
- 2GB RAM minimum (4GB recommended)
- 1GB free disk space

## Support

### Getting Help

1. **Check Documentation**: Start with the [Getting Started Guide](GETTING_STARTED.md)
2. **Run Verification**: Use `gradle verify` to check your environment
3. **View Task Help**: Use `gradle tasks` to see available tasks
4. **Debug Output**: Use `--debug` or `--stacktrace` for detailed output

### Reporting Issues

For issues, please report on the [Bearsampp repository](https://github.com/bearsampp/bearsampp/issues).

Include:
- Gradle version (`gradle --version`)
- Java version (`java -version`)
- Error message and stack trace
- Steps to reproduce

## Contributing

### Documentation Contributions

To improve this documentation:

1. Edit the relevant `.md` file
2. Follow the existing structure and style
3. Test any code examples
4. Submit a pull request

### Build System Contributions

To contribute to the build system:

1. Read the [Build System Guide](BUILD_SYSTEM.md)
2. Test changes thoroughly
3. Update documentation
4. Submit a pull request

## Version History

### 2025.8.21
- Initial pure Gradle implementation
- Removed Ant dependencies
- Added comprehensive documentation
- Added verification tasks
- Added Python-specific build features

## License

This documentation is part of the Bearsampp project.

See [LICENSE](../LICENSE) for details.

## Additional Resources

### External Links
- [Gradle Documentation](https://docs.gradle.org/)
- [Gradle Build Cache](https://docs.gradle.org/current/userguide/build_cache.html)
- [Gradle Performance](https://docs.gradle.org/current/userguide/performance.html)
- [Bearsampp Project](https://github.com/bearsampp/bearsampp)
- [Python Official Site](https://www.python.org/)

### Related Projects
- [Bearsampp](https://github.com/bearsampp/bearsampp) - Main project
- [module-php](https://github.com/Bearsampp/module-php) - PHP module (similar build system)

---

**Last Updated**: 2025-08-21

**Maintained By**: Bearsampp Team

**Questions?** Check the [Getting Started Guide](GETTING_STARTED.md) or open an issue.
