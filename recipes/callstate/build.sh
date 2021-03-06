#!/bin/sh
# Compile nim
pushd nimsrc
if [[ $OSTYPE == "darwin"* ]]; then
  bash build.sh --os darwin --cpu x86_64
else
  bash build.sh --os linux --cpu x86_64
fi
bname=`basename $CC`
echo "gcc.exe = \"${bname}\"" >> config/nim.cfg
echo "gcc.linkerexe = \"${bname}\"" >> config/nim.cfg
echo "clang.exe = \"${bname}\"" >> config/nim.cfg
echo "clang.linkerexe = \"${bname}\"" >> config/nim.cfg
bin/nim c  koch
./koch tools
popd

export PATH=$SRC_DIR/nimsrc/bin:$PATH

nimble install -y --verbose
mkdir -p $PREFIX/bin
chmod a+x callstate
cp callstate $PREFIX/bin/callstate
