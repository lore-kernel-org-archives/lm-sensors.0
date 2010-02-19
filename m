From: Andre Prendel <andre.prendel@gmx.de>
Date: Fri, 19 Feb 2010 19:39:22 +0000
Subject: [lm-sensors] [RFC PATCH v2 2/2] Add the sensors-config tool
Message-Id: <20100219193922.GC1917@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a template for using sensors-config tool from within an init
script at system startup.
---

Index: sensors/prog/detect/install.sh
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sensors/prog/detect/install.sh	2010-02-19 19:21:45.763035204 +0100
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+FOUND=`./sensors-config.py -f -y|wc -l`
+if [ $FOUND -eq 0 ]; then
+    echo "No config found"
+    rm -f /etc/sensors.d/automobo.conf
+else
+    echo "Config found"
+fi
+
+exit 0

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
