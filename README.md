# cf-keycrypt

This version is the same C code as the original from [cfengineers](https://github.com/cfengineers-net/cf-keycrypt).
The only thing I updated are both
the `Makefile` and `debian/rules`, so that cf-keycrypt compiles on Debian Linux 10 and works with
CFEngine 3.15. Following these instructions you should be able to compile the tool yourself.

# Prerequisites

## Install prerequisite packages

Whether you want to build a plain binary or a Debian package, you must be able to compile the CFEngine sources on your system. In addition, cf-keycrypt requires the development files for libtokyocabinet and the cfengine community package to be installed.

Assuming that you have already installed cfengine-community on the system, to install the rest of prerequisites, run:

```
sudo apt-get install \
    bison flex binutils build-essential \
    pkg-config autoconf libtool liblmdb-dev \
    libssl-dev libpcre3-dev libpam0g-dev \
    git libtokyocabinet-dev
```

If you need to install the cfengine-community package, refer to [this page](https://cfengine.com/product/community/) on the official web site.

## Clone the cf-keycrypt repository

In a directory of your choice, run:

```
git clone git@github.com:brontolinux/cf-keycrypt.git
```


# Building the binary

## Clone the cfengine core repository

To clone the latest 3.15 branch, run the following command in a directory of your choice:

```
git clone --recursive --single-branch --branch 3.15.x git@github.com:cfengine/core.git
```

## Build CFEngine 3.15

Enter the `core` directory and run:

```
./autogen.sh -C
make
```

## Compile cf-keycrypt

Assuming that you cloned and compiled CFEngine in, say, `/usr/local/src/cfengine/core`, enter the `cf-keycrypt` directory and run

```
make CFENGINE_SOURCE=/usr/local/src/cfengine/core
```

This should return pretty fast. If there are no errors, you'll find a `cf-keycrypt` executable in the directory where you cloned the sources. Congratulations.

# Building a Debian package

Enter the directory where you cloned cf-keycrypt and run:

```
sudo dpkg-buildpackage -us -uc
```

In a little while a number of files will be created in the directory above the source directory:

```
cf-keycrypt-dbgsym_0.1.1_amd64.deb
cf-keycrypt_0.1.1.dsc
cf-keycrypt_0.1.1.tar.xz
cf-keycrypt_0.1.1_amd64.buildinfo
cf-keycrypt_0.1.1_amd64.changes
cf-keycrypt_0.1.1_amd64.deb
```

You are probably most interested in `cf-keycrypt_0.1.1_amd64.deb`.

That's it!


# Acknowledgements

Instructions about how to compile CFEngine from source on a Debian system were kindly provided by Vratislav Podzimek and double checked by Bas van der Vlies. The tinkering on makefiles to make this compile on Debian is mine.