From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jul 2007 18:38:32 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon/lm85: Clean up the handling of
Message-Id: <20070705203832.09c26c65@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The way the lm85 driver currently handles the additional resolution
bits some chips have for the voltage and temperature measurements is
quite complex. This is my attempt to make it simpler.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

--- linux-2.6.22-rc6.orig/drivers/hwmon/lm85.c	2007-07-01 14:12:18.000000000 +0200
+++ linux-2.6.22-rc6/drivers/hwmon/lm85.c	2007-07-01 17:26:43.000000000 +0200
@@ -139,10 +139,10 @@ static int lm85_scaling[] = {  /* .001 V
 #define INS_TO_REG(n,val)	\
 		SENSORS_LIMIT(SCALE(val,lm85_scaling[n],192),0,255)
 
-#define INSEXT_FROM_REG(n,val,ext,scale)	\
-		SCALE((val)*(scale) + (ext),192*(scale),lm85_scaling[n])
+#define INSEXT_FROM_REG(n,val,ext)	\
+		SCALE(((val) << 4) + (ext), 192 << 4, lm85_scaling[n])
 
-#define INS_FROM_REG(n,val)   INSEXT_FROM_REG(n,val,0,1)
+#define INS_FROM_REG(n,val)	SCALE((val), 192, lm85_scaling[n])
 
 /* FAN speed is measured using 90kHz clock */
 #define FAN_TO_REG(val)		(SENSORS_LIMIT( (val)<=0?0: 5400000/(val),0,65534))
@@ -151,10 +151,9 @@ static int lm85_scaling[] = {  /* .001 V
 /* Temperature is reported in .001 degC increments */
 #define TEMP_TO_REG(val)	\
 		SENSORS_LIMIT(SCALE(val,1000,1),-127,127)
-#define TEMPEXT_FROM_REG(val,ext,scale)	\
-		SCALE((val)*scale + (ext),scale,1000)
-#define TEMP_FROM_REG(val)	\
-		TEMPEXT_FROM_REG(val,0,1)
+#define TEMPEXT_FROM_REG(val,ext)	\
+		SCALE(((val) << 4) + (ext), 16, 1000)
+#define TEMP_FROM_REG(val)	((val) * 1000)
 
 #define PWM_TO_REG(val)			(SENSORS_LIMIT(val,0,255))
 #define PWM_FROM_REG(val)		(val)
@@ -334,7 +333,6 @@ struct lm85_data {
 	u8 tach_mode;		/* Register encoding, combined */
 	u8 temp_ext[3];		/* Decoded values */
 	u8 in_ext[8];		/* Decoded values */
-	u8 adc_scale;		/* ADC Extended bits scaling factor */
 	u8 fan_ppr;		/* Register value */
 	u8 smooth[3];		/* Register encoding */
 	u8 vid;			/* Register value */
@@ -541,8 +539,7 @@ static ssize_t show_in(struct device *de
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(	buf, "%d\n", INSEXT_FROM_REG(nr,
 						     data->in[nr],
-						     data->in_ext[nr],
-						     data->adc_scale) );
+						     data->in_ext[nr]));
 }
 
 static ssize_t show_in_min(struct device *dev,  struct device_attribute *attr,
@@ -616,8 +613,7 @@ static ssize_t show_temp(struct device *
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf,"%d\n", TEMPEXT_FROM_REG(data->temp[nr],
-						    data->temp_ext[nr],
-						    data->adc_scale) );
+						    data->temp_ext[nr]));
 }
 
 static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
@@ -1394,6 +1390,8 @@ static struct lm85_data *lm85_update_dev
 		
 		/* Have to read extended bits first to "freeze" the
 		 * more significant bits that are read later.
+		 * There are 2 additional resolution bits per channel and we
+		 * have room for 4, so we shift them to the left.
 		 */
 		if ( (data->type = adm1027) || (data->type = adt7463) ) {
 			int ext1 = lm85_read_value(client,
@@ -1403,18 +1401,12 @@ static struct lm85_data *lm85_update_dev
 			int val = (ext1 << 8) + ext2;
 
 			for(i = 0; i <= 4; i++)
-				data->in_ext[i] = (val>>(i * 2))&0x03;
+				data->in_ext[i] = ((val>>(i * 2))&0x03) << 2;
 
 			for(i = 0; i <= 2; i++)
-				data->temp_ext[i] = (val>>((i + 5) * 2))&0x03;
+				data->temp_ext[i] = (val>>((i + 4) * 2))&0x0c;
 		}
 
-		/* adc_scale is 2^(number of LSBs). There are 4 extra bits in
-		   the emc6d102 and 2 in the adt7463 and adm1027. In all
-		   other chips ext is always 0 and the value of scale is
-		   irrelevant. So it is left in 4*/
-		data->adc_scale = (data->type = emc6d102 ) ? 16 : 4;
-
 		data->vid = lm85_read_value(client, LM85_REG_VID);
 
 		for (i = 0; i <= 3; ++i) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
