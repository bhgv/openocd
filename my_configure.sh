#!/bin/sh

export CFLAGS=-I/usr/local/include
export LDFLAGS="-L/usr/local/lib -lwiringPi"
./configure --enable-sysfsgpio --enable-maintainer-mode --disable-werror --enable-arm-jtag-ew
