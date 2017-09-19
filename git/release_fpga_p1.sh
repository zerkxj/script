#!/bin/bash
#===============================================================================
# commit file to branch release_Vxxx and merge to branch master and develop
#===============================================================================
# stage file
git add top/if_module/linear_cce_top.v
git add ../fpge/linear_ccd_top.sof
git add ../fpga/linear_ccd_top.jic
git add ../fpga/rev_1/linear_ccd_top.vqm

# commit file to branch release
git com

# get release branch name
branch_name=$(git rev-parse --abbrev-ref HEAD)
tag=${branch_name##*se_}
echo "$}tag}"

git cko -f master
git mg ${branch_name}
git tag -a ${tag}
git cko -f develop
git mg ${branch_name}
git brh -d ${branch_name}
