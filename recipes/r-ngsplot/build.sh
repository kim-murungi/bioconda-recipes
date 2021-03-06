#!/bin/bash
outdir=$PREFIX/share/$PKG_NAME-$PKG_VERSION-$PKG_BUILDNUM
mkdir -p $outdir
mkdir -p $PREFIX/bin
cp -R {bin,database,example,galaxy,lib,LICENSE} ${outdir}/
# Set up links for 
for f in ${outdir}/bin/*; do
    ln -s ${f} ${PREFIX}/bin
done

# Patch scripts to use proper path and not depend on NGSPLOT env variable
for f in "${outdir}"/bin/*.py ; do
    sed -Ei.bak "s|os\.environ\[\"NGSPLOT\"\]|\"${outdir}\"|g" "${f}"
    rm "${f}.bak"
done
for f in "${outdir}"/bin/{,backup}/*.r ; do
    sed -Ei.bak "s|Sys\.getenv\('NGSPLOT'\)|\"${outdir}\"|g" "${f}"
    rm "${f}.bak"
done
