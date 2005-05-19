From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: emc6d102 support
Message-Id: <41FFA433.9090300@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011003.40803.rafael.espindola@gmail.com>
In-Reply-To: <200502011003.40803.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes, you should add the additional two bits of resolution.

If you don't, there isn't any reason to break the emc6d102 out as a 
separate "kind."  It doesn't change the functionality at all.

In fact, if you've implemented the three additional sensors that exist 
in the '100 and '102 in the driver previously, then you've actually got 
less functionality than if you made the '102 be detected as a '100  
(Assuming it actually *has* the additional inputs).

:v)

Rafael ?vila de Esp?ndola wrote:

>The attached patchs add support for the emc6d102. It already worked as a 
>"generic lm85" so the patchs are mostly cosmetic.
>
>The emc6d102 has a 10bits A/D converter. Do you think that it would be 
>worthwhile to add support to it?
>
>Rafael
>  
>
>------------------------------------------------------------------------
>
>Index: drivers/i2c/chips/lm85.c
>=================================>--- drivers/i2c/chips/lm85.c	(revision 26268)
>+++ drivers/i2c/chips/lm85.c	(working copy)
>@@ -36,7 +36,7 @@
> static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
> 
> /* Insmod parameters */
>-SENSORS_INSMOD_5(lm85b, lm85c, adm1027, adt7463, emc6d100);
>+SENSORS_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);
> 
> /* The LM85 registers */
> 
>@@ -75,6 +75,7 @@
> #define	LM85_VERSTEP_ADT7463		0x62
> #define	LM85_VERSTEP_EMC6D100_A0        0x60
> #define	LM85_VERSTEP_EMC6D100_A1        0x61
>+#define	LM85_VERSTEP_EMC6D102           0x65
> 
> #define	LM85_REG_CONFIG			0x40
> 
>@@ -1109,6 +1110,9 @@
> 			 */
> 			kind = emc6d100 ;
> 		} else if( company = LM85_COMPANY_SMSC
>+		    && verstep = LM85_VERSTEP_EMC6D102) {
>+			kind = emc6d102 ;
>+		} else if( company = LM85_COMPANY_SMSC
> 		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
> 			dev_err(&adapter->dev, "lm85: Detected SMSC chip\n");
> 			dev_err(&adapter->dev, "lm85: Unrecognized version/stepping 0x%02x"
>@@ -1144,6 +1148,8 @@
> 		type_name = "adt7463";
> 	} else if ( kind = emc6d100){
> 		type_name = "emc6d100";
>+	} else if ( kind = emc6d102 ) {
>+		type_name = "emc6d102";
> 	}
> 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
> 
>  
>
>------------------------------------------------------------------------
>
>Index: README
>=================================>RCS file: /home/cvs/lm_sensors2/README,v
>retrieving revision 1.97
>diff -u -r1.97 README
>--- README	22 Dec 2004 21:32:54 -0000	1.97
>+++ README	1 Feb 2005 01:26:18 -0000
>@@ -92,7 +92,7 @@
>                          PC87363, PC87364, PC87365, PC87366
>   Philips NE1617, NE1617A, NE1619
>   SiS 5595, 950 embedded sensors
>-  SMSC 47M1xx embedded sensors, EMC6D100, EMC6D101
>+  SMSC 47M1xx embedded sensors, EMC6D100, EMC6D101, EMC6D102
>   TI THMC10 and THMC50
>   VIA Technologies VT1211, VT8231 and VT82C686A/B embedded sensors
>   Winbond W83781D, W83782D, W83783S, W83791D,
>Index: lib/chips.c
>=================================>RCS file: /home/cvs/lm_sensors2/lib/chips.c,v
>retrieving revision 1.158
>diff -u -r1.158 chips.c
>--- lib/chips.c	27 Jan 2005 21:13:44 -0000	1.158
>+++ lib/chips.c	1 Feb 2005 01:26:18 -0000
>@@ -5341,6 +5341,7 @@
>  { SENSORS_LM85B_PREFIX, lm85_features },
>  { SENSORS_LM85C_PREFIX, lm85_features },
>  { SENSORS_EMC6D100_PREFIX, lm85_features },
>+ { SENSORS_EMC6D102_PREFIX, lm85_features },
>  { SENSORS_ADM1027_PREFIX, adm1027_features },
>  { SENSORS_ADT7463_PREFIX, adm1027_features },
>  { SENSORS_LM83_PREFIX, lm83_features },
>Index: lib/chips.h
>=================================>RCS file: /home/cvs/lm_sensors2/lib/chips.h,v
>retrieving revision 1.102
>diff -u -r1.102 chips.h
>--- lib/chips.h	26 Jan 2005 21:01:45 -0000	1.102
>+++ lib/chips.h	1 Feb 2005 01:26:19 -0000
>@@ -372,6 +372,7 @@
> #define SENSORS_ADM1027_PREFIX "adm1027"
> #define SENSORS_ADT7463_PREFIX "adt7463"
> #define SENSORS_EMC6D100_PREFIX "emc6d100"
>+#define SENSORS_EMC6D102_PREFIX "emc6d102"
> 
> #define SENSORS_ADM1027_ALARM_MASK           1  /* RW -- alarm_mask  */
> #define SENSORS_ADM1027_FAN1_PPR             2  /* RW -- fan1_ppr  */
>Index: prog/detect/sensors-detect
>=================================>RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
>retrieving revision 1.361
>diff -u -r1.361 sensors-detect
>--- prog/detect/sensors-detect	19 Jan 2005 20:38:58 -0000	1.361
>+++ prog/detect/sensors-detect	1 Feb 2005 01:26:19 -0000
>@@ -953,7 +953,7 @@
>        i2c_detect => sub { lm85_detect 0x41, @_},
>      },
>      {
>-       name => "SMSC EMC6D100 or EMC6D101",
>+       name => "SMSC EMC6D100, EMC6D101 or EMC6D102",
>        driver => "lm85",
>        i2c_addrs => [0x2c..0x2e],
>        i2c_detect => sub { lm85_detect 0x5c, @_},
>Index: prog/sensors/main.c
>=================================>RCS file: /home/cvs/lm_sensors2/prog/sensors/main.c,v
>retrieving revision 1.106
>diff -u -r1.106 main.c
>--- prog/sensors/main.c	24 Nov 2004 04:31:40 -0000	1.106
>+++ prog/sensors/main.c	1 Feb 2005 01:26:19 -0000
>@@ -347,6 +347,7 @@
> 	{ "adm1027", print_lm85 },
> 	{ "adt7463", print_lm85 },
> 	{ "emc6d100", print_lm85 },
>+	{ "emc6d102", print_lm85 },
> 	{ "lm87", print_lm87 },
> 	{ "gl518sm", print_gl518 },
> 	{ "adm1025", print_adm1025 },
>  
>
