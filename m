From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 27 Mar 2009 18:59:16 +0000
Subject: [lm-sensors] PATCH: hwmon-fschmd-add-hds-v2.patch
Message-Id: <49CD2204.4020308@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for the Hades to the FSC hwmon driver, this patch
is to be applied on top of the one adding support for the Syleus.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
diff -up vanilla-2.6.29/drivers/hwmon/Kconfig.orig vanilla-2.6.29/drivers/hwmon/Kconfig
--- vanilla-2.6.29/drivers/hwmon/Kconfig.orig	2009-03-27 12:56:23.000000000 +0100
+++ vanilla-2.6.29/drivers/hwmon/Kconfig	2009-03-27 17:04:26.000000000 +0100
@@ -348,8 +348,8 @@ config SENSORS_FSCHMD
  	help
  	  If you say yes here you get support for the following Fujitsu
  	  Siemens Computers (FSC) sensor chips: Poseidon, Scylla, Hermes,
-	  Heimdall, Heracles and Syleus including support for the integrated
-	  watchdog.
+	  Heimdall, Heracles, Hades and Syleus including support for the
+	  integrated watchdog.

  	  This is a merged driver for FSC sensor chips replacing the fscpos,
  	  fscscy and fscher drivers and adding support for several other FSC
diff -up vanilla-2.6.29/drivers/hwmon/fschmd.c.orig vanilla-2.6.29/drivers/hwmon/fschmd.c
--- vanilla-2.6.29/drivers/hwmon/fschmd.c.orig	2009-03-27 12:58:21.000000000 +0100
+++ vanilla-2.6.29/drivers/hwmon/fschmd.c	2009-03-27 16:50:56.000000000 +0100
@@ -19,7 +19,7 @@

  /*
   *  Merged Fujitsu Siemens hwmon driver, supporting the Poseidon, Hermes,
- *  Scylla, Heracles, Heimdall and Syleus chips
+ *  Scylla, Heracles, Heimdall, Hades and Syleus chips
   *
   *  Based on the original 2.4 fscscy, 2.6 fscpos, 2.6 fscher and 2.6
   *  (candidate) fschmd drivers:
@@ -56,7 +56,7 @@ static int nowayout = WATCHDOG_NOWAYOUT;
  module_param(nowayout, int, 0);
  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
  	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-I2C_CLIENT_INSMOD_6(fscpos, fscher, fscscy, fschrc, fschmd, fscsyl);
+I2C_CLIENT_INSMOD_7(fscpos, fscher, fscscy, fschrc, fschmd, fschds, fscsyl);

  /*
   * The FSCHMD registers and other defines
@@ -75,12 +75,12 @@ I2C_CLIENT_INSMOD_6(fscpos, fscher, fscs
  #define FSCHMD_CONTROL_ALERT_LED	0x01

  /* watchdog */
-static const u8 FSCHMD_REG_WDOG_CONTROL[6] -	{ 0x21, 0x21, 0x21, 0x21, 0x21, 0x28 };
-static const u8 FSCHMD_REG_WDOG_STATE[6] -	{ 0x23, 0x23, 0x23, 0x23, 0x23, 0x29 };
-static const u8 FSCHMD_REG_WDOG_PRESET[6] -	{ 0x28, 0x28, 0x28, 0x28, 0x28, 0x2a };
+static const u8 FSCHMD_REG_WDOG_CONTROL[7] +	{ 0x21, 0x21, 0x21, 0x21, 0x21, 0x28, 0x28 };
+static const u8 FSCHMD_REG_WDOG_STATE[7] +	{ 0x23, 0x23, 0x23, 0x23, 0x23, 0x29, 0x29 };
+static const u8 FSCHMD_REG_WDOG_PRESET[7] +	{ 0x28, 0x28, 0x28, 0x28, 0x28, 0x2a, 0x2a };

  #define FSCHMD_WDOG_CONTROL_TRIGGER	0x10
  #define FSCHMD_WDOG_CONTROL_STARTED	0x10 /* the same as trigger */
@@ -90,61 +90,66 @@ static const u8 FSCHMD_REG_WDOG_PRESET[6
  #define FSCHMD_WDOG_STATE_CARDRESET	0x02

  /* voltages, weird order is to keep the same order as the old drivers */
-static const u8 FSCHMD_REG_VOLT[6][6] = {
+static const u8 FSCHMD_REG_VOLT[7][6] = {
  	{ 0x45, 0x42, 0x48 },				/* pos */
  	{ 0x45, 0x42, 0x48 },				/* her */
  	{ 0x45, 0x42, 0x48 },				/* scy */
  	{ 0x45, 0x42, 0x48 },				/* hrc */
  	{ 0x45, 0x42, 0x48 },				/* hmd */
+	{ 0x21, 0x20, 0x22 },				/* hds */
  	{ 0x21, 0x20, 0x22, 0x23, 0x24, 0x25 },		/* syl */
  };

-static const int FSCHMD_NO_VOLT_SENSORS[6] = { 3, 3, 3, 3, 3, 6 };
+static const int FSCHMD_NO_VOLT_SENSORS[7] = { 3, 3, 3, 3, 3, 3, 6 };

  /* minimum pwm at which the fan is driven (pwm can by increased depending on
     the temp. Notice that for the scy some fans share there minimum speed.
     Also notice that with the scy the sensor order is different than with the
     other chips, this order was in the 2.4 driver and kept for consistency. */
-static const u8 FSCHMD_REG_FAN_MIN[6][7] = {
+static const u8 FSCHMD_REG_FAN_MIN[7][7] = {
  	{ 0x55, 0x65 },					/* pos */
  	{ 0x55, 0x65, 0xb5 },				/* her */
  	{ 0x65, 0x65, 0x55, 0xa5, 0x55, 0xa5 },		/* scy */
  	{ 0x55, 0x65, 0xa5, 0xb5 },			/* hrc */
  	{ 0x55, 0x65, 0xa5, 0xb5, 0xc5 },		/* hmd */
+	{ 0x55, 0x65, 0xa5, 0xb5, 0xc5 },		/* hds */
  	{ 0x54, 0x64, 0x74, 0x84, 0x94, 0xa4, 0xb4 },	/* syl */
  };

  /* actual fan speed */
-static const u8 FSCHMD_REG_FAN_ACT[6][7] = {
+static const u8 FSCHMD_REG_FAN_ACT[7][7] = {
  	{ 0x0e, 0x6b, 0xab },				/* pos */
  	{ 0x0e, 0x6b, 0xbb },				/* her */
  	{ 0x6b, 0x6c, 0x0e, 0xab, 0x5c, 0xbb },		/* scy */
  	{ 0x0e, 0x6b, 0xab, 0xbb },			/* hrc */
  	{ 0x5b, 0x6b, 0xab, 0xbb, 0xcb },		/* hmd */
+	{ 0x5b, 0x6b, 0xab, 0xbb, 0xcb },		/* hds */
  	{ 0x57, 0x67, 0x77, 0x87, 0x97, 0xa7, 0xb7 },	/* syl */
  };

  /* fan status registers */
-static const u8 FSCHMD_REG_FAN_STATE[6][7] = {
+static const u8 FSCHMD_REG_FAN_STATE[7][7] = {
  	{ 0x0d, 0x62, 0xa2 },				/* pos */
  	{ 0x0d, 0x62, 0xb2 },				/* her */
  	{ 0x62, 0x61, 0x0d, 0xa2, 0x52, 0xb2 },		/* scy */
  	{ 0x0d, 0x62, 0xa2, 0xb2 },			/* hrc */
  	{ 0x52, 0x62, 0xa2, 0xb2, 0xc2 },		/* hmd */
+	{ 0x52, 0x62, 0xa2, 0xb2, 0xc2 },		/* hds */
  	{ 0x50, 0x60, 0x70, 0x80, 0x90, 0xa0, 0xb0 },	/* syl */
  };

  /* fan ripple / divider registers */
-static const u8 FSCHMD_REG_FAN_RIPPLE[6][7] = {
+static const u8 FSCHMD_REG_FAN_RIPPLE[7][7] = {
  	{ 0x0f, 0x6f, 0xaf },				/* pos */
  	{ 0x0f, 0x6f, 0xbf },				/* her */
  	{ 0x6f, 0x6f, 0x0f, 0xaf, 0x0f, 0xbf },		/* scy */
  	{ 0x0f, 0x6f, 0xaf, 0xbf },			/* hrc */
  	{ 0x5f, 0x6f, 0xaf, 0xbf, 0xcf },		/* hmd */
+	{ 0x5f, 0x6f, 0xaf, 0xbf, 0xcf },		/* hds */
  	{ 0x56, 0x66, 0x76, 0x86, 0x96, 0xa6, 0xb6 },	/* syl */
  };

-static const int FSCHMD_NO_FAN_SENSORS[6] = { 3, 3, 6, 4, 5, 7 };
+static const int FSCHMD_NO_FAN_SENSORS[7] = { 3, 3, 6, 4, 5, 5, 7 };

  /* Fan status register bitmasks */
  #define FSCHMD_FAN_ALARM	0x04 /* called fault by FSC! */
@@ -153,23 +158,25 @@ static const int FSCHMD_NO_FAN_SENSORS[6


  /* actual temperature registers */
-static const u8 FSCHMD_REG_TEMP_ACT[6][11] = {
+static const u8 FSCHMD_REG_TEMP_ACT[7][11] = {
  	{ 0x64, 0x32, 0x35 },				/* pos */
  	{ 0x64, 0x32, 0x35 },				/* her */
  	{ 0x64, 0xD0, 0x32, 0x35 },			/* scy */
  	{ 0x64, 0x32, 0x35 },				/* hrc */
  	{ 0x70, 0x80, 0x90, 0xd0, 0xe0 },		/* hmd */
+	{ 0x70, 0x80, 0x90, 0xd0, 0xe0 },		/* hds */
  	{ 0x58, 0x68, 0x78, 0x88, 0x98, 0xa8,		/* syl */
  	  0xb8, 0xc8, 0xd8, 0xe8, 0xf8 },
  };

  /* temperature state registers */
-static const u8 FSCHMD_REG_TEMP_STATE[6][11] = {
+static const u8 FSCHMD_REG_TEMP_STATE[7][11] = {
  	{ 0x71, 0x81, 0x91 },				/* pos */
  	{ 0x71, 0x81, 0x91 },				/* her */
  	{ 0x71, 0xd1, 0x81, 0x91 },			/* scy */
  	{ 0x71, 0x81, 0x91 },				/* hrc */
  	{ 0x71, 0x81, 0x91, 0xd1, 0xe1 },		/* hmd */
+	{ 0x71, 0x81, 0x91, 0xd1, 0xe1 },		/* hds */
  	{ 0x59, 0x69, 0x79, 0x89, 0x99, 0xa9,		/* syl */
  	  0xb9, 0xc9, 0xd9, 0xe9, 0xf9 },
  };
@@ -179,12 +186,13 @@ static const u8 FSCHMD_REG_TEMP_STATE[6]
     in the fscscy 2.4 driver. FSC has confirmed that the fschmd has registers
     at these addresses, but doesn't want to confirm they are the same as with
     the fscher?? */
-static const u8 FSCHMD_REG_TEMP_LIMIT[6][11] = {
+static const u8 FSCHMD_REG_TEMP_LIMIT[7][11] = {
  	{ 0, 0, 0 },					/* pos */
  	{ 0x76, 0x86, 0x96 },				/* her */
  	{ 0x76, 0xd6, 0x86, 0x96 },			/* scy */
  	{ 0x76, 0x86, 0x96 },				/* hrc */
  	{ 0x76, 0x86, 0x96, 0xd6, 0xe6 },		/* hmd */
+	{ 0x76, 0x86, 0x96, 0xd6, 0xe6 },		/* hds */
  	{ 0x5a, 0x6a, 0x7a, 0x8a, 0x9a, 0xaa,		/* syl */
  	  0xba, 0xca, 0xda, 0xea, 0xfa },
  };
@@ -197,7 +205,7 @@ static const u8 FSCHMD_REG_TEMP_LIMIT[6]
  static const u8 FSCHER_REG_TEMP_AUTOP1[] =	{ 0x73, 0x83, 0x93 };
  static const u8 FSCHER_REG_TEMP_AUTOP2[] =	{ 0x75, 0x85, 0x95 }; */

-static const int FSCHMD_NO_TEMP_SENSORS[6] = { 3, 3, 4, 3, 5, 11 };
+static const int FSCHMD_NO_TEMP_SENSORS[7] = { 3, 3, 4, 3, 5, 5, 11 };

  /* temp status register bitmasks */
  #define FSCHMD_TEMP_WORKING	0x01
@@ -228,6 +236,7 @@ static const struct i2c_device_id fschmd
  	{ "fscscy", fscscy },
  	{ "fschrc", fschrc },
  	{ "fschmd", fschmd },
+	{ "fschds", fschds },
  	{ "fscsyl", fscsyl },
  	{ }
  };
@@ -1021,6 +1030,8 @@ static int fschmd_detect(struct i2c_clie
  			kind = fschrc;
  		else if (!strcmp(id, "HMD"))
  			kind = fschmd;
+		else if (!strcmp(id, "HDS"))
+			kind = fschds;
  		else if (!strcmp(id, "SYL"))
  			kind = fscsyl;
  		else
@@ -1036,8 +1047,8 @@ static int fschmd_probe(struct i2c_clien
  			const struct i2c_device_id *id)
  {
  	struct fschmd_data *data;
-	const char * const names[6] = { "Poseidon", "Hermes", "Scylla",
-					"Heracles", "Heimdall", "Syleus" };
+	const char * const names[7] = { "Poseidon", "Hermes", "Scylla",
+				"Heracles", "Heimdall", "Hades", "Syleus" };
  	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
  	int i, err;
  	enum chips kind = id->driver_data;
@@ -1319,8 +1330,8 @@ static void __exit fschmd_exit(void)
  }

  MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles, Heimdall and "
-			"Syleus driver");
+MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles, Heimdall, Hades "
+			"and Syleus driver");
  MODULE_LICENSE("GPL");

  module_init(fschmd_init);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
