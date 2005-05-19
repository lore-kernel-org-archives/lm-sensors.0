From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <4217F0E9.9070702@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Christophe,
>
>  
>
>>30: 4d ff ff 64 64 64 00 00 00 00 00 00 00 27 41 6a
>>    
>>
>
>Device revision 0x6A. ADM1027 is documented as 0x60+, ADT7463 is
>documented as 0x62+, so I would indeed agree that it must be an ADT7463.
>Our driver needs to be updated.
>  
>
Where do you see that in the datasheet?

The way I read this datasheet:

http://www.analog.com/UploadedFiles/Data_Sheets/272624927ADT7463_c.pdf

It says that the only valid values for the REVISION register are 0x62 
and 0x6A.  (see Table IV on page 32)  It doesn't say that any value 
larger than 0x62 is an ADT7463.

I think it might be safer to just add 0x6A as a valid ADT7463 chip.  See 
the attached patch against CVS.

>In the meantime you can use force_adt7463.
>  
>

-------------- next part --------------
Index: lm_sensors2/kernel/chips/lm85.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/lm85.c,v
retrieving revision 1.16
diff -u -r1.16 lm85.c
--- lm_sensors2/kernel/chips/lm85.c	19 Feb 2005 19:17:17 -0000	1.16
+++ lm_sensors2/kernel/chips/lm85.c	20 Feb 2005 00:41:39 -0000
@@ -114,6 +114,7 @@
 #define LM85_VERSTEP_LM85B 0x62
 #define LM85_VERSTEP_ADM1027 0x60
 #define LM85_VERSTEP_ADT7463 0x62
+#define LM85_VERSTEP_ADT7463C 0x6A
 #define LM85_VERSTEP_EMC6D100_A0 0x60
 #define LM85_VERSTEP_EMC6D100_A1 0x61
 
@@ -781,11 +782,18 @@
 			    " Defaulting to Generic LM85.\n", verstep );
 			kind = any_chip ;
 		} else if( company = LM85_COMPANY_ANALOG_DEV
+		    && verstep = LM85_VERSTEP_ADM1027 ) {
+			kind = adm1027 ;
+		} else if( company = LM85_COMPANY_ANALOG_DEV
+		    && (verstep = LM85_VERSTEP_ADT7463
+			 || verstep = LM85_VERSTEP_ADT7463C) ) {
+			kind = adt7463 ;
+		} else if( company = LM85_COMPANY_ANALOG_DEV
 		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
-			if (verstep >= LM85_VERSTEP_ADT7463)
-				kind = adt7463;
-			else
-				kind = adm1027;
+			printk("lm85: Detected Analog Devices chip\n");
+			printk("lm85: Unrecgonized version/stepping 0x%02x"
+			    " Defaulting to Generic LM85.\n", verstep );
+			kind = any_chip ;
 		} else if( company = LM85_COMPANY_SMSC
 		    && (verstep = LM85_VERSTEP_EMC6D100_A0
 			 || verstep = LM85_VERSTEP_EMC6D100_A1) ) {
