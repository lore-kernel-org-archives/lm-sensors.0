From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: [PATCH] 2.6 preparations for documentation update
Message-Id: <Pine.LNX.4.58.0502081427510.7839@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Please apply following patch.

It is a "style" update for documentation. When done please move this
i2c-parport file to new busses/ subdirectory. Patch to fill this directory
with documentation will follow.

Thanks

Rudolf

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>

diff -Naur a/Documentation/i2c/i2c-parport c/Documentation/i2c/i2c-parport
--- a/Documentation/i2c/i2c-parport	2005-02-03 02:55:00.000000000 +0100
+++ c/Documentation/i2c/i2c-parport	2005-02-04 22:27:00.000000000 +0100
@@ -1,8 +1,6 @@
-=========
-i2c-parport driver
-=========
+Kernel driver i2c-parport

-2004-07-06, Jean Delvare
+Author: Jean Delvare <khali@linux-fr.org>

 This is a unified driver for several i2c-over-parallel-port adapters,
 such as the ones made by Philips, Velleman or ELV. This driver is
