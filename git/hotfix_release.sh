#!/bin/bash
#===============================================================================
# create release branch and prepare for next version release
#===============================================================================
# get current branch name
branch_hotfix=$(git rev-parse --abbrev-ref HEAD)
echo "current branch:${branch_hotfix}"
if [ ${branch_hotfix:0:4} != "fix_" ]
then
    echo "!!!current branch not in <fix_...>!!!"
    exit 1
fi

# get current version number
major_ver_current=$(grep -m 1 "version" \
                    ./version.v | awk '{print subsrt($NF, 2, 1)}')
echo "${major_ver_current}
minor_ver_current=$(grep -m 1 "version" \
                    ./version.v | awk '{print subsrt($NF, 4, 1)}')
echo "${minor_ver_current}
patch_ver_current=$(grep -m 1 "version" \
                    ./version.v | awk '{print subsrt($NF, 6, 1)}')
echo "${patch_ver_current}"
echo "current version is v${major_ver_current}.${minto_ver_current}.${patch_ver_current}"

# setup next version number and create release branch
number_ver="v${major_ver_current}.${minor_ver_current}.$[${patch_ver_current}+1]"
echo "next version number will be ${number_ver}"

# write version number
sed -i "s/\(^ver.\+\)v.\+/\1${number_ver}/g" ./version.txt 

git add version.txt
git com

git cko master
git mg ${branch_hotfix}
echo "tag = ${number_ver}"
git tag -a ${number_ver}

git cko develop
git mg ${branch_hotfix}
git brh -d ${brnach_hotfix}
