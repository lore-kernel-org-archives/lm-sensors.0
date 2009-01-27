From: Andre Prendel <andre_prendel@gmx.de>
Date: Tue, 27 Jan 2009 09:00:43 +0000
Subject: [lm-sensors] [Patch] Fix exit code of the sensors tool
Message-Id: <20090127090043.GA4479@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

This patch fixes the exit code of the sensors tool in error case
(e.g. No sensors found).

Error is set correctly, but at exit label exit() returns res instead
of error.

Andre

---

--- lm-sensors-dev/prog/sensors/main.c	2009-01-26 22:49:09.000000000 +0100
+++ my-lm-sensors/prog/sensors/main.c	2009-01-26 22:19:06.000000000 +0100
@@ -243,7 +243,7 @@
 
 int main(int argc, char *argv[])
 {
-	int c, res, i, error, do_bus_list;
+	int c, res, i, error = 0, do_bus_list;
 	const char *config_file_name = NULL;
 
 	struct option long_opts[] =  {
@@ -344,5 +344,5 @@
 
 exit:
 	sensors_cleanup();
-	exit(res);
+	exit(error);
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
