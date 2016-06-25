#!/bin/bash
for remote in `cat Pathogenfile`; do git clone $remote; done
