From: corentin.labbe@geomatys.fr (corentin.labbe)
Date: Fri, 16 Feb 2007 17:23:55 +0000
Subject: [lm-sensors] sensor-detect patch for detecting SMSC SCH5504-NS
Message-Id: <45D5E8AB.9060809@geomatys.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

This patch add the detecting of the SMSC SCH5504-NS Super IO chip

Signed-off-by: Corentin Labbe <corentin.labbe at geomatys.fr>

--- sensors-detect      2007-01-16 00:04:10.000000000 +0100
+++ sensors-detect-new  2007-02-16 17:59:47.000000000 +0100
@@ -1784,6 +1784,11 @@
          logdev => 0x08,
        },
        {
+        name => "SMSC SCH5504-NS Super IO",
+        driver => "not-a-sensor",
+        devid => 0x79,
+      },
+      {
          name => "SMSC LPC47M584-NC Super IO",
          # No datasheet
          devid => 0x76,

