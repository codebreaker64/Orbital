import random
import json
import torch
from model import NeuralNet
from nltk_utils import bag_of_words, tokenize

# Load intents file
with open('intents.json', 'r') as f:
    intents = json.load(f)

# Load the trained model's state and other data
FILE = "data.pth"
data = torch.load(FILE)

# Extract data from the loaded state
input_size = data["input_size"]
hidden_size = data["hidden_size"]
output_size = data["output_size"]
all_words = data["all_words"]
tags = data["tags"]
model_state = data["model_state"]

# Set device to GPU if available, otherwise use CPU
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

# Initialize the model
model = NeuralNet(input_size, hidden_size, output_size).to(device)
model.load_state_dict(model_state)
model.eval()

# Convert the model to TorchScript
scripted_model = torch.jit.script(model)

# Save the scripted model
scripted_model.save("model.pt")

print("Model saved as model.pt")


    

    