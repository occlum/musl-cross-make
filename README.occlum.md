Occlum-GCC toolchain build introduction
## Build toolchain:
```
./buildOcclumGCC.sh
```
## Why:   
This repo originally works for musl toolchain. We need to replace the original musl with ours.   
So in buildOcclumGCC.sh, we firstly download occlum's musl, then rename it with it's version number(1.1.20), compress it.  
In config.mak file, we specific target we need, musl version and also install path(/usr/local/occlum-gcc/)
## Use toolchain
###Compile program
use the binary to build your program like in occlum/test/test\_command.mk:
```
CC := /usr/local/occlum-gcc/bin/x86_64-linux-musl-gcc
CXX := /usr/local/occlum-gcc/bin/x86_64-linux-musl-g++
```
### Run program
Dynamic linked program need the dynamic libraries to run the file. So we need to copy required libraries into occlum's file system. For example, in occlum/test/Makefile:
```
lib-sefs:
        @mkdir -p $(FS_PATH)/lib/
        @cp /usr/local/occlum-gcc/x86_64-linux-musl/lib/libc.so $(FS_PATH)/lib/ld-musl-x86_64.so.1
        @cp /usr/local/occlum-gcc/x86_64-linux-musl/lib/libc.so $(FS_PATH)/lib/libc.so
        @cp /usr/local/occlum-gcc/x86_64-linux-musl/lib/libstdc++.so.6.0.25 $(FS_PATH)/lib/libstdc++.so.6
        @cp /usr/local/occlum-gcc/x86_64-linux-musl/lib/libgcc_s.so.1 $(FS_PATH)/lib/libgcc_s.so.1
        @cp /usr/local/occlum-gcc/x86_64-linux-musl/lib/libgomp.so.1 $(FS_PATH)/lib/libgomp.so.1
        @rm -rf $(SEFS_PATH)/lib
        @mkdir -p $(SEFS_PATH)
        @cd $(PROJECT_DIR)/deps/sefs/sefs-fuse/bin/ && \
                ./app \
                        --integrity-only \
                        $(CUR_DIR)/$(SEFS_PATH)/lib \
                        $(CUR_DIR)/$(FS_PATH)/lib \
                        zip
```

