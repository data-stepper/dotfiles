# This script downloads and installs the nerd dictation software the
# Also it will install the small and large english language model for dictation

cd ~

pip3 install vosk
git clone https://github.com/ideasman42/nerd-dictation.git
cd nerd-dictation

# And move the executable to the bin directory
sudo cp nerd-dictation /bin

wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.15.zip # Small model
wget https://alphacephei.com/vosk/models/vosk-model-en-us-0.22.zip # Large model

unzip vosk-model-small-en-us-0.15.zip
mv vosk-model-small-en-us-0.15 small_model

unzip vosk-model-en-us-0.22.zip
mv vosk-model-en-us-0.22 large_model

# Let the user know that the models were successfully installed
echo "All models were successfully installed to ~/nerd-dictation"