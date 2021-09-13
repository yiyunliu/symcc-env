with import <nixpkgs> {};
mkShell.override {stdenv = llvmPackages_10.stdenv;} {
  nativeBuildInputs = callPackage ../symcc/default.nix
    { stdenv = llvmPackages_10.stdenv;
      llvm = llvmPackages_10.llvm;
    } ++
  [ zlib
    libffi
    libuuid
    lzma
    readline
    gdbm
    bzip2
    rpcsvc-proto
    tcl
    afl
    linuxHeaders
    python3
    which
    curl
    # (afl.override {
    #   stdenv = llvmPackages_10.stdenv;
    # })
  ];
  UCLIBC_KERNEL_HEADERS="${linuxHeaders}/include";
  CLANG_BUILTIN_INCLUDE_PATH="${llvmPackages_10.clang-unwrapped.lib}/lib/clang/${llvmPackages_10.clang-unwrapped.version}/include";
}
