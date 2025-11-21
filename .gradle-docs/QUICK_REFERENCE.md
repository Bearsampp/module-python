# Quick Reference Card

## Essential Commands

### Build Commands
```bash
# Build a release (interactive - shows available versions)
gradle release

# Build a release (non-interactive - specify version)
gradle release "-PbundleVersion=3.13.5"

# Clean build artifacts
gradle clean
```

### Verification Commands
```bash
# Verify build environment
gradle verify

# Validate build.properties
gradle validateProperties

# Validate Python version structure
gradle validatePythonVersion "-PbundleVersion=3.13.5"
```

### Information Commands
```bash
# Display build information
gradle info

# List all available tasks
gradle tasks

# List available Python versions
gradle listVersions

# List available releases
gradle listReleases

# Show wheel package information
gradle showWheelInfo "-PbundleVersion=3.13.5"
```

## Common Workflows

### First-Time Setup
```bash
gradle verify
gradle listVersions
gradle validatePythonVersion "-PbundleVersion=3.13.5"
gradle release "-PbundleVersion=3.13.5"
```

### Daily Development
```bash
gradle validateProperties
gradle release "-PbundleVersion=3.13.5"
gradle clean
```

### Troubleshooting
```bash
gradle verify
gradle validatePythonVersion "-PbundleVersion=3.13.5"
gradle showWheelInfo "-PbundleVersion=3.13.5"
gradle release "-PbundleVersion=3.13.5" --debug
```

## Configuration Files

### build.properties
```properties
bundle.name = python
bundle.release = 2025.8.21
bundle.type = tools
bundle.format = 7z
```

### gradle.properties
```properties
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m
```

## Directory Structure

```
module-python/
├── .gradle-docs/          # Documentation
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

## Task Groups

### Build
- `release` - Build release package
- `clean` - Clean build artifacts

### Verification
- `verify` - Verify environment
- `validateProperties` - Validate properties
- `validatePythonVersion` - Validate version

### Help
- `info` - Build information
- `listVersions` - List versions
- `listReleases` - List releases
- `showWheelInfo` - Wheel information

## Gradle Options

### Debug & Logging
```bash
--debug              # Debug output
--info               # Info output
--stacktrace         # Show stack traces
--scan               # Build scan
```

### Performance
```bash
--parallel           # Parallel execution
--build-cache        # Enable build cache
--no-daemon          # Disable daemon
--max-workers=4      # Max workers
```

### Other
```bash
--dry-run            # Dry run
--continue           # Continue on failure
--refresh-dependencies  # Refresh dependencies
```

## Exit Codes

- `0` - Success
- `1` - General error
- `2` - Configuration error
- `3` - Execution error
- `4` - Validation error

## Requirements

### Software
- Java 8+
- Gradle 7.0+
- 7-Zip

### System
- Windows
- 2GB RAM (4GB recommended)
- 1GB disk space

## Documentation

- [Getting Started](GETTING_STARTED.md)
- [Build System](BUILD_SYSTEM.md)
- [Task Reference](TASK_REFERENCE.md)
- [Configuration](CONFIGURATION.md)

## Support

- Documentation: `.gradle-docs/`
- Issues: https://github.com/bearsampp/bearsampp/issues
- Website: https://bearsampp.com

## Quick Tips

1. Always run `gradle verify` first
2. Use `-PbundleVersion` for non-interactive builds
3. Enable build cache for faster builds
4. Use `--debug` for troubleshooting
5. Check documentation for detailed info

---

**Version**: 2025.8.21 | **Type**: Pure Gradle (No Wrapper, No Ant)
