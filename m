From: jirislaby@gmail.com (Jiri Slaby)
Date: Fri, 26 May 2006 00:07:58 +0000
Subject: [lm-sensors] [PATCH 0/3 #2] avoid pci_find_device
Message-Id: <2005009.119285689fuj@nikdo.nikde.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com, netdev@vger.kernel.org, khali@linux-fr.org, lm-sensors@lm-sensors.org, stevel@mvista.com, source@mvista.com, mb@bu3sch.de, st3@riseup.net, linville@tuxdriver.com

Hello,

there are some patches to avoid pci_find_device in drivers, next will come in
future.

Take #2.

It's against 2.6.17-rc4-mm3 tree.

01-i2c-scx200-acb-avoid-pci-find-device.patch
02-bcm43xx-avoid-pci-find-device.patch
03-gt96100eth-avoid-pci-find-device.patch

 i2c/busses/scx200_acb.c             |    9 ++++++---
 net/gt96100eth.c                    |   10 +++++++---
 net/wireless/bcm43xx/bcm43xx_main.c |   20 ++++++++++++++++----
 3 files changed, 29 insertions(+), 10 deletions(-)

Thanks.

