From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Mon, 07 Mar 2011 21:10:01 +0000
Subject: [lm-sensors] [PATCH v2 01/01] hwmon: (w83627ehf) Add fan debounce
Message-Id: <7E56C3DF95D0439295EE35310161EE11@portable2>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Version 1
The nct6776f and nct6775f support debouncing the fan RPM signal, this can 
help improve the stability of th RPM signal for some fans (Arctic cooling 
fans for example).
This patch adds a module parameter fan_debounce, which when set to 1 enables 
debounce for all fans that the chip supports.

Version 2
Coding style changes based on comments from Guenter Roeck.
Move the register setting code to w83627ehf_probe from w83627ehf_find

Signed-off-by:  Ian Dobson <i.dobson@planet-ian.com>
----

--- w83627ehf.c.sav	2011-03-07 21:21:08.029716200 +0100
+++ w83627ehf.c	2011-03-07 21:53:21.223307000 +0100
@@ -79,6 +79,10 @@
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");

+static unsigned short fan_debounce;
+module_param(fan_debounce, ushort, 0);
+MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
+
 #define DRVNAME "w83627ehf"

 /*
@@ -187,6 +191,7 @@
 /* NCT6775F has its own fan divider registers */
 #define NCT6775_REG_FANDIV1		0x506
 #define NCT6775_REG_FANDIV2		0x507
+#define NCT6775_REG_FAN_DEBOUNCE	0xf0

 #define W83627EHF_REG_ALARM1		0x459
 #define W83627EHF_REG_ALARM2		0x45A
@@ -2089,6 +2094,20 @@
 		fan5pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x02);
 		fan4min = fan4pin;
 	}
+
+	if (fan_debounce &&
+		(sio_data->kind = nct6775 || sio_data->kind = nct6776)) {
+		u8 tmp;
+		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
+		tmp = superio_inb(sio_data->sioreg, NCT6775_REG_FAN_DEBOUNCE);
+		if (sio_data->kind = nct6776)
+			superio_outb(sio_data->sioreg, NCT6775_REG_FAN_DEBOUNCE,
+				0x3e | tmp);
+		else
+			superio_outb(sio_data->sioreg, NCT6775_REG_FAN_DEBOUNCE,
+				0x1e | tmp);
+		pr_info("Enabled fan debounce for chip %s\n", data->name);
+	}
 	superio_exit(sio_data->sioreg);

 	/* It looks like fan4 and fan5 pins can be alternatively used


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
