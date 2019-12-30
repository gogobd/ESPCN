#!/bin/sh
rm package.tgz
tar --no-recursion --exclude './__pycache__' -zcvf package.tgz ./*
