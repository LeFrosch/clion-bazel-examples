def _mingw_host_arch(rctx):
    os = rctx.os.name
    cpu = rctx.os.arch

    if os.startswith("mac os"):
        return "ucrt-macos-universal"

    if os.startswith("linux") and cpu == "aarch64":
        return "ucrt-ubuntu-20.04-aarch64"

    if os.startswith("linux") and cpu in ["amd64", "x86_64"]:
        return "ucrt-ubuntu-20.04-x86_64"

    if os.startswith("windows") and cpu == "aarch64":
        return "ucrt-aarch64"

    if os.startswith("windows") and cpu in ["amd64", "x86_64"]:
        return "ucrt-x86_64"

    fail("unknown host: %s %s" % (os, cpu))

def _mingw_archive_extension(rctx):
    if rctx.os.name.startswith("windows"):
        return "zip"
    else:
        return "tar.xz"

def _mingw_repo_impl(rctx):
    version = rctx.attr.mingw_version

    archive_name = "llvm-mingw-%s-%s" % (version, _mingw_host_arch(rctx))
    archive_link = "https://github.com/mstorsjo/llvm-mingw/releases/download/%s/%s.%s" % (version, archive_name, _mingw_archive_extension(rctx))

    rctx.template(
        "BUILD",
        Label("//toolchain:BUILD.tmpl"),
        {
            "%{sysroot}": str(rctx.path("."))
        }
    )

    rctx.download_and_extract(
        url = archive_link,
        stripPrefix = archive_name,
    )

mingw_toolchain = repository_rule(
    local = False,
    implementation = _mingw_repo_impl,
    attrs={
        "mingw_version": attr.string(default="20240606")
    }    
)
