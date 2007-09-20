From: Bernhard Fischer <rep.dot.nop@gmail.com>
Date: Thu, 20 Sep 2007 12:02:48 +0000
Subject: [lm-sensors] [patch] don't use functions marked as LEGACY in SUSv3
Message-Id: <20070920120248.GG27699@aon.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

I choose not to have index(), rindex(), bzero(), bcopy() et al in my
libc since they are marked as legacy in SUSv3.
The attached patch uses the recommended functions instead.
Please apply.

TIA and cheers,
Bernhard

--GvXjxJ+pjyke8COw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="lm-sensors.01.susv3-legacy.patch"

diff -rdup lm_sensors-2.10.4.oorig/lib/proc.c lm_sensors-2.10.4/lib/proc.c
--- lm_sensors-2.10.4.oorig/lib/proc.c	2007-07-17 06:53:06.000000000 +0200
+++ lm_sensors-2.10.4/lib/proc.c	2007-09-20 13:30:39.000000000 +0200
@@ -93,16 +93,16 @@ int sensors_read_proc_bus(void)
   while (fgets(line,255,f)) {
     if (strlen(line) > 0)
       line[strlen(line)-1] = '\0';
-    if (! (border = rindex(line,'\t')))
+    if (! (border = strrchr(line,'\t')))
       goto ERROR;
     /* Skip algorithm name */
     *border='\0';
-    if (! (border = rindex(line,'\t')))
+    if (! (border = strrchr(line,'\t')))
       goto ERROR;
     if (! (entry.adapter = strdup(border + 1)))
       goto FAT_ERROR;
     *border='\0';
-    if (! (border = rindex(line,'\t')))
+    if (! (border = strrchr(line,'\t')))
       goto ERROR;
     *border='\0';
     if (strncmp(line,"i2c-",4))
@@ -155,8 +155,8 @@ int sensors_read_proc(sensors_chip_name 
 		strcpy(n, name.busname);
 		strcat(n, "/");
 		strcpy(altn, n);
-		/* use rindex to append sysname to n */
-		getsysname(the_feature, rindex(n, '\0'), &mag, rindex(altn, '\0'));
+		/* use strrchr to append sysname to n */
+		getsysname(the_feature, strrchr(n, '\0'), &mag, strrchr(altn, '\0'));
 		if ((f = fopen(n, "r")) != NULL
 		 || (f = fopen(altn, "r")) != NULL) {
 			int res = fscanf(f, "%lf", value);
@@ -198,8 +198,8 @@ int sensors_write_proc(sensors_chip_name
 		strcpy(n, name.busname);
 		strcat(n, "/");
 		strcpy(altn, n);
-		/* use rindex to append sysname to n */
-		getsysname(the_feature, rindex(n, '\0'), &mag, rindex(altn, '\0'));
+		/* use strrchr to append sysname to n */
+		getsysname(the_feature, strrchr(n, '\0'), &mag, strrchr(altn, '\0'));
 		if ((f = fopen(n, "w")) != NULL
 		 || (f = fopen(altn, "w")) != NULL) {
 			for (; mag > 0; mag --)
diff -rdup lm_sensors-2.10.4.oorig/prog/dump/i2cbusses.c lm_sensors-2.10.4/prog/dump/i2cbusses.c
--- lm_sensors-2.10.4.oorig/prog/dump/i2cbusses.c	2007-07-17 06:53:10.000000000 +0200
+++ lm_sensors-2.10.4/prog/dump/i2cbusses.c	2007-09-20 13:29:19.000000000 +0200
@@ -185,7 +185,7 @@ found:
 				fprintf(stderr, "%s: read error\n", n);
 				continue;
 			}
-			if((border = index(x, '\n')) != NULL)
+			if((border = strchr(x, '\n')) != NULL)
 				*border = 0;
 			if(count++ == 0 && !procfmt)
 				fprintf(stderr,"  Installed I2C busses:\n");

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--GvXjxJ+pjyke8COw--
