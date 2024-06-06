load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "action_config", "feature", "flag_group", "flag_set", "tool", "tool_path", "artifact_name_pattern")

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "bin/x86_64-w64-mingw32-gcc",
        ),
        tool_path(
            name = "ld",
            path = "bin/x86_64-w64-mingw32-ld",
        ),
        tool_path(
            name = "ar",
            path = "bin/x86_64-w64-mingw32-ar",
        ),
        tool_path(
            name = "cpp",
            path = "bin/x86_64-w64-mingw32-cpp",
        ),
        tool_path(
            name = "gcov",
            path = "bin/x86_64-w64-mingw32-gcov",
        ),
        tool_path(
            name = "nm",
            path = "bin/x86_64-w64-mingw32-nm",
        ),
        tool_path(
            name = "objdump",
            path = "bin/x86_64-w64-mingw32-objdump",
        ),
        tool_path(
            name = "strip",
            path = "bin/x86_64-w64-mingw32-strip",
        ),
    ]

    all_link_actions = [
        ACTION_NAMES.cpp_link_executable,
        ACTION_NAMES.cpp_link_dynamic_library,
        ACTION_NAMES.cpp_link_nodeps_dynamic_library,
    ]

    features = [
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-lstdc++",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        cxx_builtin_include_directories = [
            "%sysroot%/include",
            "%sysroot%/x86_64-w64-mingw32/include",
            "%sysroot%/lib/clang/18/include"
        ],
        toolchain_identifier = "k8-toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "k8",
        target_libc = "unknown",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        builtin_sysroot = ctx.attr.sysroot,
        artifact_name_patterns = [
            artifact_name_pattern(
                category_name = "executable",
                prefix = "",
                extension = ".exe",
            ),
        ],
    )

toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "sysroot": attr.string(),
    },
    provides = [CcToolchainConfigInfo],
)
