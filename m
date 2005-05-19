From: bon@elektron.ikp.physik.tu-darmstadt.de (Uwe Bonnes)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Expose switches in w83781d
Message-Id: <15915.5243.486340.725978@hertz.ikp.physik.tu-darmstadt.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

appended patch exposes the switches in the W83781d. In my Gigabyte BXD6 I
can switch on and off the fans of the CPU by switching bit 3 off the
switch. I have a small user space control program that reads out
/proc/uptime, does some filtering and controls the fan. I would appreciate
that something like this could goto into the standard lmsensors
distribution.

Bye
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
--- linux-2.4.19.SuSE/include/linux/sensors.h.orig	2003-01-03 11:02:48.000000000 +0100
+++ linux-2.4.19.SuSE/include/linux/sensors.h	2003-01-05 02:11:30.000000000 +0100
@@ -75,6 +75,7 @@
 #define W83781D_SYSCTL_PWM2 1402
 #define W83781D_SYSCTL_PWM3 1403
 #define W83781D_SYSCTL_PWM4 1404
+#define W83781D_SYSCTL_SW   1405
 #define W83781D_SYSCTL_SENS1 1501	/* 1, 2, or Beta (3000-5000) */
 #define W83781D_SYSCTL_SENS2 1502
 #define W83781D_SYSCTL_SENS3 1503
--- linux-2.4.19.SuSE//drivers/sensors/w83781d.c.orig	2003-01-03 11:02:47.000000000 +0100
+++ linux-2.4.19.SuSE//drivers/sensors/w83781d.c	2003-01-05 02:34:42.000000000 +0100
@@ -376,6 +376,7 @@
 #ifdef W83781D_RT
 	u8 rt[3][32];		/* Register value */
 #endif
+	u8 sw;
 	u8 vrm;
 };
 
@@ -430,6 +431,8 @@
 static void w83781d_rt(struct i2c_client *client, int operation,
 		       int ctl_name, int *nrels_mag, long *results);
 #endif
+static void w83781d_sw(struct i2c_client *client, int operation,
+			 int ctl_name, int *nrels_mag, long *results);
 static u16 swap_bytes(u16 val);
 
 static int w83781d_id = 0;
@@ -545,6 +548,8 @@
 	{W83781D_SYSCTL_RT3, "rt3", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83781d_rt},
 #endif
+	{W83781D_SYSCTL_SW, "sw", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_sw},
 	{0}
 };
 
@@ -1580,6 +1585,7 @@
 		data->beep_enable = i >> 7;
 		data->beeps = ((i & 0x7f) << 8) +
 		    w83781d_read_value(client, W83781D_REG_BEEP_INTS1);
+		data->sw = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG) & 0x3f;
 		if ((data->type != w83781d) && (data->type != as99127f)) {
 			data->beeps | 			    w83781d_read_value(client,
@@ -1916,6 +1922,26 @@
 	}
 }
 
+void w83781d_sw(struct i2c_client *client, int operation, int ctl_name,
+		 int *nrels_mag, long *results)
+{
+	struct w83781d_data *data = client->data;
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		w83781d_update_client(client);
+		results[0] = data->sw;
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >= 1) {
+			data->sw = results[0] & 0x3f;
+			w83781d_write_value(client, W83781D_REG_BEEP_CONFIG,
+					    data->sw);
+		}
+	}
+}
+
 void w83781d_sens(struct i2c_client *client, int operation, int ctl_name,
 		  int *nrels_mag, long *results)
 {
