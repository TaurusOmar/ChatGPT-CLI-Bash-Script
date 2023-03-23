#!/bin/bash

API_KEY="Your-Api"

MODEL="gpt-3.5-turbo"

HEADER_CONTENT_TYPE="Content-Type: application/json"
HEADER_AUTHORIZATION="Authorization: Bearer $API_KEY"

CONTEXT_FILE="chat_context.txt"

touch "$CONTEXT_FILE"

load_context() {
  if [ -f "$CONTEXT_FILE" ]; then
    cat "$CONTEXT_FILE"
  else
    echo ""
  fi
}

save_context() {
  echo "$1" > "$CONTEXT_FILE"
}

context=$(load_context)
while true; do
  echo -n "User: "
  read -r user_input

  if [ "$user_input" == "quit" ]; then
    break
  fi

  context+="User: $user_input\n"



  escaped_context=$(echo "$context" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')
  json_request=$(cat <<- EOM
{
  "model": "$MODEL",
  "messages": [{"role": "system", "content": "You are now chatting with an AI assistant. Ask any questions you have!"}, {"role": "user", "content": $escaped_context}],
  "max_tokens": 500,
  "n": 1,
  "temperature": 0.7
}
EOM
  )

  chat_gpt_response=$(curl -s -X POST "https://api.openai.com/v1/chat/completions" -H "$HEADER_CONTENT_TYPE" -H "$HEADER_AUTHORIZATION" -d "$json_request" | python3 -c 'import json,sys; response=json.load(sys.stdin); print(response["choices"][0]["message"]["content"].strip())')

  echo "ChatGPT: $chat_gpt_response"

  context+="ChatGPT: $chat_gpt_response\n"
  save_context "$context"
done

rm -f "$CONTEXT_FILE"
