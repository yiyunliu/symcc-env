# symcc-env
## Getting Started

```sh
git clone --branch nix-copy https://github.com/yiyunliu/symcc.git
git clone https://github.com/yiyunliu/symcc-env.git
```
Make sure that symcc and symcc-env are under the same directory.

If you have direnv installed, the following commands will allow you to enter an environment with `symcc` and its helpers installed whenever you `cd` into symcc-env:
```sh
cd symcc-env
direnv allow .
```

symcc-env is separated from symcc to prevent unnecessary rebuilding. In addition to `symcc`, symcc-env's shell.nix file also provides the necessary dependencies for building Python.
