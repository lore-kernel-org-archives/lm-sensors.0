From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Jun 2006 19:09:20 +0000
Subject: [lm-sensors] [PATCH 00/14] i2c and hwmon updates
Message-Id: <20060612210920.59c64202.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 14-piece i2c and hwmon update patchset. We have a new
hardware monitoring driver (lm70, for the National Semiconductor LM70
SPI thermal sensor chip), cleanups to the scx200_acb and i2c-i801 SMBus
drivers, and a few other minor fixes. All of this is meant for
-mm/2.6.18.

Here's the summary:

Jean Delvare:
 o scx200_acb: Mark scx200_acb_probe __init
 o scx200_acb: Documentation update
 o i2c-i801: Fix block transaction poll loops
 o i2c-i801: Remove force_addr parameter
 o i2c-i801: Remove PCI function check
 o i2c-i801: Cleanups
 o i2c-i801: Better pci subsystem integration
 o i2c-i801: Merge setup function
 o hwmon: Fix the Kconfig header

Jordan Crouse:
 o scx200_acb: Use PCI I/O resource when appropriate

Kaiwan N Billimoria:
 o lm70: New hardware monitoring driver

Krzysztof Halasa:
 o i2c: Mark block write buffers as const

Peter Korsgaard:
 o i2c-ocores: Minor cleanups

Rudolf Marek:
 o hwmon-vid: Add support for Intel Core and Conroe

Statistics:

 Documentation/hwmon/lm70            |   31 +++++
 Documentation/i2c/busses/i2c-i801   |    3 -
 Documentation/i2c/busses/scx200_acb |   19 +++
 MAINTAINERS                         |    6 +
 drivers/hwmon/Kconfig               |   12 ++
 drivers/hwmon/Makefile              |    1 +
 drivers/hwmon/hwmon-vid.c           |   35 +++++-
 drivers/hwmon/lm70.c                |  165 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-i801.c       |  154 +++++++++++----------------
 drivers/i2c/busses/i2c-ocores.c     |    6 -
 drivers/i2c/busses/scx200_acb.c     |  202 ++++++++++++++++++++++++++---------
 drivers/i2c/i2c-core.c              |    4 
 include/linux/i2c.h                 |    4 
 13 files changed, 479 insertions(+), 163 deletions(-)

-- 
Jean Delvare

