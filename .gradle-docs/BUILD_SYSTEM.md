# Build System Guide

This document provides detailed information about the Gradle build system for the Bearsampp Python module.

## Overview

The build system is implemented using pure Gradle (no wrapper) and provides:

- **Pure Gradle Build**: No Ant dependencies, fully native Gradle implementation
- **Python-Specific Features**: PIP upgrades, wheel package management
- **Multiple Version Support**: Build any Python version in the `bin/` directory
- **Incremental Builds**: Gradle caching for faster builds
- **Parallel Execution**: Multi-threaded build execution
- **Interactive & Non-Interactive Modes**: Flexible build workflows

## Architecture

### Build Script Structure

The main `build.gradle` file is organized into several sections:

1. **Plugin Configuration**: Base plugin for fundamental build capabilities
2. **Property Loading**: Loads configuration from `build.properties`
3. **Project Configuration**: Sets up project metadata and paths
4. **Task Definitions**: Defines all build, verification, and help tasks
5. **Lifecycle Hooks**: Configures build lifecycle events

### Key Components

#### Properties Management

The build system uses multiple property sources:

- **build.properties**: Bundle configuration (name, version, type, format)
- **gradle.properties**: Gradle daemon and JVM settings
- **releases.properties**: Available Python release versions
- **wheel.properties**: Wheel package URLs (per Python version)

#### Path Configuration

```groovy
ext {
    projectBasedir = projectDir.absolutePath
    rootDir = projectDir.parent
    devPath = file("${rootDir}/dev").absolutePath
    buildPath = "${System.getProperty('user.home')}/Bearsampp-build"
    tmpPath = "${buildPath}/tmp"
    releasePath = "${buildPath}/release"
}
```

## Build Tasks

### Core Build Tasks

#### release

Main task for building release packages.

**Usage:**
```bash
# Interactive mode (lists available versions)
gradle release

# Non-interactive mode (specify version)
gradle release "-PbundleVersion=3.13.5"
```

**Process:**
1. Validates Python version exists
2. Creates temporary build directory
3. Copies bundle files (excludes pyqt5)
4. Upgrades PIP to latest version
5. Downloads wheel packages
6. Installs wheel packages
7. Creates 7z archive
8. Cleans up temporary files

**Properties:**
- `bundleVersion`: Python version to build (e.g., "3.13.5")

#### clean

Removes build artifacts and temporary files.

**Usage:**
```bash
gradle clean
```

**Cleans:**
- `build/` directory
- Temporary build directories in configured build path

### Verification Tasks

#### verify

Comprehensive environment verification.

**Usage:**
```bash
gradle verify
```

**Checks:**
- Java version (8+)
- Required files (build.gradle, build.properties, releases.properties)
- Dev directory structure
- Python versions in bin/
- 7-Zip availability

#### validateProperties

Validates build.properties configuration.

**Usage:**
```bash
gradle validateProperties
```

**Validates:**
- bundle.name
- bundle.release
- bundle.type
- bundle.format

#### validatePythonVersion

Validates Python version directory structure.

**Usage:**
```bash
gradle validatePythonVersion "-PbundleVersion=3.13.5"
```

**Checks:**
- Version directory exists
- bin/ subdirectory
- wheel/ subdirectory
- bearsampp.conf file
- bin/python.bat file
- wheel.properties file
- install.bat file
- Wheel URL configuration

### Information Tasks

#### info

Displays comprehensive build information.

**Usage:**
```bash
gradle info
```

**Shows:**
- Project metadata
- Bundle properties
- Path configuration
- Java version
- Gradle version
- Available features
- Quick start commands

#### listVersions

Lists available Python versions in bin/ directory.

**Usage:**
```bash
gradle listVersions
```

**Output:**
- All Python versions found
- Wheel package information (if available)
- Example build command

#### listReleases

Lists all releases from releases.properties.

**Usage:**
```bash
gradle listReleases
```

**Output:**
- Version numbers
- Download URLs
- Total count

#### showWheelInfo

Displays wheel package information for a specific version.

**Usage:**
```bash
gradle showWheelInfo "-PbundleVersion=3.13.5"
```

**Shows:**
- Wheel URL
- Wheel filename
- Wheel directory location
- Install script content

## Build Configuration

### Gradle Properties

Configure Gradle behavior in `gradle.properties`:

```properties
# Enable Gradle daemon for faster builds
org.gradle.daemon=true

# Enable parallel execution
org.gradle.parallel=true

# Enable build caching
org.gradle.caching=true

# JVM settings
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError

# Console output
org.gradle.console=auto
org.gradle.warning.mode=all
```

### Bundle Properties

Configure bundle in `build.properties`:

```properties
# Bundle identification
bundle.name = python
bundle.release = 2025.8.21
bundle.type = tools
bundle.format = 7z

# Optional: Custom build path
#build.path = C:/Bearsampp-build
```

### Settings Configuration

Configure Gradle features in `settings.gradle`:

```groovy
rootProject.name = 'module-python'

// Enable stable configuration cache
enableFeaturePreview('STABLE_CONFIGURATION_CACHE')

// Configure build cache
buildCache {
    local {
        enabled = true
        directory = file("${rootDir}/.gradle/build-cache")
    }
}
```

## Python Version Structure

Each Python version in `bin/` must follow this structure:

```
bin/python{version}/
├── bin/
│   ├── python.bat          # Python launcher script
│   └── python.exe          # Python executable
├── wheel/
│   ├── wheel.properties    # Wheel package URL
│   └── install.bat         # Wheel installation script
├── bearsampp.conf          # Bearsampp configuration
└── [other Python files]
```

### wheel.properties Format

```properties
wheel=https://example.com/path/to/package.whl
```

### install.bat Example

```batch
@echo off
python.bat -m pip install wheel-package.whl
```

## Build Lifecycle

### Task Execution Order

When running `gradle release`:

1. **Initialization Phase**
   - Load settings.gradle
   - Configure build cache
   - Initialize project

2. **Configuration Phase**
   - Load build.gradle
   - Load properties files
   - Configure tasks
   - Validate environment

3. **Execution Phase**
   - Execute release task
   - Run Python-specific steps
   - Create archive
   - Clean up

### Lifecycle Hooks

```groovy
gradle.taskGraph.whenReady { graph ->
    // Executed when task graph is ready
    println "Starting Bearsampp Module Python Build"
}
```

## Advanced Features

### Build Caching

Gradle caching is enabled by default:

- **Local Cache**: `.gradle/build-cache/`
- **Configuration Cache**: Speeds up configuration phase
- **Task Output Caching**: Reuses task outputs when inputs haven't changed

### Parallel Execution

Multiple tasks can run in parallel when enabled:

```properties
org.gradle.parallel=true
```

### Incremental Builds

Gradle tracks task inputs and outputs:

- Only runs tasks when inputs change
- Skips up-to-date tasks
- Provides "FROM-CACHE" indicators

## Customization

### Custom Build Path

Override the default build path:

```properties
# In build.properties
build.path = D:/CustomBuildPath
```

### Custom Archive Format

Change the archive format:

```properties
# In build.properties
bundle.format = zip
```

Supported formats: 7z, zip, tar, tar.gz

### Adding Custom Tasks

Add custom tasks to `build.gradle`:

```groovy
tasks.register('myCustomTask') {
    group = 'custom'
    description = 'My custom task'
    
    doLast {
        println "Executing custom task"
    }
}
```

## Performance Optimization

### JVM Tuning

Adjust JVM settings for better performance:

```properties
# Increase heap size for large builds
org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=1g

# Enable G1GC for better garbage collection
org.gradle.jvmargs=-Xmx2g -XX:+UseG1GC
```

### Daemon Configuration

The Gradle daemon improves build performance:

```properties
# Enable daemon (default)
org.gradle.daemon=true

# Daemon idle timeout (milliseconds)
org.gradle.daemon.idletimeout=3600000
```

### Build Cache

Optimize cache settings:

```groovy
buildCache {
    local {
        enabled = true
        directory = file("${rootDir}/.gradle/build-cache")
        removeUnusedEntriesAfterDays = 30
    }
}
```

## Troubleshooting

### Common Issues

#### "Dev path not found"

**Cause**: Missing dev project in parent directory

**Solution**: Ensure dev project exists:
```
Bearsampp-development/
├── module-python/
└── dev/
```

#### "7-Zip not found"

**Cause**: 7z command not in PATH

**Solution**: Install 7-Zip and add to PATH

#### "Bundle version not found"

**Cause**: Python version doesn't exist in bin/

**Solution**: Verify version directory exists:
```bash
gradle listVersions
```

#### Build Hangs

**Cause**: Gradle daemon issues

**Solution**: Stop daemon and retry:
```bash
gradle --stop
gradle release "-PbundleVersion=3.13.5"
```

### Debug Mode

Run with debug output:

```bash
gradle release "-PbundleVersion=3.13.5" --debug
```

### Stack Traces

Show full stack traces:

```bash
gradle release "-PbundleVersion=3.13.5" --stacktrace
```

## Best Practices

1. **Always verify environment first**: Run `gradle verify` before building
2. **Use specific versions**: Specify `-PbundleVersion` for reproducible builds
3. **Clean between major changes**: Run `gradle clean` when switching versions
4. **Monitor build cache**: Periodically clean old cache entries
5. **Keep Gradle updated**: Use latest stable Gradle version
6. **Document custom changes**: Add comments for any build script modifications

## References

- [Gradle Documentation](https://docs.gradle.org/)
- [Gradle Build Cache](https://docs.gradle.org/current/userguide/build_cache.html)
- [Gradle Performance](https://docs.gradle.org/current/userguide/performance.html)
- [Bearsampp Project](https://github.com/bearsampp/bearsampp)
