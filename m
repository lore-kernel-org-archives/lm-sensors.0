From: eggert.ehmke@berlin.de (Eggert Ehmke)
Date: Fri, 17 Jun 2005 14:00:13 +0000
Subject: [lm-sensors] i2c-patch for toshiba a40
Message-Id: <E1DjFVT-000HtE-GT@daiquiri.visp.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

some time ago a patch was posted that added smbus support for the
toshiba a40 notebook to the linux kernel:
http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040921/44447a38/quirks.c.bin
The patch did not work on the actual kernel 2.6.11, but I managed to
adapt it. Is there any activity to get those patches inserted in the
official kernel tree? Otherwise I would have to reapply the patch with
each new kernel version...
Eggert
