From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: EMC6D100 patch
Message-Id: <3F065CC2.8010108@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I had previously put some EMC6D100 support into the LM85 driver.

This patch adds support for the additional 3 voltage inputs on the EMC6D100. 
I also took a closer look at the docs and it doesn't look like we can tell a 
EMC6D100 from a ...101 so I've removed the 101 "kind".  I also avoided 
problems with the doc generator...

Please apply before 2.8.0...

:v)
-------------- next part --------------
Index: lm_sensors2/kernel/chips/lm85.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/lm85.c,v
retrieving revision 1.7
diff -u -r1.7 lm85.c
--- lm_sensors2/kernel/chips/lm85.c	4 Jul 2003 08:41:28 -0000	1.7
+++ lm_sensors2/kernel/chips/lm85.c	5 Jul 2003 05:12:41 -0000
@@ -52,6 +52,7 @@
                  Cleaned up some compiler warnings.
                  Fixed problem with Operating Point and THERM counting
     2003-03-21   Initial support for EMC6D100 and EMC6D101 chips
+    2003-06-30   Add support for EMC6D100 extra voltage inputs.
 */
 
 #include <linux/version.h>
@@ -80,7 +81,7 @@
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d101);
+SENSORS_INSMOD_5(lm85b, lm85c, adm1027, adt7463, emc6d100);
 
 /* Many LM85 constants specified below */
 
@@ -113,11 +114,15 @@
 #define LM85_COMPANY_NATIONAL 0x01
 #define LM85_COMPANY_ANALOG_DEV 0x41
 #define LM85_COMPANY_SMSC 0x5c
+#define LM85_VERSTEP_VMASK 0xf0
+#define LM85_VERSTEP_SMASK 0x0f
 #define LM85_VERSTEP_GENERIC 0x60
 #define LM85_VERSTEP_LM85C 0x60
 #define LM85_VERSTEP_LM85B 0x62
 #define LM85_VERSTEP_ADM1027 0x60
 #define LM85_VERSTEP_ADT7463 0x62
+#define LM85_VERSTEP_EMC6D100_A0 0x60
+#define LM85_VERSTEP_EMC6D100_A1 0x61
 
 #define LM85_REG_CONFIG 0x40
 
@@ -156,6 +161,15 @@
 #define ADT7463_REG_THERM_LIMIT 0x7A
 #define ADT7463_REG_CONFIG4 0x7D
 
+#define EMC6D100_REG_SFR  0x7c
+#define EMC6D100_REG_ALARM3  0x7d
+#define EMC6D100_REG_CONF  0x7f
+#define EMC6D100_REG_INT_EN  0x80
+/* IN5, IN6 and IN7 */
+#define EMC6D100_REG_IN(nr)  (0x70 + ((nr)-5))
+#define EMC6D100_REG_IN_MIN(nr) (0x73 + ((nr)-5) * 2)
+#define EMC6D100_REG_IN_MAX(nr) (0x74 + ((nr)-5) * 2)
+
 /* Conversions. Rounding and limit checking is only done on the TO_REG 
    variants. Note that you should be a bit careful with which arguments
    these macros are called: arguments may be evaluated more than once.
@@ -168,7 +182,8 @@
 
 /* IN are scaled acording to built-in resistors */
 static int lm85_scaling[] = {  /* .001 Volts */
-		2500, 2250, 3300, 5000, 12000
+		2500, 2250, 3300, 5000, 12000,
+		3300, 1500, 1800,	/* EMC6D100 */
 	};
 #define SCALE(val,from,to) (((val)*(to) + ((from)/2))/(from))
 #define INS_TO_REG(n,val)  (SENSORS_LIMIT(SCALE(val,lm85_scaling[n],192),0,255))
@@ -384,9 +399,9 @@
 	unsigned long last_reading;	/* In jiffies */
 	unsigned long last_config;	/* In jiffies */
 
-	u8 in[5];		/* Register value */
-	u8 in_max[5];		/* Register value */
-	u8 in_min[5];		/* Register value */
+	u8 in[8];		/* Register value */
+	u8 in_max[8];		/* Register value */
+	u8 in_min[8];		/* Register value */
 	s8 temp[3];		/* Register value */
 	s8 temp_min[3];		/* Register value */
 	s8 temp_max[3];		/* Register value */
@@ -407,8 +422,8 @@
 	long therm_total;	/* Cummulative therm count */
 	long therm_ovfl;	/* Count of therm overflows */
 	u8 therm_limit;		/* Register value */
-	u16 alarms;		/* Register encoding, combined */
-	u16 alarm_mask;		/* Register encoding, combined */
+	u32 alarms;		/* Register encoding, combined */
+	u32 alarm_mask;		/* Register encoding, combined */
 	struct lm85_autofan autofan[3];
 	struct lm85_zone zone[3];
 };
@@ -465,6 +480,9 @@
 static void adt7463_therm_signal(struct i2c_client *client, int operation,
 			int ctl_name, int *nrels_mag, long *results);
 
+static void emc6d100_in(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
+
 static struct i2c_driver lm85_driver = {
 	.owner		= THIS_MODULE,
 	.name		=  "LM85 compatible sensor driver",
@@ -663,12 +681,23 @@
 };
 #define CTLTBL_ADT7463 (sizeof(adt7463_specific)/sizeof(adt7463_specific[0]))
 
+static ctl_table emc6d100_specific[] = {
+	{EMC6D100_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &emc6d100_in},
+	{EMC6D100_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &emc6d100_in},
+	{EMC6D100_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
+		&i2c_sysctl_real, NULL, &emc6d100_in},
+/*	{0} The doc generator needs this. */ 
+};
+#define CTLTBL_EMC6D100 (sizeof(emc6d100_specific)/sizeof(emc6d100_specific[0]))
+
 
 #define MAX2(a,b) ((a)>(b)?(a):(b))
 #define MAX3(a,b,c) ((a)>(b)?MAX2((a),(c)):MAX2((b),(c)))
 #define MAX4(a,b,c,d) ((a)>(b)?MAX3((a),(c),(d)):MAX3((b),(c),(d)))
 
-#define CTLTBL_MAX (CTLTBL_COMMON + MAX2(CTLTBL_LM85, CTLTBL_ADM1027+CTLTBL_ADT7463))
+#define CTLTBL_MAX (CTLTBL_COMMON + MAX3(CTLTBL_LM85, CTLTBL_ADM1027+CTLTBL_ADT7463, CTLTBL_EMC6D100))
 
 /* This function is called when:
      * lm85_driver is inserted (when this module is loaded), for each
@@ -747,9 +776,10 @@
 		    && verstep = LM85_VERSTEP_LM85B ) {
 			kind = lm85b ;
 		} else if( company = LM85_COMPANY_NATIONAL
-		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
+		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
+			printk("lm85: Detected National Semiconductor chip\n");
 			printk("lm85: Unrecgonized version/stepping 0x%02x"
-			    " Defaulting to LM85.\n", verstep );
+			    " Defaulting to Generic LM85.\n", verstep );
 			kind = any_chip ;
 		} else if( company = LM85_COMPANY_ANALOG_DEV
 		    && verstep = LM85_VERSTEP_ADM1027 ) {
@@ -758,16 +788,29 @@
 		    && verstep = LM85_VERSTEP_ADT7463 ) {
 			kind = adt7463 ;
 		} else if( company = LM85_COMPANY_ANALOG_DEV
-		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
+		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
+			printk("lm85: Detected Analog Devices chip\n");
 			printk("lm85: Unrecgonized version/stepping 0x%02x"
-			    " Defaulting to ADM1027.\n", verstep );
-			kind = adm1027 ;
+			    " Defaulting to Generic LM85.\n", verstep );
+			kind = any_chip ;
+		} else if( company = LM85_COMPANY_SMSC
+		    && (verstep = LM85_VERSTEP_EMC6D100_A0
+			 || verstep = LM85_VERSTEP_EMC6D100_A1) ) {
+			/* Unfortunately, we can't tell a '100 from a '101
+			 *   from the registers.  Since a '101 is a '100
+			 *   in a package with fewer pins and therefore no
+			 *   3.3V, 1.5V or 1.8V inputs, perhaps if those
+			 *   inputs read 0, then it's a '101.
+			 */
+			kind = emc6d100 ;
 		} else if( company = LM85_COMPANY_SMSC
-		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
-			printk("lm85: Your EMC6D10x has version/stepping 0x%02x"
-			    " Please notify lm_sensors team.\n", verstep );
-			kind = emc6d101 ;
-		} else if( kind = 0 && (verstep & 0xf0) = 0x60) {
+		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
+			printk("lm85: Detected SMSC chip\n");
+			printk("lm85: Unrecognized version/stepping 0x%02x"
+			    " Defaulting to Generic LM85.\n", verstep );
+			kind = any_chip ;
+		} else if( kind = any_chip
+		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
 			printk("lm85: Generic LM85 Version 6 detected\n");
 			/* Leave kind as "any_chip" */
 		} else {
@@ -775,7 +818,7 @@
 			printk("lm85: Autodetection failed\n");
 #endif
 			/* Not an LM85 ... */
-			if( kind = 0 ) {  /* User used force=x,y */
+			if( kind = any_chip ) {  /* User used force=x,y */
 			    printk("lm85: Generic LM85 Version 6 not"
 				" found at %d,0x%02x. Try force_lm85c.\n",
 				i2c_adapter_id(adapter), address );
@@ -821,12 +864,8 @@
 	case emc6d100 :
 		type_name = "emc6d100";
 		strcpy(new_client->name, "SMSC EMC6D100");
-		template_used = 0 ;
-		break ;
-	case emc6d101 :
-		type_name = "emc6d101";
-		strcpy(new_client->name, "SMSC EMC6D101");
-		template_used = 0 ;
+		memcpy(template, emc6d100_specific, sizeof(emc6d100_specific));
+		template_used = CTLTBL_EMC6D100 ;
 		break ;
 	default :
 		printk("lm85: Internal error, invalid kind (%d)!", kind);
@@ -923,15 +962,15 @@
 	case ADM1027_REG_EXTEND_ADC :  /* Read ADC1 and ADC2 */
 		reg &= 0xff ;  /* Pseudo words have address + 0x0100 */
 		res = i2c_smbus_read_byte_data(client, reg) & 0xff ;
-		res |= i2c_smbus_read_byte_data(client, reg+1) << 8 ;
+		res |= (i2c_smbus_read_byte_data(client, reg+1) & 0xff) << 8 ;
 		break ;
 	case ADT7463_REG_TMIN_CTL :  /* Read WORD MSB, LSB */
 		reg &= 0xff ;  /* Pseudo words have address + 0x0100 */
-		res = i2c_smbus_read_byte_data(client, reg) << 8 ;
+		res = (i2c_smbus_read_byte_data(client, reg) & 0xff) << 8 ;
 		res |= i2c_smbus_read_byte_data(client, reg+1) & 0xff ;
 		break ;
 	default:	/* Read BYTE data */
-		res = i2c_smbus_read_byte_data(client, reg & 0xff);
+		res = i2c_smbus_read_byte_data(client, reg & 0xff) & 0xff ;
 		break ;
 	}
 
@@ -1034,6 +1073,8 @@
 		}
 	};
 
+	/* FIXME?  Display EMC6D100 config info? */
+
 	/* WE INTENTIONALLY make no changes to the limits,
 	 *   offsets, pwms, fans and zones.  If they were
 	 *   configured, we don't want to mess with them.
@@ -1101,6 +1142,8 @@
 			    lm85_read_value(client, LM85_REG_PWM(i));
 		}
 
+		data->alarms = lm85_read_value(client, LM85_REG_ALARM);
+
 		switch( ((struct lm85_data *)(client->data))->type ) {
 		case adt7463 :
 			/* REG_THERM code duplicated in therm_signal() */
@@ -1112,11 +1155,20 @@
 				++data->therm_ovfl ;
 			}
 			break ;
+		case emc6d100 :
+			/* Three more voltage sensors */
+			for (i = 5; i <= 7; ++i) {
+			    data->in[i] +				lm85_read_value(client, EMC6D100_REG_IN(i));
+			}
+			/* More alarm bits */
+			data->alarms |+			    lm85_read_value(client, EMC6D100_REG_ALARM3) << 16;
+
+			break ;
 		default : break ; /* no warnings */
 		}
 
-		data->alarms = lm85_read_value(client, LM85_REG_ALARM);
-
 		data->last_reading = jiffies ;
 	};  /* last_reading */
 
@@ -1210,6 +1262,14 @@
 			data->alarm_mask = lm85_read_value(client,
 				ADM1027_REG_INTMASK );
 			break ;
+		case emc6d100 :
+			for (i = 5; i <= 7; ++i) {
+			    data->in_min[i] +				lm85_read_value(client, EMC6D100_REG_IN_MIN(i));
+			    data->in_max[i] +				lm85_read_value(client, EMC6D100_REG_IN_MAX(i));
+			}
+			break ;
 		default : break ; /* no warnings */
 		}
 	
@@ -1921,6 +1981,41 @@
 		up(&data->update_lock);
 	}
 }
+
+void emc6d100_in(struct i2c_client *client, int operation, int ctl_name,
+	     int *nrels_mag, long *results)
+{
+	struct lm85_data *data = client->data;
+	int nr = ctl_name - EMC6D100_SYSCTL_IN5 +5;
+
+	if (nr < 5 || nr > 7)
+		return ;  /* ERROR */
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 3;  /* 1.000 */
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		int  ext = 0 ;
+		lm85_update_client(client);
+		results[0] = INS_FROM_REG(nr,data->in_min[nr]);
+		results[1] = INS_FROM_REG(nr,data->in_max[nr]);
+		results[2] = INS_FROM_REG(nr,data->in[nr]);
+		*nrels_mag = 3;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		down(&data->update_lock);
+		if (*nrels_mag > 1) {
+			data->in_max[nr] = INS_TO_REG(nr,results[1]);
+			lm85_write_value(client, EMC6D100_REG_IN_MAX(nr),
+					 data->in_max[nr]);
+		}
+		if (*nrels_mag > 0) {
+			data->in_min[nr] = INS_TO_REG(nr,results[0]);
+			lm85_write_value(client, EMC6D100_REG_IN_MIN(nr),
+					 data->in_min[nr]);
+		}
+		up(&data->update_lock);
+	}
+}
+
 
 static int __init sm_lm85_init(void)
 {
Index: lm_sensors2/lib/chips.c
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.c,v
retrieving revision 1.83
diff -u -r1.83 chips.c
--- lm_sensors2/lib/chips.c	4 Jul 2003 08:44:58 -0000	1.83
+++ lm_sensors2/lib/chips.c	5 Jul 2003 05:13:12 -0000
@@ -2772,6 +2772,12 @@
                         SENSORS_MODE_R, LM85_SYSCTL_IN3, VALUE(3), 3 },
     { SENSORS_LM85_IN4, "in4", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
                         SENSORS_MODE_R, LM85_SYSCTL_IN4, VALUE(3), 3 },
+    { SENSORS_LM85_IN5, "in5", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, EMC6D100_SYSCTL_IN5, VALUE(3), 3 },
+    { SENSORS_LM85_IN6, "in6", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, EMC6D100_SYSCTL_IN6, VALUE(3), 3 },
+    { SENSORS_LM85_IN7, "in7", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, EMC6D100_SYSCTL_IN7, VALUE(3), 3 },
     { SENSORS_LM85_IN0_MIN, "in0_min", SENSORS_LM85_IN0, SENSORS_LM85_IN0,
                             SENSORS_MODE_RW, LM85_SYSCTL_IN0, VALUE(1), 3 },
     { SENSORS_LM85_IN1_MIN, "in1_min", SENSORS_LM85_IN1, SENSORS_LM85_IN1,
@@ -2782,6 +2788,12 @@
                             SENSORS_MODE_RW, LM85_SYSCTL_IN3, VALUE(1), 3 },
     { SENSORS_LM85_IN4_MIN, "in4_min", SENSORS_LM85_IN4, SENSORS_LM85_IN4,
                             SENSORS_MODE_RW, LM85_SYSCTL_IN4, VALUE(1), 3 },
+    { SENSORS_LM85_IN5_MIN, "in5_min", SENSORS_LM85_IN5, SENSORS_LM85_IN5,
+                            SENSORS_MODE_RW, EMC6D100_SYSCTL_IN5, VALUE(1), 3 },
+    { SENSORS_LM85_IN6_MIN, "in6_min", SENSORS_LM85_IN6, SENSORS_LM85_IN6,
+                            SENSORS_MODE_RW, EMC6D100_SYSCTL_IN6, VALUE(1), 3 },
+    { SENSORS_LM85_IN7_MIN, "in7_min", SENSORS_LM85_IN7, SENSORS_LM85_IN7,
+                            SENSORS_MODE_RW, EMC6D100_SYSCTL_IN7, VALUE(1), 3 },
     { SENSORS_LM85_IN0_MAX, "in0_max", SENSORS_LM85_IN0, SENSORS_LM85_IN0,
                             SENSORS_MODE_RW, LM85_SYSCTL_IN0, VALUE(2), 3 },
     { SENSORS_LM85_IN1_MAX, "in1_max", SENSORS_LM85_IN1, SENSORS_LM85_IN1,
@@ -2792,6 +2804,12 @@
                             SENSORS_MODE_RW, LM85_SYSCTL_IN3, VALUE(2), 3 },
     { SENSORS_LM85_IN4_MAX, "in4_max", SENSORS_LM85_IN4, SENSORS_LM85_IN4,
                             SENSORS_MODE_RW, LM85_SYSCTL_IN4, VALUE(2), 3 },
+    { SENSORS_LM85_IN5_MAX, "in5_max", SENSORS_LM85_IN5, SENSORS_LM85_IN5,
+                            SENSORS_MODE_RW, EMC6D100_SYSCTL_IN5, VALUE(2), 3 },
+    { SENSORS_LM85_IN6_MAX, "in6_max", SENSORS_LM85_IN6, SENSORS_LM85_IN6,
+                            SENSORS_MODE_RW, EMC6D100_SYSCTL_IN6, VALUE(2), 3 },
+    { SENSORS_LM85_IN7_MAX, "in7_max", SENSORS_LM85_IN7, SENSORS_LM85_IN7,
+                            SENSORS_MODE_RW, EMC6D100_SYSCTL_IN7, VALUE(2), 3 },
     { SENSORS_LM85_FAN1, "fan1", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
                          SENSORS_MODE_R, LM85_SYSCTL_FAN1, VALUE(2), 0 },
     { SENSORS_LM85_FAN2, "fan2", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
@@ -4328,6 +4346,7 @@
  { SENSORS_LM85_PREFIX, lm85_features },
  { SENSORS_LM85B_PREFIX, lm85_features },
  { SENSORS_LM85C_PREFIX, lm85_features },
+ { SENSORS_EMC6D100_PREFIX, lm85_features },
  { SENSORS_ADM1027_PREFIX, adm1027_features },
  { SENSORS_ADT7463_PREFIX, adm1027_features },
  { SENSORS_LM83_PREFIX, lm83_features },
Index: lm_sensors2/lib/chips.h
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.h,v
retrieving revision 1.65
diff -u -r1.65 chips.h
--- lm_sensors2/lib/chips.h	3 Jul 2003 17:30:46 -0000	1.65
+++ lm_sensors2/lib/chips.h	5 Jul 2003 05:13:22 -0000
@@ -337,6 +337,7 @@
 #define SENSORS_LM85C_PREFIX "lm85c"
 #define SENSORS_ADM1027_PREFIX "adm1027"
 #define SENSORS_ADT7463_PREFIX "adt7463"
+#define SENSORS_EMC6D100_PREFIX "emc6d100"
 
 #define SENSORS_ADM1027_ALARM_MASK           1  /* RW -- alarm_mask  */
 #define SENSORS_ADM1027_FAN1_PPR             2  /* RW -- fan1_ppr  */
@@ -354,82 +355,91 @@
 #define SENSORS_ADM1027_TEMP2_OFFSET        14  /* RW -- temp2_offset  */
 #define SENSORS_ADM1027_TEMP3_OFFSET        15  /* RW -- temp3_offset  */
 #define SENSORS_LM85_ALARMS                 16  /* R  -- alarms  */
-#define SENSORS_LM85_FAN1                   17  /* R  -- fan1  */
-#define SENSORS_LM85_FAN1_MIN               18  /* RW -- fan1_min  */
-#define SENSORS_LM85_FAN1_TACH_MODE         19  /* RW -- fan1_tach_mode  */
-#define SENSORS_LM85_FAN2                   20  /* R  -- fan2  */
-#define SENSORS_LM85_FAN2_MIN               21  /* RW -- fan2_min  */
-#define SENSORS_LM85_FAN2_TACH_MODE         22  /* RW -- fan2_tach_mode  */
-#define SENSORS_LM85_FAN3                   23  /* R  -- fan3  */
-#define SENSORS_LM85_FAN3_MIN               24  /* RW -- fan3_min  */
-#define SENSORS_LM85_FAN3_TACH_MODE         25  /* RW -- fan3_tach_mode  */
-#define SENSORS_LM85_FAN4                   26  /* R  -- fan4  */
-#define SENSORS_LM85_FAN4_MIN               27  /* RW -- fan4_min  */
-#define SENSORS_LM85_IN0                    28  /* R  -- in0  */
-#define SENSORS_LM85_IN0_MAX                29  /* RW -- in0_max  */
-#define SENSORS_LM85_IN0_MIN                30  /* RW -- in0_min  */
-#define SENSORS_LM85_IN1                    31  /* R  -- in1  */
-#define SENSORS_LM85_IN1_MAX                32  /* RW -- in1_max  */
-#define SENSORS_LM85_IN1_MIN                33  /* RW -- in1_min  */
-#define SENSORS_LM85_IN2                    34  /* R  -- in2  */
-#define SENSORS_LM85_IN2_MAX                35  /* RW -- in2_max  */
-#define SENSORS_LM85_IN2_MIN                36  /* RW -- in2_min  */
-#define SENSORS_LM85_IN3                    37  /* R  -- in3  */
-#define SENSORS_LM85_IN3_MAX                38  /* RW -- in3_max  */
-#define SENSORS_LM85_IN3_MIN                39  /* RW -- in3_min  */
-#define SENSORS_LM85_IN4                    40  /* R  -- in4  */
-#define SENSORS_LM85_IN4_MAX                41  /* RW -- in4_max  */
-#define SENSORS_LM85_IN4_MIN                42  /* RW -- in4_min  */
-#define SENSORS_LM85_PWM1                   43  /* RW -- pwm1  */
-#define SENSORS_LM85_PWM1_FREQ              44  /* RW -- pwm1_freq  */
-#define SENSORS_LM85_PWM1_INVERT            45  /* RW -- pwm1_invert  */
-#define SENSORS_LM85_PWM1_MIN               46  /* RW -- pwm1_min  */
-#define SENSORS_LM85_PWM1_MIN_CTL           47  /* RW -- pwm1_min_ctl  */
-#define SENSORS_LM85_PWM1_SPINUP            48  /* RW -- pwm1_spinup  */
-#define SENSORS_LM85_PWM1_SPINUP_CTL        49  /* RW -- pwm1_spinup_ctl  */
-#define SENSORS_LM85_PWM1_ZONE              50  /* RW -- pwm1_zone  */
-#define SENSORS_LM85_PWM2                   51  /* RW -- pwm2  */
-#define SENSORS_LM85_PWM2_FREQ              52  /* RW -- pwm2_freq  */
-#define SENSORS_LM85_PWM2_INVERT            53  /* RW -- pwm2_invert  */
-#define SENSORS_LM85_PWM2_MIN               54  /* RW -- pwm2_min  */
-#define SENSORS_LM85_PWM2_MIN_CTL           55  /* RW -- pwm2_min_ctl  */
-#define SENSORS_LM85_PWM2_SPINUP            56  /* RW -- pwm2_spinup  */
-#define SENSORS_LM85_PWM2_SPINUP_CTL        57  /* RW -- pwm2_spinup_ctl  */
-#define SENSORS_LM85_PWM2_ZONE              58  /* RW -- pwm2_zone  */
-#define SENSORS_LM85_PWM3                   59  /* RW -- pwm3  */
-#define SENSORS_LM85_PWM3_FREQ              60  /* RW -- pwm3_freq  */
-#define SENSORS_LM85_PWM3_INVERT            61  /* RW -- pwm3_invert  */
-#define SENSORS_LM85_PWM3_MIN               62  /* RW -- pwm3_min  */
-#define SENSORS_LM85_PWM3_MIN_CTL           63  /* RW -- pwm3_min_ctl  */
-#define SENSORS_LM85_PWM3_SPINUP            64  /* RW -- pwm3_spinup  */
-#define SENSORS_LM85_PWM3_SPINUP_CTL        65  /* RW -- pwm3_spinup_ctl  */
-#define SENSORS_LM85_PWM3_ZONE              66  /* RW -- pwm3_zone  */
-#define SENSORS_LM85_TEMP1                  67  /* R  -- temp1  */
-#define SENSORS_LM85_TEMP1_MAX              68  /* RW -- temp1_max  */
-#define SENSORS_LM85_TEMP1_MIN              69  /* RW -- temp1_min  */
-#define SENSORS_LM85_TEMP2                  70  /* R  -- temp2  */
-#define SENSORS_LM85_TEMP2_MAX              71  /* RW -- temp2_max  */
-#define SENSORS_LM85_TEMP2_MIN              72  /* RW -- temp2_min  */
-#define SENSORS_LM85_TEMP3                  73  /* R  -- temp3  */
-#define SENSORS_LM85_TEMP3_MAX              74  /* RW -- temp3_max  */
-#define SENSORS_LM85_TEMP3_MIN              75  /* RW -- temp3_min  */
-#define SENSORS_LM85_VID                    76  /* R  -- vid  */
-#define SENSORS_LM85_VRM                    77  /* RW -- vrm  */
-#define SENSORS_LM85_ZONE1_CRITICAL         78  /* RW -- zone1_critical  */
-#define SENSORS_LM85_ZONE1_HYST             79  /* RW -- zone1_hyst  */
-#define SENSORS_LM85_ZONE1_LIMIT            80  /* RW -- zone1_limit  */
-#define SENSORS_LM85_ZONE1_RANGE            81  /* RW -- zone1_range  */
-#define SENSORS_LM85_ZONE1_SMOOTH           82  /* RW -- zone1_smooth  */
-#define SENSORS_LM85_ZONE2_CRITICAL         83  /* RW -- zone2_critical  */
-#define SENSORS_LM85_ZONE2_HYST             84  /* RW -- zone2_hyst  */
-#define SENSORS_LM85_ZONE2_LIMIT            85  /* RW -- zone2_limit  */
-#define SENSORS_LM85_ZONE2_RANGE            86  /* RW -- zone2_range  */
-#define SENSORS_LM85_ZONE2_SMOOTH           87  /* RW -- zone2_smooth  */
-#define SENSORS_LM85_ZONE3_CRITICAL         88  /* RW -- zone3_critical  */
-#define SENSORS_LM85_ZONE3_HYST             89  /* RW -- zone3_hyst  */
-#define SENSORS_LM85_ZONE3_LIMIT            90  /* RW -- zone3_limit  */
-#define SENSORS_LM85_ZONE3_RANGE            91  /* RW -- zone3_range  */
-#define SENSORS_LM85_ZONE3_SMOOTH           92  /* RW -- zone3_smooth  */
+#define SENSORS_LM85_VID                    17  /* R  -- vid  */
+#define SENSORS_LM85_VRM                    18  /* RW -- vrm  */
+#define SENSORS_LM85_FAN1                   19  /* R  -- fan1  */
+#define SENSORS_LM85_FAN1_MIN               20  /* RW -- fan1_min  */
+#define SENSORS_LM85_FAN1_TACH_MODE         21  /* RW -- fan1_tach_mode  */
+#define SENSORS_LM85_FAN2                   22  /* R  -- fan2  */
+#define SENSORS_LM85_FAN2_MIN               23  /* RW -- fan2_min  */
+#define SENSORS_LM85_FAN2_TACH_MODE         24  /* RW -- fan2_tach_mode  */
+#define SENSORS_LM85_FAN3                   25  /* R  -- fan3  */
+#define SENSORS_LM85_FAN3_MIN               26  /* RW -- fan3_min  */
+#define SENSORS_LM85_FAN3_TACH_MODE         27  /* RW -- fan3_tach_mode  */
+#define SENSORS_LM85_FAN4                   28  /* R  -- fan4  */
+#define SENSORS_LM85_FAN4_MIN               29  /* RW -- fan4_min  */
+#define SENSORS_LM85_IN0                    30  /* R  -- in0  */
+#define SENSORS_LM85_IN0_MAX                31  /* RW -- in0_max  */
+#define SENSORS_LM85_IN0_MIN                32  /* RW -- in0_min  */
+#define SENSORS_LM85_IN1                    33  /* R  -- in1  */
+#define SENSORS_LM85_IN1_MAX                34  /* RW -- in1_max  */
+#define SENSORS_LM85_IN1_MIN                35  /* RW -- in1_min  */
+#define SENSORS_LM85_IN2                    36  /* R  -- in2  */
+#define SENSORS_LM85_IN2_MAX                37  /* RW -- in2_max  */
+#define SENSORS_LM85_IN2_MIN                38  /* RW -- in2_min  */
+#define SENSORS_LM85_IN3                    39  /* R  -- in3  */
+#define SENSORS_LM85_IN3_MAX                40  /* RW -- in3_max  */
+#define SENSORS_LM85_IN3_MIN                41  /* RW -- in3_min  */
+#define SENSORS_LM85_IN4                    42  /* R  -- in4  */
+#define SENSORS_LM85_IN4_MAX                43  /* RW -- in4_max  */
+#define SENSORS_LM85_IN4_MIN                44  /* RW -- in4_min  */
+#define SENSORS_LM85_IN5                    45  /* R  -- in5  */
+#define SENSORS_LM85_IN5_MAX                46  /* RW -- in5_max  */
+#define SENSORS_LM85_IN5_MIN                47  /* RW -- in5_min  */
+#define SENSORS_LM85_IN6                    48  /* R  -- in6  */
+#define SENSORS_LM85_IN6_MAX                49  /* RW -- in6_max  */
+#define SENSORS_LM85_IN6_MIN                50  /* RW -- in6_min  */
+#define SENSORS_LM85_IN7                    51  /* R  -- in7  */
+#define SENSORS_LM85_IN7_MAX                52  /* RW -- in7_max  */
+#define SENSORS_LM85_IN7_MIN                53  /* RW -- in7_min  */
+#define SENSORS_LM85_PWM1                   54  /* RW -- pwm1  */
+#define SENSORS_LM85_PWM1_FREQ              55  /* RW -- pwm1_freq  */
+#define SENSORS_LM85_PWM1_INVERT            56  /* RW -- pwm1_invert  */
+#define SENSORS_LM85_PWM1_MIN               57  /* RW -- pwm1_min  */
+#define SENSORS_LM85_PWM1_MIN_CTL           58  /* RW -- pwm1_min_ctl  */
+#define SENSORS_LM85_PWM1_SPINUP            59  /* RW -- pwm1_spinup  */
+#define SENSORS_LM85_PWM1_SPINUP_CTL        60  /* RW -- pwm1_spinup_ctl  */
+#define SENSORS_LM85_PWM1_ZONE              61  /* RW -- pwm1_zone  */
+#define SENSORS_LM85_PWM2                   62  /* RW -- pwm2  */
+#define SENSORS_LM85_PWM2_FREQ              63  /* RW -- pwm2_freq  */
+#define SENSORS_LM85_PWM2_INVERT            64  /* RW -- pwm2_invert  */
+#define SENSORS_LM85_PWM2_MIN               65  /* RW -- pwm2_min  */
+#define SENSORS_LM85_PWM2_MIN_CTL           66  /* RW -- pwm2_min_ctl  */
+#define SENSORS_LM85_PWM2_SPINUP            67  /* RW -- pwm2_spinup  */
+#define SENSORS_LM85_PWM2_SPINUP_CTL        68  /* RW -- pwm2_spinup_ctl  */
+#define SENSORS_LM85_PWM2_ZONE              69  /* RW -- pwm2_zone  */
+#define SENSORS_LM85_PWM3                   70  /* RW -- pwm3  */
+#define SENSORS_LM85_PWM3_FREQ              71  /* RW -- pwm3_freq  */
+#define SENSORS_LM85_PWM3_INVERT            72  /* RW -- pwm3_invert  */
+#define SENSORS_LM85_PWM3_MIN               73  /* RW -- pwm3_min  */
+#define SENSORS_LM85_PWM3_MIN_CTL           74  /* RW -- pwm3_min_ctl  */
+#define SENSORS_LM85_PWM3_SPINUP            75  /* RW -- pwm3_spinup  */
+#define SENSORS_LM85_PWM3_SPINUP_CTL        76  /* RW -- pwm3_spinup_ctl  */
+#define SENSORS_LM85_PWM3_ZONE              77  /* RW -- pwm3_zone  */
+#define SENSORS_LM85_TEMP1                  78  /* R  -- temp1  */
+#define SENSORS_LM85_TEMP1_MAX              79  /* RW -- temp1_max  */
+#define SENSORS_LM85_TEMP1_MIN              80  /* RW -- temp1_min  */
+#define SENSORS_LM85_TEMP2                  81  /* R  -- temp2  */
+#define SENSORS_LM85_TEMP2_MAX              82  /* RW -- temp2_max  */
+#define SENSORS_LM85_TEMP2_MIN              83  /* RW -- temp2_min  */
+#define SENSORS_LM85_TEMP3                  84  /* R  -- temp3  */
+#define SENSORS_LM85_TEMP3_MAX              85  /* RW -- temp3_max  */
+#define SENSORS_LM85_TEMP3_MIN              86  /* RW -- temp3_min  */
+#define SENSORS_LM85_ZONE1_CRITICAL         87  /* RW -- zone1_critical  */
+#define SENSORS_LM85_ZONE1_HYST             88  /* RW -- zone1_hyst  */
+#define SENSORS_LM85_ZONE1_LIMIT            89  /* RW -- zone1_limit  */
+#define SENSORS_LM85_ZONE1_RANGE            90  /* RW -- zone1_range  */
+#define SENSORS_LM85_ZONE1_SMOOTH           91  /* RW -- zone1_smooth  */
+#define SENSORS_LM85_ZONE2_CRITICAL         92  /* RW -- zone2_critical  */
+#define SENSORS_LM85_ZONE2_HYST             93  /* RW -- zone2_hyst  */
+#define SENSORS_LM85_ZONE2_LIMIT            94  /* RW -- zone2_limit  */
+#define SENSORS_LM85_ZONE2_RANGE            95  /* RW -- zone2_range  */
+#define SENSORS_LM85_ZONE2_SMOOTH           96  /* RW -- zone2_smooth  */
+#define SENSORS_LM85_ZONE3_CRITICAL         97  /* RW -- zone3_critical  */
+#define SENSORS_LM85_ZONE3_HYST             98  /* RW -- zone3_hyst  */
+#define SENSORS_LM85_ZONE3_LIMIT            99  /* RW -- zone3_limit  */
+#define SENSORS_LM85_ZONE3_RANGE           100  /* RW -- zone3_range  */
+#define SENSORS_LM85_ZONE3_SMOOTH          101  /* RW -- zone3_smooth  */
 
 /* Winbond W83781D chips */
 
Index: lm_sensors2/prog/sensors/chips.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensors/chips.c,v
retrieving revision 1.84
diff -u -r1.84 chips.c
--- lm_sensors2/prog/sensors/chips.c	3 Jul 2003 17:45:32 -0000	1.84
+++ lm_sensors2/prog/sensors/chips.c	5 Jul 2003 05:13:42 -0000
@@ -1473,13 +1473,14 @@
   char *label = NULL;
   double cur, min, max;
   int alarms, alarm_mask, valid;
-  int is85, is1027;
+  int is85, is1027, is6d100;
 
   is85 = !strcmp(name->prefix,"lm85")
          || !strcmp(name->prefix,"lm85b")
          || !strcmp(name->prefix,"lm85c") ;
   is1027 = !strcmp(name->prefix,"adm1027")
            || !strcmp(name->prefix,"adt7463") ;
+  is6d100 = !strcmp(name->prefix,"emc6d100") ;
 
   if (!sensors_get_feature(*name,SENSORS_LM85_ALARMS,&cur)) 
     alarms = cur + 0.5;
@@ -1569,6 +1570,45 @@
   } else
     printf("ERROR: Can't get IN4 data!\n");
   free_the_label(&label);
+
+  if( is6d100 ) {
+    if (!sensors_get_label_and_valid(*name,SENSORS_LM85_IN5,&label,&valid) &&
+        !sensors_get_feature(*name,SENSORS_LM85_IN5,&cur) &&
+        !sensors_get_feature(*name,SENSORS_LM85_IN5_MIN,&min) &&
+        !sensors_get_feature(*name,SENSORS_LM85_IN5_MAX,&max)) {
+      if (valid) {
+        print_label(label,10);
+        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
+             cur,min,max,alarms&LM85_ALARM_IN5?"ALARM":"");
+      }
+    } else
+      printf("ERROR: Can't get IN5 data!\n");
+    free_the_label(&label);
+    if (!sensors_get_label_and_valid(*name,SENSORS_LM85_IN6,&label,&valid) &&
+        !sensors_get_feature(*name,SENSORS_LM85_IN6,&cur) &&
+        !sensors_get_feature(*name,SENSORS_LM85_IN6_MIN,&min) &&
+        !sensors_get_feature(*name,SENSORS_LM85_IN6_MAX,&max)) {
+      if (valid) {
+        print_label(label,10);
+        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
+             cur,min,max,alarms&LM85_ALARM_IN6?"ALARM":"");
+      }
+    } else
+      printf("ERROR: Can't get IN6 data!\n");
+    free_the_label(&label);
+    if (!sensors_get_label_and_valid(*name,SENSORS_LM85_IN7,&label,&valid) &&
+        !sensors_get_feature(*name,SENSORS_LM85_IN7,&cur) &&
+        !sensors_get_feature(*name,SENSORS_LM85_IN7_MIN,&min) &&
+        !sensors_get_feature(*name,SENSORS_LM85_IN7_MAX,&max)) {
+      if (valid) {
+        print_label(label,10);
+        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
+             cur,min,max,alarms&LM85_ALARM_IN7?"ALARM":"");
+      }
+    } else
+      printf("ERROR: Can't get IN7 data!\n");
+    free_the_label(&label);
+  }
 
   if (!sensors_get_label_and_valid(*name,SENSORS_LM85_FAN1,&label,&valid) &&
       !sensors_get_feature(*name,SENSORS_LM85_FAN1,&cur) &&
Index: lm_sensors2/prog/sensors/main.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensors/main.c,v
retrieving revision 1.66
diff -u -r1.66 main.c
--- lm_sensors2/prog/sensors/main.c	3 Jul 2003 17:45:32 -0000	1.66
+++ lm_sensors2/prog/sensors/main.c	5 Jul 2003 05:13:44 -0000
@@ -324,7 +324,8 @@
            !strcmp(name.prefix,"lm85b") ||
            !strcmp(name.prefix,"lm85c") ||
            !strcmp(name.prefix,"adm1027") ||
-           !strcmp(name.prefix,"adt7463") )
+           !strcmp(name.prefix,"adt7463") ||
+           !strcmp(name.prefix,"emc6d100") )
     print_lm85(&name);
   else if (!strcmp(name.prefix,"lm87"))
     print_lm87(&name);
