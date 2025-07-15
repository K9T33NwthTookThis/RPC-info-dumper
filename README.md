# RPC-info-dumper
This allows us at https://discord.gg/z8fBRnK8 to easily get information about users systems to speed up help.

## Usage
This script can be piped into bash using somekind of network transfer command. It requires sudo as on some systems the dmesg buffer isn't available to non-root users.

The script is also available as a redirect from https://dukesyndicate.org/info-dumper.sh for convenience

| Transfer method | Command                                                           |
|-----------------|-------------------------------------------------------------------|
| curl            | `curl -sSL https://dukesyndicate.org/info-dumper.sh \| sudo bash` |

Deprecated transfer methods:
| Transfer method | Command                                                           | Deprecation reason          |
|-----------------|-------------------------------------------------------------------|-----------------------------|
| wget            | `wget -qO- https://dukesyndicate.org/info-dumper.sh \| sudo bash` | Program now depends on curl |

