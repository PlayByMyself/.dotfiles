copy_git_diff() {
  local message_lang=""

  while getopts "m:" opt; do
    case ${opt} in
      m)
        message_lang=$OPTARG
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        return 1
        ;;
    esac
  done

  git_diff=$(git diff --cached)
  if [[ $? -ne 0 ]]; then
    echo "Failed to get git diff. Please make sure you are in a git repository and have changes staged."
    return 1
  fi

  validate_lang() {
    if [[ -n "$message_lang" && "$message_lang" != "cn" && "$message_lang" != "en" ]]; then
      echo "Invalid language: $message_lang. Please use 'cn' or 'en'."
      return 1
    fi
  }

  copy_to_clipboard() {
    local output=$git_diff

    if [[ "$message_lang" == "cn" ]]; then
      output+="\n\n根据以上git diff信息,生成的git commit message 如下:\n\n"
    elif [[ "$message_lang" == "en" ]]; then
      output+="\n\nBased on the above git diff, the generated git commit message is as follows:\n\n"
    fi

    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo -e "$output" | pbcopy
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
      echo -e "$output" | xclip -selection clipboard
    elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* ]]; then
      echo -e "$output" | clip
    else
      echo "Unsupported OS type. This script supports MacOS, Linux, and Windows (via Cygwin or Msys)."
      return 1
    fi
  }

  validate_lang || return 1
  copy_to_clipboard || return 1
}