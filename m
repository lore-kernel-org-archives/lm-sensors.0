From: gregkh@suse.de (Greg KH)
Date: Tue, 12 Jul 2005 00:04:45 +0000
Subject: [lm-sensors] [PATCH] I2C: max6875 documentation update
Message-Id: <11211193761992@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050711220123.GA3807@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: khali@linux-fr.org

[PATCH] I2C: max6875 documentation update

Here is a proposed documentation update for the new max6875 i2c chip
driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 089bd86632769051f15cd7387eebe126d18f151f
tree 57637f07d7cb28543db158d2457804e968d2a021
parent 9ab1ee2ab7d65979c0f14a60ee1f29f8988f5811
author Jean Delvare <khali@linux-fr.org> Thu, 23 Jun 2005 23:37:53 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 Documentation/i2c/chips/max6875 |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/i2c/chips/max6875 b/Documentation/i2c/chips/max6875
--- a/Documentation/i2c/chips/max6875
+++ b/Documentation/i2c/chips/max6875
@@ -2,10 +2,10 @@ Kernel driver max6875
 ========== 
 Supported chips:
-  * Maxim max6874, max6875
-    Prefixes: 'max6875'
+  * Maxim MAX6874, MAX6875
+    Prefix: 'max6875'
     Addresses scanned: 0x50, 0x52
-    Datasheets:
+    Datasheet:
         http://pdfserv.maxim-ic.com/en/ds/MAX6874-MAX6875.pdf
 
 Author: Ben Gardner <bgardner@wabtec.com>
@@ -23,14 +23,26 @@ Module Parameters
 Description
 -----------
 
-The MAXIM max6875 is a EEPROM-programmable power-supply sequencer/supervisor.
+The Maxim MAX6875 is an EEPROM-programmable power-supply sequencer/supervisor.
 It provides timed outputs that can be used as a watchdog, if properly wired.
 It also provides 512 bytes of user EEPROM.
 
-At reset, the max6875 reads the configuration eeprom into its configuration
+At reset, the MAX6875 reads the configuration EEPROM into its configuration
 registers.  The chip then begins to operate according to the values in the
 registers.
 
+The Maxim MAX6874 is a similar, mostly compatible device, with more intputs
+and outputs:
+
+             vin     gpi    vout
+MAX6874        6       4       8
+MAX6875        4       3       5
+
+MAX6874 chips can have four different addresses (as opposed to only two for
+the MAX6875). The additional addresses (0x54 and 0x56) are not probed by
+this driver by default, but the probe module parameter can be used if
+needed.
+
 See the datasheet for details on how to program the EEPROM.
 
 

