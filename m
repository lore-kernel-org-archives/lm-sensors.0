From: Andre Prendel <andre_prendel@gmx.de>
Date: Wed, 18 Feb 2009 08:20:08 +0000
Subject: [lm-sensors] [Patch] libsensors: Fix wrong behaviour in multiple
Message-Id: <20090218082008.GA4230@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The support for multiple configuration files causes a fatal error if
/etc/sensors.d does not exist.

That shouldn't be treated as an error. This patch fixes that.

--- lm-sensors-dev/lib/init.c	2009-02-16 14:12:50.000000000 +0100
+++ my-sensors/lib/init.c	2009-02-17 23:15:46.000000000 +0100
@@ -124,10 +124,15 @@ static int add_config_from_dir(const cha
 	struct dirent **namelist;
 
 	count = scandir(dir, &namelist, config_file_filter, alphasort);
+	/* Do not return an error if directory does not exist or is empty. */
 	if (count < 0) {
+		if (errno = ENOENT)
+			return 0;
+		
 		sensors_parse_error_wfn(strerror(errno), NULL, 0);
 		return -SENSORS_ERR_PARSE;
-	}
+	} else if (!count)
+		return 0;
 
 	for (res = 0, i = 0; !res && i < count; i++) {
 		int len;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
