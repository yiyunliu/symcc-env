# symcc-env
## Getting Started

```sh
git clone --branch nix-copy https://github.com/yiyunliu/symcc.git
git clone https://github.com/yiyunliu/symcc-env.git
```
Make sure that symcc and symcc-env are under the same directory.

You can enter an environment with symcc installed in two different ways:
### Entering the environment with direnv
If you have direnv installed, the following commands will allow you to enter an environment with `symcc` and its helpers installed whenever you `cd` into symcc-env:
```sh
cd symcc-env
direnv allow .
```
### Entering the environment 
```sh
cd symcc-env
nix-shell
```
Now you have access to the symcc command. Type Ctrl+D to exit the environment. You can also pass the `--pure` argument to nix-shell so your environment (e.g. the PATH variable) will be cleared to only include the dependencies installed by nix; this is useful for preventing accidental dependency on system packages so the issues you encounter are guaranteed to be reproducible on other systems (the direnv approach is equivalent to nix-shell without the `--pure` option).

## Comments
symcc-env is separated from symcc to prevent unnecessary rebuilding. In addition to `symcc`, symcc-env's shell.nix file also provides the necessary dependencies for building Python.
