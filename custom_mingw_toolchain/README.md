## Custom mingw toolchain

Source: https://github.com/mstorsjo/llvm-mingw

This is a custom LLVM mingw toolchain for bazel. The toolchain can automatically detect your OS and arch type, and use the right pre-built binary mingw distribution. 

To crosscompile to windows specify windows as the target platform:
```
--platforms //platform:windows
```