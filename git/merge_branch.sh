#!/bin/bash
#===============================================================================
# merge current branch to target branch and decide it will be deleted or not
#===============================================================================
# get current branch name
branch_current=$(git rev-parse --abbrev-ref HEAD)
echo "current branch:${branch_current}"

# setup target branch
read -p "input target branch name:" branch_target
echo "target branch:${branch_target}"

echo "check-out to target branch, and merge"
git cko ${branch_target}
git mg ${branch_current}

# delete or check-out to branch merged
read -p "delete branch merged<${branch_current}>? (y/n)" del_branch
if [ "${del_branch}" = "y" ]
then
    echo "delete branch <${branch_current}>!!!"
    git brh -d ${branch_current}
else
    echo "check-out to branch <${branch_current}>~~~"
    git cko ${branch_current}
fi
