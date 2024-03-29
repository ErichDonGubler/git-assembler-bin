def make_exe():
    dist = default_python_distribution()
    policy = dist.make_python_packaging_policy()
    policy.extension_module_filter = "all"
    policy.include_distribution_sources = True
    policy.include_distribution_resources = True
    policy.include_test = False

    python_config = dist.make_python_interpreter_config()
    python_config.run_module = "git-assembler"
    exe = dist.to_python_executable(
        name="git-assembler",
        packaging_policy=policy,
        config=python_config,
    )
    exe.windows_subsystem = "console"
    exe.add_python_resources(exe.read_package_root(
       path= "./vendor/git-assembler/",
       packages=["git-assembler"],
    ))
    return exe

def make_embedded_resources(exe):
    return exe.to_embedded_resources()

def make_install(exe):
    files = FileManifest()
    files.add_python_resource(".", exe)

    return files

def make_msi(exe):
    return exe.to_wix_msi_builder(
        id_prefix="git_assembler",
        product_name="git-assembler",
        product_version="1.4",
        product_manufacturer="TODO, distributed by Erich Gubler"
    )

register_target("exe", make_exe)
register_target("resources", make_embedded_resources, depends=["exe"], default_build_script=True)
register_target("install", make_install, depends=["exe"], default=True)
register_target("msi_installer", make_msi, depends=["exe"])

resolve_targets()
