#!/bin/bash
#===============================================================================
# create release branch and prepare for next version release
#===============================================================================
# get current branch name
branch_current=$(git rev-parse --abbrev-ref HEAD)
echo "current branch:${branch_current}"
if [ "${branch_current}" != "develop" ]
then
    echo "!!!current branch not in <develop>!!!"
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
read -p "input major version number:" major_ver
read -p "input minor version number:" minot_ver
read -p "input patch version number:" patch_ver
number_ver="v${major_ver}.${minor_ver}.${patch_ver}"
echo "next version number will be ${number_ver}"
branch_release="release_${number_ver}"
git cko -b ${branch_name}

# write version number
sed -i "s/\(^ver.\+v\).\+/\1${major_ver}.${minor_ver}.${patch_ver}/g" ./version.txt 

git add version.txt
git com

git cko develop
git mg ${branch_release}

git cko master
git mg ${branch_release}
echo "tag = ${number_ver}"
git tag -a ${number_ver}
git brh -d ${brnach_releash}
