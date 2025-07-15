#!/bin/bash

###
# This is the Raspberry Pi Community info dumper entry point. The additional file is necessary as another pipe is needed for user input,
# it is easier to have bash use a file pipe than it is to use named pipes. This will also help for future expansion. - illegitimate-egg (2025-07-15)
###

# Acquire script
curl -sSL https://raw.githubusercontent.com/K9T33NwthTookThis/RPC-info-dumper/refs/heads/main/main.sh > /tmp/rpc-info-dumper.sh
chmod +x /tmp/rpc-info-dumper.sh

# Launch that thing
exec sudo bash /tmp/rpc-info-dumper.sh </dev/tty
