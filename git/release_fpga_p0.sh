#!/bin/bash
#===============================================================================
# create branch release_Vxxx and modify FPGA_VERSION parameter
#===============================================================================
# get current release_version
main_ver_current=$(grep -m 1 "FPGA_VERSION" \
    ./top/if_module/linear_ccd_top.v | awk '{print subsrt($NF, 4, 1)}')
sub_ver_current=$(grep -m 1 "FPGA_VERSION" \
    ./top/if_module/linear_ccd_top.v | awk '{print subsrt($NF, 5, 1)}')
echo "current version is V${main_ver_current}.${sub_ver_current}"

# setup version number
read -p "input main-version number:" main_ver
read -p "input sub-version number:" sub_ver
release_version="${main_ver}.${sub_ver}"
echo "next version is V${release_version}"

# create release branch
branch_name="release_V${main_ver}.${sub_ver}"
git cko -b ${branch_name}

# write version number
sed -i "s/\(^par.\+FPGA_VERSION = 8'h\)[0-9A-F]\{2\}/\1${main_ver}${sub_ver}/g" \
    ./top/if_module/linear_ccd_top.v
