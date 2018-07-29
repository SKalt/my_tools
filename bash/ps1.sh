# customized from a prompt gerenerated by http://ezprompt.net

function shorten() {
  local string=$1;
  local end=$2;
  if [ ${#string} -gt $end ];
  then
    echo "${string::$end}…";  # Note this is a unicode ellipsis
  else
    echo $string
  fi
}

function current_directory_name() {
	if [ "$PWD" == "$HOME" ]; then
		echo "~";
	else
		echo "$(shorten "${PWD##*/}" 10)";
	fi
}

function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`;
	if [ ! "${BRANCH}" == "" ]; then
		STAT=`parse_git_dirty`;
		BRANCH="$(shorten "$BRANCH" 8)";
		echo "(${BRANCH}${STAT})";
	else
		echo "";
	fi
}

function git_grep() {  # for DRYing out parse_git_dirty
	echo -n "$1" 2> /dev/null | grep "$2" &> /dev/null; echo "$?"
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`;
	dirty=`git_grep "${status}" "modified:"`;
	untracked=`git_grep "${status}" "Untracked files"`;
	ahead=`git_grep "${status}" "Your branch is ahead of"`;
	newfile=`git_grep "${status}" "new file:"`;
	renamed=`git_grep "${status}" "renamed:"`;
	deleted=`git_grep "${status}" "deleted:"`;
	bits='';
	if [ "${renamed}"   == "0" ]; then bits=">$bits"; fi;
	if [ "${ahead}"     == "0" ]; then bits="*$bits"; fi;
	if [ "${newfile}"   == "0" ]; then bits="+$bits"; fi;
	if [ "${untracked}" == "0" ]; then bits="?$bits"; fi;
	if [ "${deleted}"   == "0" ]; then bits="x$bits"; fi;
	if [ "${dirty}"     == "0" ]; then bits="!$bits"; fi;
	if [ ! "${bits}" == "" ]; then echo " $bits"; else echo ""; fi
}

function nonzero_return() {
	local RETVAL=$?
	if [ $RETVAL -ne 0 ]; then echo "$RETVAL"; fi
}

export PS1="\[\e[32m\]\A\[\e[m\] \[\e[32m\]\`current_directory_name\`\[\e[m\]\`nonzero_return\` \`parse_git_branch\` $ "
