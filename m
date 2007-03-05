From: corentin.labbe@geomatys.fr (corentin.labbe)
Date: Mon, 05 Mar 2007 21:25:58 +0000
Subject: [lm-sensors] sensor-detect patch for detecting SMSC SCH5504-NS
Message-Id: <45EC8AE6.3090804@geomatys.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5E8AB.9060809@geomatys.fr>
In-Reply-To: <45D5E8AB.9060809@geomatys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

patch patched:)

--- sensors-detect-old  2007-03-04 21:16:18.000000000 +0100
+++ sensors-detect      2007-03-05 22:22:56.000000000 +0100
@@ -1812,6 +1812,12 @@
          logdev => 0x08,
        },
        {
+        name => "SMSC SCH5504-NS Super IO",
+        # No datasheet
+        driver => "not-a-sensor",
+        devid => 0x79,
+      },
+      {
          name => "SMSC LPC47M584-NC Super IO",
          # No datasheet
          devid => 0x76,

