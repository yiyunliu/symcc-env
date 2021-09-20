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

## Building Python
We use a version of Python optimized for symbolic execution. The optimized version adds an additional flag `--with-klee` (will be changed later to something more sensible such as `--with-symbex-optimization`) which disables the cache of integer, string and other miscellaneous objects.

To clone the optimized version of Python, use the following command:
```sh
git clone https://github.com/yiyunliu/cpython
```

Here is the command I use for building Python (make sure you are in the environment created by `nix-shell` or `direnv`):
```sh
cd cpython
mkdir build
../configure -prefix={..some directory..}/cpython-symbex-optimized --with-pymalloc=no --with-klee=yes CC=symcc
```
`--with-pymalloc=no` is helpful because it disables Python's internal arenas and always uses `malloc` for allocating objects. This avoids evaluating uninterpreted assembly code.

We specify symcc as the compiler using the flag `CC=compiler-of-choice`. If we want to compile Python with optimization level 1, we can use the following:
```sh
../configure -prefix={..some directory..}/cpython-symbex-optimized --with-pymalloc=no --with-klee=yes CC=symcc CFLAGS=-O1
```
There are other flags such as `--with-pydebug`, which, if enabled, change the optimization level. You can refer to the official CPython documentation for the details.

## Compiling C code that depends on the CPython runtime
Python code is evaluated inside the interpreter loop. Sometimes, we want to identify which particular low-level Python function causes the problem.

TODO: Add the example where I debug the integer equivalence program by writing C code.

## Comments
symcc-env is separated from symcc to prevent unnecessary rebuilding. In addition to `symcc`, symcc-env's shell.nix file also provides the necessary dependencies for building Python.
