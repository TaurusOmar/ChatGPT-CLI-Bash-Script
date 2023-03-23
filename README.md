# ChatGPT Bash CLI 
This Bash script allows users to interact with OpenAI's ChatGPT language model through the OpenAI API.

## Main function 
Defines a context file for the conversation, creates it if it doesn't exist, loads and saves it, allowing the user to follow the conversation thread with ChatGPT. When the user decides to exit ChatGPT, the script deletes the "chat_context" file to recreate it the next time it is executed.

```

CONTEXT_FILE="chat_context.txt"
touch "$CONTEXT_FILE"

load_context() {

}

save_context() {

}

rm -f "$CONTEXT_FILE"
```



## Usage instructions:

1. Replace 'your_api_key' with your personal OpenAI API key on the API_KEY line.
2. chmod +x gpt.sh.
3. Add alias to bashrc or zshrc alias gpt=/root/gpt.sh
4. Execute the script in your terminal.
5. Interact with the language model by entering text in the terminal.
6. To exit the script, type 'exit'.

