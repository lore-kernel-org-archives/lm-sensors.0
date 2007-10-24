From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 15:25:04 +0000
Subject: [lm-sensors] [PATCH 5/6] Make the configuration file optional
Message-Id: <20071024172504.4e4c04a1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make the configuration file optional. Although in most cases it's not
very useful to use libsensors without a configuration file, I fail to
see the rationale for making a configuration file mandatory.

---
 lib/init.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- lm-sensors-3.orig/lib/init.c	2007-10-20 16:28:57.000000000 +0200
+++ lm-sensors-3/lib/init.c	2007-10-20 16:29:41.000000000 +0200
@@ -49,14 +49,14 @@ int sensors_init(FILE *input)
 	} else {
 		/* No configuration provided, use default */
 		input = fopen(DEFAULT_CONFIG_FILE, "r");
-		if (!input)
-			goto exit_cleanup;
-		if (sensors_scanner_init(input) ||
-		    sensors_yyparse()) {
+		if (input) {
+			if (sensors_scanner_init(input) ||
+			    sensors_yyparse()) {
+				fclose(input);
+				goto exit_cleanup;
+			}
 			fclose(input);
-			goto exit_cleanup;
 		}
-		fclose(input);
 	}
 
 	if ((res = sensors_substitute_busses()))


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
