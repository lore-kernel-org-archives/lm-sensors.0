From: Jim Cromie <jim.cromie@gmail.com>
Date: Sun, 14 Oct 2007 23:10:52 +0000
Subject: Re: [lm-sensors] [patch 1/1] w83627hf hoist nr-1 offset out of
Message-Id: <4712A1FC.8060700@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090801070102000006040602"
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0710121550l3eef3a9dvd4ade68510ab8003@mail.gmail.com>
In-Reply-To: <cfe85dfa0710121550l3eef3a9dvd4ade68510ab8003@mail.gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090801070102000006040602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Jim,
>
> On Fri, 12 Oct 2007 17:56:41 -0600, Jim Cromie wrote:
>   
>> this patch replaces last, fixing (long) cast placement,
>> and one previously missed (nr>=2) -> (nr)
>>
>> This hoists nr-1 offset out of (show|store)_temp_*(.*) callbacks, and into
>> SENSOR_DEVICE_ATTRs for sysfs tempN_X files.  It also combines
>> temp[1] and temp_add[2] (array) fields in w83627hf_data into 3 elem arrays,
>> which simplifies special-case handling of nr, allowing simplification
>> of callback bodies and rerolling a flattened loop in
>> w83627hf_update_device(struct device *dev).
>>     
>
> Very nice cleanup, thanks.
>
>   
thank you.

respun per your feedback.
>
> Could be made const. Please also name these w83627hf_reg_* instead of
> w83781d_reg_*. Ultimately we want to remove all references to w83781d
> from this driver.
>
>   
Done.  I included W83627HF_REG_TEMP2,3_CONFIG since theyre
so close (lexically and semantically) that it'd more confusing to leave 
them.

would you take a sed -e s/W83781D/W83627HF/
or a sed -e s/W83781D_REG/W83627HF_REG/ patch ?
or is it more selective than that ?

that said, the current names are a hint about chip & driver
heritage and commonality.
>
>> +	tmp = (nr) ? LM75_TEMP_TO_REG(val)
>> +		   : TEMP_TO_REG(val);
>>     
>
> This instruction could be moved outside of the lock-holding section.
>
>   
OK - I turned these into decl+init statement,
and took out a little whitespace.


--------------090801070102000006040602
Content-Type: text/plain;
 name="diff.hwmon-w83627hf-hoist-temp-offsets"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="diff.hwmon-w83627hf-hoist-temp-offsets"

Binary files hwmon-testing/arch/i386/boot/setup.elf and hwmon-hoist-temp/arch/i386/boot/setup.elf differ
diff -ruNp -X dontdiff -X exclude-diffs hwmon-testing/drivers/hwmon/w83627hf.c hwmon-hoist-temp/drivers/hwmon/w83627hf.c
--- hwmon-testing/drivers/hwmon/w83627hf.c	2007-10-14 13:00:24.000000000 -0600
+++ hwmon-hoist-temp/drivers/hwmon/w83627hf.c	2007-10-14 16:58:56.000000000 -0600
@@ -173,17 +173,12 @@ superio_exit(void)
 #define W83781D_REG_FAN_MIN(nr) (0x3a + (nr))
 #define W83781D_REG_FAN(nr) (0x27 + (nr))
 
-#define W83781D_REG_TEMP2_CONFIG 0x152
-#define W83781D_REG_TEMP3_CONFIG 0x252
-#define W83781D_REG_TEMP(nr)		((nr == 3) ? (0x0250) : \
-					((nr == 2) ? (0x0150) : \
-					             (0x27)))
-#define W83781D_REG_TEMP_HYST(nr)	((nr == 3) ? (0x253) : \
-					((nr == 2) ? (0x153) : \
-					             (0x3A)))
-#define W83781D_REG_TEMP_OVER(nr)	((nr == 3) ? (0x255) : \
-					((nr == 2) ? (0x155) : \
-					             (0x39)))
+#define W83627HF_REG_TEMP2_CONFIG 0x152
+#define W83627HF_REG_TEMP3_CONFIG 0x252
+/* these are zero-based, unlike config constants above */
+static const u16 w83627hf_reg_temp[]		= { 0x27, 0x150, 0x250 };
+static const u16 w83627hf_reg_temp_hyst[]	= { 0x3A, 0x153, 0x253 };
+static const u16 w83627hf_reg_temp_over[]	= { 0x39, 0x155, 0x255 };
 
 #define W83781D_REG_BANK 0x4E
 
@@ -360,12 +355,9 @@ struct w83627hf_data {
 	u8 in_min[9];		/* Register value */
 	u8 fan[3];		/* Register value */
 	u8 fan_min[3];		/* Register value */
-	u8 temp;
-	u8 temp_max;		/* Register value */
-	u8 temp_max_hyst;	/* Register value */
-	u16 temp_add[2];	/* Register value */
-	u16 temp_max_add[2];	/* Register value */
-	u16 temp_max_hyst_add[2]; /* Register value */
+	u16 temp[3];		/* Register value */
+	u16 temp_max[3];	/* Register value */
+	u16 temp_max_hyst[3];	/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
@@ -611,12 +603,10 @@ show_temp(struct device *dev, struct dev
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	if (nr >= 2) {	/* TEMP2 and TEMP3 */
-		return sprintf(buf, "%ld\n",
-			(long)LM75_TEMP_FROM_REG(data->temp_add[nr-2]));
-	} else {	/* TEMP1 */
-		return sprintf(buf, "%ld\n", (long)TEMP_FROM_REG(data->temp));
-	}
+
+	u16 tmp = data->temp[nr];
+	return sprintf(buf, "%ld\n", (nr) ? (long) LM75_TEMP_FROM_REG(tmp)
+					  : (long) TEMP_FROM_REG(tmp));
 }
 
 static ssize_t
@@ -625,13 +615,10 @@ show_temp_max(struct device *dev, struct
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	if (nr >= 2) {	/* TEMP2 and TEMP3 */
-		return sprintf(buf, "%ld\n",
-			(long)LM75_TEMP_FROM_REG(data->temp_max_add[nr-2]));
-	} else {	/* TEMP1 */
-		return sprintf(buf, "%ld\n",
-			(long)TEMP_FROM_REG(data->temp_max));
-	}
+
+	u16 tmp = data->temp_max[nr];
+	return sprintf(buf, "%ld\n", (nr) ? (long) LM75_TEMP_FROM_REG(tmp)
+					  : (long) TEMP_FROM_REG(tmp));
 }
 
 static ssize_t
@@ -640,13 +627,10 @@ show_temp_max_hyst(struct device *dev, s
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	if (nr >= 2) {	/* TEMP2 and TEMP3 */
-		return sprintf(buf, "%ld\n",
-			(long)LM75_TEMP_FROM_REG(data->temp_max_hyst_add[nr-2]));
-	} else {	/* TEMP1 */
-		return sprintf(buf, "%ld\n",
-			(long)TEMP_FROM_REG(data->temp_max_hyst));
-	}
+
+	u16 tmp = data->temp_max_hyst[nr];
+	return sprintf(buf, "%ld\n", (nr) ? (long) LM75_TEMP_FROM_REG(tmp)
+					  : (long) TEMP_FROM_REG(tmp));
 }
 
 static ssize_t
@@ -656,18 +640,11 @@ store_temp_max(struct device *dev, struc
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	long val = simple_strtol(buf, NULL, 10);
+	u16 tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
 
 	mutex_lock(&data->update_lock);
-
-	if (nr >= 2) {	/* TEMP2 and TEMP3 */
-		data->temp_max_add[nr-2] = LM75_TEMP_TO_REG(val);
-		w83627hf_write_value(data, W83781D_REG_TEMP_OVER(nr),
-				data->temp_max_add[nr-2]);
-	} else {	/* TEMP1 */
-		data->temp_max = TEMP_TO_REG(val);
-		w83627hf_write_value(data, W83781D_REG_TEMP_OVER(nr),
-			data->temp_max);
-	}
+	data->temp_max[nr] = tmp;
+	w83627hf_write_value(data, w83627hf_reg_temp_over[nr], tmp);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -679,29 +656,22 @@ store_temp_max_hyst(struct device *dev, 
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	long val = simple_strtol(buf, NULL, 10);
+	u16 tmp = (nr) ? LM75_TEMP_TO_REG(val) : TEMP_TO_REG(val);
 
 	mutex_lock(&data->update_lock);
-
-	if (nr >= 2) {	/* TEMP2 and TEMP3 */
-		data->temp_max_hyst_add[nr-2] = LM75_TEMP_TO_REG(val);
-		w83627hf_write_value(data, W83781D_REG_TEMP_HYST(nr),
-				data->temp_max_hyst_add[nr-2]);
-	} else {	/* TEMP1 */
-		data->temp_max_hyst = TEMP_TO_REG(val);
-		w83627hf_write_value(data, W83781D_REG_TEMP_HYST(nr),
-			data->temp_max_hyst);
-	}
+	data->temp_max_hyst[nr] = tmp;
+	w83627hf_write_value(data, w83627hf_reg_temp_hyst[nr], tmp);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
 #define sysfs_temp_decl(offset) \
 static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
-			  show_temp, NULL, offset);			\
+			  show_temp, NULL, offset - 1);			\
 static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO|S_IWUSR,	 	\
-			  show_temp_max, store_temp_max, offset);	\
+			  show_temp_max, store_temp_max, offset - 1);	\
 static SENSOR_DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO|S_IWUSR,	\
-			  show_temp_max_hyst, store_temp_max_hyst, offset);
+			  show_temp_max_hyst, store_temp_max_hyst, offset - 1);
 
 sysfs_temp_decl(1);
 sysfs_temp_decl(2);
@@ -1514,23 +1484,23 @@ static void __devinit w83627hf_init_devi
 
 	if(init) {
 		/* Enable temp2 */
-		tmp = w83627hf_read_value(data, W83781D_REG_TEMP2_CONFIG);
+		tmp = w83627hf_read_value(data, W83627HF_REG_TEMP2_CONFIG);
 		if (tmp & 0x01) {
 			dev_warn(&pdev->dev, "Enabling temp2, readings "
 				 "might not make sense\n");
-			w83627hf_write_value(data, W83781D_REG_TEMP2_CONFIG,
+			w83627hf_write_value(data, W83627HF_REG_TEMP2_CONFIG,
 				tmp & 0xfe);
 		}
 
 		/* Enable temp3 */
 		if (type != w83697hf) {
 			tmp = w83627hf_read_value(data,
-				W83781D_REG_TEMP3_CONFIG);
+				W83627HF_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
 				dev_warn(&pdev->dev, "Enabling temp3, "
 					 "readings might not make sense\n");
 				w83627hf_write_value(data,
-					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
+					W83627HF_REG_TEMP3_CONFIG, tmp & 0xfe);
 			}
 		}
 	}
@@ -1563,7 +1533,7 @@ static void w83627hf_update_fan_div(stru
 static struct w83627hf_data *w83627hf_update_device(struct device *dev)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	int i;
+	int i, num_temps = (data->type == w83697hf) ? 2 : 3;
 
 	mutex_lock(&data->update_lock);
 
@@ -1616,25 +1586,13 @@ static struct w83627hf_data *w83627hf_up
 					break;
 			}
 		}
-
-		data->temp = w83627hf_read_value(data, W83781D_REG_TEMP(1));
-		data->temp_max =
-		    w83627hf_read_value(data, W83781D_REG_TEMP_OVER(1));
-		data->temp_max_hyst =
-		    w83627hf_read_value(data, W83781D_REG_TEMP_HYST(1));
-		data->temp_add[0] =
-		    w83627hf_read_value(data, W83781D_REG_TEMP(2));
-		data->temp_max_add[0] =
-		    w83627hf_read_value(data, W83781D_REG_TEMP_OVER(2));
-		data->temp_max_hyst_add[0] =
-		    w83627hf_read_value(data, W83781D_REG_TEMP_HYST(2));
-		if (data->type != w83697hf) {
-			data->temp_add[1] =
-			  w83627hf_read_value(data, W83781D_REG_TEMP(3));
-			data->temp_max_add[1] =
-			  w83627hf_read_value(data, W83781D_REG_TEMP_OVER(3));
-			data->temp_max_hyst_add[1] =
-			  w83627hf_read_value(data, W83781D_REG_TEMP_HYST(3));
+		for (i = 0; i < num_temps; i++) {
+			data->temp[i] = w83627hf_read_value(
+						data, w83627hf_reg_temp[i]);
+			data->temp_max[i] = w83627hf_read_value(
+						data, w83627hf_reg_temp_over[i]);
+			data->temp_max_hyst[i] = w83627hf_read_value(
+						data, w83627hf_reg_temp_hyst[i]);
 		}
 
 		w83627hf_update_fan_div(data);

--------------090801070102000006040602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090801070102000006040602--
