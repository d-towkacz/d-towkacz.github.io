#!/bin/bash
set -e

export CONFIG_MODULE_SIG=n
export CONFIG_MODULE_SIG_ALL=n
export KERNELRELEASE=${1}

echo "Installing FacetimeHD camera for $KERNELRELEASE"
cd /tmp
git clone https://github.com/patjak/bcwc_pcie.git
cd bcwc_pcie/firmware
make
make install
cd ..
make
make install
rm -rf /tmp/bcwc_pcie

if [ ! -d "/etc/modules-load.d" ]; then
  mkdir -p "/etc/modules-load.d"
fi

cat > "/etc/modules-load.d/facetimehd.conf" << EOL
videobuf2-core
videobuf2_v4l2
videobuf2-dma-sg
facetimehd
EOL

echo "Install complete."