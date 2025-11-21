# Configuration Guide

This guide covers all configuration options for the Bearsampp Python module build system.

## Configuration Files

### build.properties

Main bundle configuration file.

**Location**: `build.properties`

**Format**: Java Properties

**Required Properties**:

```properties
# Bundle name (used for directory naming)
bundle.name = python

# Bundle release version
bundle.release = 2025.8.21

# Bundle type (tools, apps, bins)
bundle.type = tools

# Archive format (7z, zip, tar, tar.gz)
bundle.format = 7z
```

**Optional Properties**:

```properties
# Custom build path (defaults to ~/Bearsampp-build)
build.path = C:/Bearsampp-build

# Custom temporary path (defaults to {build.path}/tmp)
#tmp.path = C:/Bearsampp-build/tmp

# Custom release path (defaults to {build.path}/release)
#release.path = C:/Bearsampp-build/release
```

**Example**:

```properties
bundle.name = python
bundle.release = 2025.8.21
bundle.type = tools
bundle.format = 7z
build.path = D:/CustomBuildPath
```

---

### gradle.properties

Gradle build configuration.

**Location**: `gradle.properties`

**Format**: Java Properties

**Daemon Configuration**:

```properties
# Enable Gradle daemon for faster builds
org.gradle.daemon=true

# Daemon idle timeout in milliseconds (default: 3 hours)
org.gradle.daemon.idletimeout=10800000
```

**Performance Configuration**:

```properties
# Enable parallel execution
org.gradle.parallel=true

# Maximum number of worker processes
org.gradle.workers.max=4

# Enable build caching
org.gradle.caching=true

# Enable configuration on demand
org.gradle.configureondemand=false
```

**JVM Configuration**:

```properties
# JVM arguments for Gradle
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError

# For larger builds
#org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=1g -XX:+UseG1GC
```

**Console Configuration**:

```properties
# Console output mode (auto, plain, rich, verbose)
org.gradle.console=auto

# Warning mode (all, fail, summary, none)
org.gradle.warning.mode=all

# Logging level (quiet, warn, lifecycle, info, debug)
org.gradle.logging.level=lifecycle
```

**Build Configuration**:

```properties
# Enable configuration cache (experimental)
org.gradle.unsafe.configuration-cache=true

# Enable file system watching
org.gradle.vfs.watch=true

# Enable verbose logging
org.gradle.logging.stacktrace=internal
```

**Example**:

```properties
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=1g
org.gradle.console=rich
org.gradle.warning.mode=all
```

---

### settings.gradle

Gradle settings configuration.

**Location**: `settings.gradle`

**Format**: Groovy DSL

**Basic Configuration**:

```groovy
// Project name
rootProject.name = 'module-python'
```

**Feature Previews**:

```groovy
// Enable stable configuration cache
enableFeaturePreview('STABLE_CONFIGURATION_CACHE')

// Enable type-safe project accessors
enableFeaturePreview('TYPESAFE_PROJECT_ACCESSORS')
```

**Build Cache Configuration**:

```groovy
buildCache {
    local {
        enabled = true
        directory = file("${rootDir}/.gradle/build-cache")
        removeUnusedEntriesAfterDays = 30
    }
}
```

**Plugin Management**:

```groovy
pluginManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
    }
}
```

**Example**:

```groovy
rootProject.name = 'module-python'

enableFeaturePreview('STABLE_CONFIGURATION_CACHE')

buildCache {
    local {
        enabled = true
        directory = file("${rootDir}/.gradle/build-cache")
        removeUnusedEntriesAfterDays = 30
    }
}

gradle.rootProject {
    println "Initializing Bearsampp Module Python Build"
}
```

---

### releases.properties

Available Python releases configuration.

**Location**: `releases.properties`

**Format**: Java Properties

**Structure**:

```properties
{version}={download_url}
```

**Example**:

```properties
3.10.6=https://www.python.org/ftp/python/3.10.6/python-3.10.6-amd64.exe
3.10.9=https://www.python.org/ftp/python/3.10.9/python-3.10.9-amd64.exe
3.11.5=https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe
3.11.8=https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe
3.12.2=https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe
3.12.9=https://www.python.org/ftp/python/3.12.9/python-3.12.9-amd64.exe
3.13.2=https://www.python.org/ftp/python/3.13.2/python-3.13.2-amd64.exe
3.13.5=https://www.python.org/ftp/python/3.13.5/python-3.13.5-amd64.exe
```

---

### wheel.properties

Wheel package configuration (per Python version).

**Location**: `bin/python{version}/wheel/wheel.properties`

**Format**: Java Properties

**Structure**:

```properties
wheel={wheel_package_url}
```

**Example**:

```properties
wheel=https://files.pythonhosted.org/packages/28/6c/640e3f5c734c296a7193a483a1a120ae66e0c3a5a562e6b3c4b8f8f3e1f/PyQt5-5.15.9-cp313-cp313-win_amd64.whl
```

**Multiple Wheels** (if needed):

```properties
wheel.pyqt5=https://files.pythonhosted.org/packages/.../PyQt5-5.15.9-cp313-cp313-win_amd64.whl
wheel.numpy=https://files.pythonhosted.org/packages/.../numpy-1.24.3-cp313-cp313-win_amd64.whl
```

---

## Python Version Configuration

### Directory Structure

Each Python version must follow this structure:

```
bin/python{version}/
├── bin/
│   ├── python.bat          # Python launcher
│   ├── python.exe          # Python executable
│   └── [other binaries]
├── wheel/
│   ├── wheel.properties    # Wheel configuration
│   └── install.bat         # Installation script
├── bearsampp.conf          # Bearsampp configuration
├── Lib/                    # Python libraries
├── DLLs/                   # Python DLLs
└── [other Python files]
```

### bearsampp.conf

Bearsampp module configuration.

**Location**: `bin/python{version}/bearsampp.conf`

**Format**: INI

**Example**:

```ini
[python]
name = "Python"
version = "3.13.5"
release = "2025.8.21"
```

### install.bat

Wheel installation script.

**Location**: `bin/python{version}/wheel/install.bat`

**Format**: Batch Script

**Example**:

```batch
@echo off
cd ..
bin\python.bat -m pip install wheel\PyQt5-5.15.9-cp313-cp313-win_amd64.whl
```

**Multiple Wheels**:

```batch
@echo off
cd ..
bin\python.bat -m pip install wheel\PyQt5-5.15.9-cp313-cp313-win_amd64.whl
bin\python.bat -m pip install wheel\numpy-1.24.3-cp313-cp313-win_amd64.whl
```

---

## Build Path Configuration

### Default Paths

```groovy
buildPath = "${System.getProperty('user.home')}/Bearsampp-build"
tmpPath = "${buildPath}/tmp"
releasePath = "${buildPath}/release"
```

**Windows Example**:
- Build Path: `C:/Users/username/Bearsampp-build`
- Temp Path: `C:/Users/username/Bearsampp-build/tmp`
- Release Path: `C:/Users/username/Bearsampp-build/release`

### Custom Paths

Override in `build.properties`:

```properties
build.path = D:/CustomBuildPath
```

Results in:
- Build Path: `D:/CustomBuildPath`
- Temp Path: `D:/CustomBuildPath/tmp`
- Release Path: `D:/CustomBuildPath/release`

---

## Archive Format Configuration

### Supported Formats

- **7z** (default): 7-Zip format, best compression
- **zip**: Standard ZIP format
- **tar**: TAR archive
- **tar.gz**: Compressed TAR archive

### Configuration

In `build.properties`:

```properties
bundle.format = 7z
```

### Format Comparison

| Format | Compression | Speed | Compatibility |
|--------|-------------|-------|---------------|
| 7z     | Excellent   | Medium| Requires 7-Zip|
| zip    | Good        | Fast  | Universal     |
| tar    | None        | Fast  | Unix/Linux    |
| tar.gz | Good        | Medium| Unix/Linux    |

---

## JVM Configuration

### Memory Settings

**Small Builds** (< 1GB):
```properties
org.gradle.jvmargs=-Xmx1g -XX:MaxMetaspaceSize=256m
```

**Medium Builds** (1-2GB):
```properties
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m
```

**Large Builds** (> 2GB):
```properties
org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=1g
```

### Garbage Collection

**G1GC** (recommended for large heaps):
```properties
org.gradle.jvmargs=-Xmx4g -XX:+UseG1GC
```

**Parallel GC** (default):
```properties
org.gradle.jvmargs=-Xmx2g -XX:+UseParallelGC
```

### Debug Options

**Heap Dump on OOM**:
```properties
org.gradle.jvmargs=-Xmx2g -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./heap-dump.hprof
```

**GC Logging**:
```properties
org.gradle.jvmargs=-Xmx2g -Xlog:gc*:file=gc.log
```

---

## Performance Tuning

### Parallel Execution

Enable parallel task execution:

```properties
org.gradle.parallel=true
org.gradle.workers.max=4
```

**Recommended Workers**:
- 2-4 cores: `workers.max=2`
- 4-8 cores: `workers.max=4`
- 8+ cores: `workers.max=8`

### Build Cache

Enable build caching:

```properties
org.gradle.caching=true
```

Configure cache in `settings.gradle`:

```groovy
buildCache {
    local {
        enabled = true
        directory = file("${rootDir}/.gradle/build-cache")
        removeUnusedEntriesAfterDays = 30
    }
}
```

### Configuration Cache

Enable configuration cache (experimental):

```properties
org.gradle.unsafe.configuration-cache=true
```

Or use feature preview in `settings.gradle`:

```groovy
enableFeaturePreview('STABLE_CONFIGURATION_CACHE')
```

### File System Watching

Enable file system watching:

```properties
org.gradle.vfs.watch=true
```

---

## Environment Variables

### Gradle Environment Variables

```bash
# Gradle user home
GRADLE_USER_HOME=C:/Users/username/.gradle

# Gradle options
GRADLE_OPTS=-Xmx2g -XX:MaxMetaspaceSize=512m

# Java home
JAVA_HOME=C:/Program Files/Java/jdk-17
```

### Build Environment Variables

```bash
# Custom build path
BEARSAMPP_BUILD_PATH=D:/CustomBuildPath

# Python version
PYTHON_VERSION=3.13.5
```

---

## Advanced Configuration

### Custom Task Configuration

Add custom configuration to `build.gradle`:

```groovy
ext {
    // Custom properties
    customBuildPath = System.getenv('CUSTOM_BUILD_PATH') ?: buildPath
    skipWheelInstall = project.hasProperty('skipWheels')
}

tasks.register('customRelease') {
    group = 'build'
    description = 'Custom release with additional steps'
    
    doLast {
        // Custom build logic
    }
}
```

### Conditional Configuration

```groovy
if (project.hasProperty('production')) {
    // Production configuration
    ext.buildPath = 'D:/Production/Bearsampp-build'
} else {
    // Development configuration
    ext.buildPath = "${System.getProperty('user.home')}/Bearsampp-build"
}
```

### Profile-Based Configuration

Create profile-specific properties:

**gradle-dev.properties**:
```properties
org.gradle.jvmargs=-Xmx1g
build.path=./build-dev
```

**gradle-prod.properties**:
```properties
org.gradle.jvmargs=-Xmx4g
build.path=D:/Production/Bearsampp-build
```

Use with:
```bash
gradle release -Pprofile=prod
```

---

## Configuration Validation

### Validate Configuration

```bash
# Validate build.properties
gradle validateProperties

# Validate Python version
gradle validatePythonVersion "-PbundleVersion=3.13.5"

# Verify entire environment
gradle verify
```

### Configuration Checklist

- [ ] `build.properties` has all required properties
- [ ] `gradle.properties` has appropriate JVM settings
- [ ] Python versions exist in `bin/` directory
- [ ] Each version has `wheel.properties` and `install.bat`
- [ ] 7-Zip is installed and in PATH
- [ ] Dev directory exists in parent directory
- [ ] Build path is writable

---

## Troubleshooting Configuration

### Common Issues

**Issue**: Out of memory errors

**Solution**: Increase heap size in `gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx4g
```

**Issue**: Slow builds

**Solution**: Enable parallel execution and caching:
```properties
org.gradle.parallel=true
org.gradle.caching=true
```

**Issue**: Configuration cache warnings

**Solution**: Disable configuration cache:
```properties
org.gradle.unsafe.configuration-cache=false
```

---

## Best Practices

1. **Use version control**: Track all configuration files in Git
2. **Document changes**: Add comments for custom configurations
3. **Test configurations**: Validate after changes with `gradle verify`
4. **Use profiles**: Separate dev and production configurations
5. **Monitor performance**: Adjust JVM settings based on build times
6. **Keep updated**: Use latest stable Gradle version
7. **Backup configurations**: Keep copies of working configurations

---

## See Also

- [Getting Started Guide](GETTING_STARTED.md)
- [Build System Guide](BUILD_SYSTEM.md)
- [Task Reference](TASK_REFERENCE.md)
- [Gradle Configuration](https://docs.gradle.org/current/userguide/build_environment.html)
