#!/bin/bash

# For Mac
if [ $(command uname) == "Darwin" ]; then
	if ! [ -x "$(command -v greadlink)"  ]; then
		brew install coreutils
	fi
	BIN_PATH=$(greadlink -f "$0")
	ROOT_DIR=$(dirname $(dirname $(dirname $BIN_PATH)))
# For Linux
else
	BIN_PATH=$(readlink -f "$0")
	ROOT_DIR=$(dirname $(dirname $(dirname $BIN_PATH)))
fi

export ROOT_DIR=${ROOT_DIR}
export PATH=${ROOT_DIR}/clang+llvm/bin:${ROOT_DIR}/tool/SVF/Release-build/bin:$PATH
export LD_LIBRARY_PATH=${ROOT_DIR}/clang+llvm/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

echo "Installation completed. Everything's fine!"

set -eux

# compile the program and get bit code
cd $ROOT_DIR/test/transfer
./cleanDIR.sh
clang -g -emit-llvm -c ./transfer.c -o transfer.bc

# perform static analysis
$ROOT_DIR/tool/staticAnalysis/staticAnalysis.sh transfer

# complie the instrumented program
export Con_PATH=$ROOT_DIR/test/transfer/ConConfig.transfer
$ROOT_DIR/tool/staticAnalysis/DBDS-INSTRU/dbds-clang-fast -g -c ./transfer.c -o transfer.o
clang++ ./transfer.o $ROOT_DIR/tool/staticAnalysis/DBDS-INSTRU/DBDSFunction.o -o transfer -lpthread -ldl
