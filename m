From: "Ivo Manca" <pinkel@gmail.com>
Date: Fri, 08 Jun 2007 14:34:05 +0000
Subject: [lm-sensors] [PATCH 2/3] prog/init/detect_new_dmi_info: Allows
Message-Id: <02e401c7a9da$12498040$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch creates a file in prog/init/ which can be used to detect if a new
motherboard is used. When this is the case, sensors-detect -a will be
called.
I have not intergrated this script to any existing scripts; I'll leave that
to you (as in: people that know more about how to do it :)).

Ivo Manca
---
diff -ubrN lm-sensors-3.0.0/prog/init/detect_new_dmi_info
lm-sensors.new/prog/init/detect_new_dmi_info
--- lm-sensors-3.0.0/prog/init/detect_new_dmi_info 1970-01-01
01:00:00.000000000 +0100
+++ lm-sensors.new/prog/init/detect_new_dmi_info 2007-05-30
13:18:58.000000000 +0200
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+OLDDMIFILE=/etc/dmistrings
+
+# don't use -t system, since you also get logging info
+NEWDMI=`dmidecode -s system-manufacturer 2> /dev/null`
+NEWDMI="$NEWDMI`dmidecode -s system-product-name 2> /dev/null`"
+NEWDMI="$NEWDMI`dmidecode -s system-version 2> /dev/null`"
+NEWDMI="$NEWDMI`dmidecode -s baseboard-manufacturer 2> /dev/null`"
+NEWDMI="$NEWDMI`dmidecode -s baseboard-product-name 2> /dev/null`"
+NEWDMI="$NEWDMI`dmidecode -s baseboard-version 2> /dev/null`"
+
+if [ ! -r "$OLDDMIFILE" ]
+then
+  sensors-detect -a > /dev/null 2> /dev/null
+else
+  # read $OLDDMIFILE
+  OLDDMI=`cat $OLDDMIFILE`
+  if [ "$NEWDMI" != "$OLDDMI" ]
+  then
+    sensors-detect -a > /dev/null 2> /dev/null
+  fi
+fi
+
+exit 0
\ No newline at end of file


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
