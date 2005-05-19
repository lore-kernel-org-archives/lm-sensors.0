From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: emc6d102 support
Message-Id: <421D99A9.2020606@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011003.40803.rafael.espindola@gmail.com>
In-Reply-To: <200502011003.40803.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have some comments...

Rafael ?vila de Esp?ndola wrote:

>The attached patchs add support for the extended precision ADC present in the 
>emc6d102 and adm1027. The kernel patch also redefines some macros to 
>explicitly use SCALE. This change makes then more readable.
>
>Rafael
>  
>
>
>Index: drivers/i2c/chips/lm85.c
>=================================>--- drivers/i2c/chips/lm85.c	(revision 26738)
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
>+#define	LM85_VERSTEP_EMC6D102		0x65
> 
> #define	LM85_REG_CONFIG			0x40
> 
>@@ -102,7 +103,6 @@
> #define	ADM1027_REG_INTMASK1		0x74
> #define	ADM1027_REG_INTMASK2		0x75
> #define	ADM1027_REG_EXTEND_ADC1		0x76
>-#define	ADM1027_REG_EXTEND_ADC2		0x77
> #define	ADM1027_REG_CONFIG3		0x78
> #define	ADM1027_REG_FAN_PPR		0x7b
>  
>

Why did you remove the definition of EXTEND_ADC2?  It's not used by 
name, but it's there to document the registers that are used by the driver.

> 
>@@ -111,9 +111,10 @@
> 
> #define EMC6D100_REG_ALARM3             0x7d
> /* IN5, IN6 and IN7 */
>-#define EMC6D100_REG_IN(nr)             (0x70 + ((nr)-5))
>-#define EMC6D100_REG_IN_MIN(nr)         (0x73 + ((nr)-5) * 2)
>-#define EMC6D100_REG_IN_MAX(nr)         (0x74 + ((nr)-5) * 2)
>+#define	EMC6D100_REG_IN(nr)             (0x70 + ((nr)-5))
>+#define	EMC6D100_REG_IN_MIN(nr)         (0x73 + ((nr)-5) * 2)
>+#define	EMC6D100_REG_IN_MAX(nr)         (0x74 + ((nr)-5) * 2)
>  
>
Hmmm..   The EMC6D102 datasheet shows these registers (0x70 - 0x78) as 
"test registers" that are "reserved".

http://www.smsc.com/main/datasheets/6d102.pdf

We should add addtional code to prevent reading or setting the 
additional in5, in6 and in7 inputs if the chip is an emc6d102.

>+#define	EMC6D102_REG_EXTEND_ADC		0x85
>  
>
As above, I recommend you #define ADC1, ADC2, ADC3, ADC4 to show that 
there are four registers whose values you will be using.

>@@ -138,35 +139,37 @@
>    these macros are called: arguments may be evaluated more than once.
>  */
> 
>-/* IN are scaled 1.000 = 0xc0, mag = 3 */
>-#define IN_TO_REG(val)		(SENSORS_LIMIT((((val)*0xc0+500)/1000),0,255))
>-#define INEXT_FROM_REG(val,ext) (((val)*1000 + (ext)*250 + 96)/0xc0)
>-#define IN_FROM_REG(val)	(INEXT_FROM_REG(val,0))
>  
>
Doh.  Dead code.  Should have been removed before...  Good catch.

>+#define INS_TO_REG(n,val)	\
>+		SENSORS_LIMIT(SCALE(val,lm85_scaling[n],192),0,255)
>+
>+#define INSEXT_FROM_REG(n,val,ext,scale)	\
>+		SCALE((val)*(scale) + (ext),192*(scale),lm85_scaling[n])
>  
>
I think I'd leave those on one line so a 'grep' for the function would 
pick out the definition as well as the function name.  But that's just 
me.  Perhaps there is some applicable style guideline?

>-#define EXT_FROM_REG(val,sensor)	(((val)>>(sensor * 2))&0x03)
> 
> /* ZONEs have the following parameters:
>  *    Limit (low) temp,           1. degC
>@@ -354,7 +357,7 @@
> 	u8 pwm[3];		/* Register value */
> 	u8 spinup_ctl;		/* Register encoding, combined */
> 	u8 tach_mode;		/* Register encoding, combined */
>-	u16 extend_adc;		/* Register value */
>+	u8 extend_adc[4];	/* Register value */
> 	u8 fan_ppr;		/* Register value */
> 	u8 smooth[3];		/* Register encoding */
> 	u8 vid;			/* Register value */
>  
>
Given the additional complexity introduced by the possibility of 
different scaling factors (4 for adm1027, 16 for EMC6D102) I think I 
would change this from a u16 to a *decoded* value in two arrays:

    u8  temp_ext[3];             /* Decoded values */
    u8  in_ext[8];               /* Decoded values */
    u8  adc_scale;               /* ADC Extended bits scaling factor */

Then put all the shift and mask code in 'lm85_update_device' and have it 
read the values and break them up into the appropriate '_ext[]' values.  
That's a simple loop for the adm1027 where the bits are in the same 
order as the sensors.  It's a bit more complicated in the case of the 
EMC6D102 because things are moved around a bit, but I think it would 
make more sense for that code to be in '_update_device'.

Then set adc_scale appropriately at initial detection time.

>@@ -369,6 +372,46 @@
> 	struct lm85_zone zone[3];
> };
> 
>+static int extin_from_reg(struct lm85_data *data, int sensor){
>+	if( (data->type = adm1027) || (data->type = adt7463) ) {
>+		int val = (data->extend_adc[1] << 8) + data->extend_adc[0];
>+		return (val>>(sensor * 2))&0x03;
>+	} else if (data->type = emc6d102) {
>+		if( sensor = 0) {
>+			return data->extend_adc[2]&0x0f;
>+		} else if (sensor = 1) {
>+			return data->extend_adc[3]&0x0f;
>+		} else if (sensor = 2) {
>+			return (data->extend_adc[3] >> 8)&0x0f;
>+		} else if (sensor = 3) {
>+			return (data->extend_adc[2] >> 8)&0x0f;
>+		} else {
>+			/* sensor = 4 */
>+			return (data->extend_adc[1] >> 8)&0x0f;
>+		}
>+	} else {
>+		return 0;
>+	}
>+}
>+
>+static int exttemp_from_reg(struct lm85_data *data, int sensor){
>+	if( (data->type = adm1027) || (data->type = adt7463) ) {
>+		int val = (data->extend_adc[1] << 8) + data->extend_adc[0];
>+		return (val>>((sensor + 5) * 2))&0x03;
>+	} else if (data->type = emc6d102) {
>+		if( sensor = 0) {
>+			return data->extend_adc[0]&0x0f;
>+		} else if (sensor = 1) {
>+			return data->extend_adc[1]&0x0f;
>+		} else {
>+			return (data->extend_adc[0] >> 8)&0x0f;
>+			/* sensor = 2 */
>+		}
>+	} else {
>+		return 0;
>+	}
>+}
>+
>  
>
With the previous recomendation, these go away or are incorporated into 
_update_device.


> static int lm85_attach_adapter(struct i2c_adapter *adapter);
> static int lm85_detect(struct i2c_adapter *adapter, int address,
> 			int kind);
>@@ -538,7 +581,14 @@
> static ssize_t show_in(struct device *dev, char *buf, int nr)
> {
> 	struct lm85_data *data = lm85_update_device(dev);
>-	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]) );
>+	/* scale is 2^(number of LSBs). There are 4 extra bits in the
>+	   emc6d102 and 2 in the adt7463 and adm1027. In all other chips ext
>+	   is always 0 and the value of scale is irrelevant. So it is left in
>+	   4*/
>+	int scale = (data->type = emc6d102 ) ? 16 : 4;
>+	int ext = extin_from_reg(data, nr);
>+	return sprintf(buf,"%d\n",
>+		       INSEXT_FROM_REG(nr, data->in[nr], ext, scale) );
> }
> static ssize_t show_in_min(struct device *dev, char *buf, int nr)
> {
>@@ -619,7 +669,14 @@
> static ssize_t show_temp(struct device *dev, char *buf, int nr)
> {
> 	struct lm85_data *data = lm85_update_device(dev);
>-	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp[nr]) );
>+	/* scale is 2^(number of LSBs). There are 4 extra bits in the
>+	   emc6d102 and 2 in the adt7463 and adm1027. In all other chips ext
>+	   is always 0 and the value of scale is irrelevant. So it is left in
>+	   4*/
>+	int scale = (data->type = emc6d102 ) ? 16 : 4;
>+	int ext = exttemp_from_reg(data, nr);
>+	return sprintf(buf,"%d\n",
>+		       TEMPEXT_FROM_REG(data->temp[nr], ext, scale) );
> }
> static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
> {
>  
>

With the previous recommendation, these become a bit simpler:

   return sprintf(buf, "%d\n", INSEXT_FROM_REG(nr, data->in[nr], 
data->in_ext[nr], data->adc_scale) );

for example.  It might even make sense to just pass 'data' to the 
'???EXT_FROM_REG()' macro and let it dereference the structure pointer...

>@@ -1109,6 +1166,9 @@
> 			 */
> 			kind = emc6d100 ;
> 		} else if( company = LM85_COMPANY_SMSC
>+		    && verstep = LM85_VERSTEP_EMC6D102) {
>+			kind = emc6d102 ;
>+		} else if( company = LM85_COMPANY_SMSC
> 		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
> 			dev_err(&adapter->dev, "lm85: Detected SMSC chip\n");
> 			dev_err(&adapter->dev, "lm85: Unrecognized version/stepping 0x%02x"
>  
>
Excellent.

>@@ -1144,6 +1204,8 @@
> 		type_name = "adt7463";
> 	} else if ( kind = emc6d100){
> 		type_name = "emc6d100";
>+	} else if ( kind = emc6d102 ) {
>+		type_name = "emc6d102";
> 	}
> 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
> 
>@@ -1267,7 +1329,6 @@
> 	case LM85_REG_FAN_MIN(2) :
> 	case LM85_REG_FAN_MIN(3) :
> 	case LM85_REG_ALARM1 :	/* Read both bytes at once */
>-	case ADM1027_REG_EXTEND_ADC1 :  /* Read two bytes at once */
> 		res = i2c_smbus_read_byte_data(client, reg) & 0xff ;
> 		res |= i2c_smbus_read_byte_data(client, reg+1) << 8 ;
> 		break ;
>@@ -1371,8 +1432,10 @@
> 		 * more significant bits that are read later.
> 		 */
> 		if ( (data->type = adm1027) || (data->type = adt7463) ) {
>-			data->extend_adc >+			data->extend_adc[0] > 			    lm85_read_value(client, ADM1027_REG_EXTEND_ADC1);
>+			data->extend_adc[1] >+			    lm85_read_value(client, ADM1027_REG_EXTEND_ADC1+1);
> 		}
> 
> 		for (i = 0; i <= 4; ++i) {
>  
>
I would have been clearer to leave in 'ADM1027_REG_EXTEND_ADC2', don't 
you think?

>@@ -1411,6 +1474,16 @@
> 			/* More alarm bits */
> 			data->alarms |> 				lm85_read_value(client, EMC6D100_REG_ALARM3) << 16;
>+		} else if (data->type = emc6d102 ) {
>+			/* LSBs */
>+			data->extend_adc[0] = lm85_read_value(
>+				client, EMC6D102_REG_EXTEND_ADC);
>+			data->extend_adc[1] = lm85_read_value(
>+				client, EMC6D102_REG_EXTEND_ADC + 1);
>+			data->extend_adc[2] = lm85_read_value(
>+				client, EMC6D102_REG_EXTEND_ADC + 2);
>+			data->extend_adc[3] = lm85_read_value(
>+				client, EMC6D102_REG_EXTEND_ADC + 3);
> 		}
> 
> 		data->last_reading = jiffies ;
>  
>
I don't see any comment about the time ordering of reading the LSB's and 
the MSB's.  The data sheet says that reading the upper 8-bit MSB's latch 
the corresponding lower 4 bit LSB's.  You'll note that this is 
*backward* from the ADM1027 where the LSB need to be read *first* to 
latch the MSB's.

A note regarding this difference should be included in comments for the 
code to read the EMC6D102 extended bits.

Also, make sure that the EMC6D100 and 101 registers 0x70-0x78 are *not* 
read if this device is an EMC6D102.

:v)

