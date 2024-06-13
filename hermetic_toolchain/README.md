## Hermetic CC toolchain

Source: https://github.com/uber/hermetic_cc_toolchain

This is Ubers C/C++ toolchain that can (cross-)compile C/C++ programs on top of `zig cc`. This example support compiling to following targets. The target can be select by providing the matching `--config` flag (see `.bazelrc` for more details):
* Linux arm64: `--config=linux_arm64`
* Linux amd64: `--config=linux_amd64`
* Darwin arm64: `--config=darwin_arm64`
* Darwin amd64: `--config=darwin_amd64`

This flag can be set in the `build_flags` section of the project view file. For example:
```yaml
build_flags:
  --config=darwin_arm64
```
More information about build flags can be found [here](https://ij.bazel.build/docs/project-views.html#build_flags).