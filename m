From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Jun 2005 23:38:24 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: max6875 documentation update
Message-Id: <20050623233753.5c65bf0b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here is a proposed documentation update for the new max6875 i2c chip
driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/chips/max6875 |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

--- linux-2.6.12-git5.orig/Documentation/i2c/chips/max6875	2005-06-23 21:32:00.000000000 +0200
+++ linux-2.6.12-git5/Documentation/i2c/chips/max6875	2005-06-23 23:25:59.000000000 +0200
@@ -2,10 +2,10 @@
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
@@ -23,14 +23,26 @@
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
 
 


-- 
Jean Delvare
