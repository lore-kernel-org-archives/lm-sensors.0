From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 16 Dec 2008 13:40:07 +0000
Subject: Re: [lm-sensors] Problem with:
Message-Id: <4947AFB7.5000801@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070001030205080908060602"
List-Id: <lm-sensors.vger.kernel.org>
References: <494652C1.8060506@redhat.com>
In-Reply-To: <494652C1.8060506@redhat.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070001030205080908060602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Jean Delvare wrote:
> Hans,
> 
> On Mon, 15 Dec 2008 14:24:48 +0100, Jean Delvare wrote:
>> Hi Hans,
>>
>> On Mon, 15 Dec 2008 13:51:13 +0100, Hans de Goede wrote:
>>> I just realised there is an issue with the 
>>> hwmon-f71882fg-11-separate-max-crit-alarm-and-beep.patch
>>> patch.
>>>
>>> It removes the temp#_alarm attributes (replacing them by temp#_max_alarm), 
>>> which is fine for lm_sensors v3, but will cause a problem with lm_sensors v2, 
>>> the "sensors" command from lm_sensors v2 will now give failed to read data for 
>>> temp# for all 3 temps :(
>> Indeed. I admit I didn't think about lm_sensors v2 when reviewing your
>> patch. This is probably a good reason to _not_ add support for new
>> chips to lm_sensors v2. Owners of such recent hardware should really
>> use lm_sensors v3 anyway.
>>
>>> So it looks like we are sorta stuck with our past mistake of not doing separate 
>>> alarms.
>>>
>>> We could do separate alarms like this:
>>> temp#_alarm
>>> temp#_crit_alarm
>>>
>>> This will work with both libsensors and with "sensors" from both v2 and v3.
>> It's a bit confusing due to the asymmetry, but I admit it should work
>> fine in practice. Feel free to send an updated patch doing this.
>> Including an explanation of why we do this, so that someone reading the
>> code in 3 or 4 years can understand the idea behind it.
> 
> Do you have an update for this patch, please? I'd like to get all
> f71882fg/f8000 patches sorted out today.
> 

Yes I have (for more then a day) I guess I somehow forgot to send it.

Its attached now.

Regards,

Hans

--------------070001030205080908060602
Content-Type: text/plain;
	name="hwmon-f71882fg-11-separate-max-crit-alarm-and-beep-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="hwmon-f71882fg-11-separate-max-crit-alarm-and-beep-v2.patch"

While studying the datasheets for adding F8000 support, I noticed that the
F718x2 has separate alarms (and beep control) for its max and crit limits.

We keep the temp#_alarm attributes as they are, even though it would be more
logical to rename them to temp#_max_alarm. Because lm_sensors v2 depends
on them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.10-applied	2008-12-14 15:25:01.000000000 +0100
+++ linux/drivers/hwmon/f71882fg.c	2008-12-15 15:37:37.000000000 +0100
@@ -270,42 +270,56 @@
 		store_temp_max, 0, 1),
 	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
 		store_temp_max_hyst, 0, 1),
+	/* Should really be temp1_max_alarm, but older versions did not handle
+	   the max and crit alarms separately and lm_sensors v2 depends on the
+	   presence of temp#_alarm files. The same goes for temp2/3 _alarm. */
+	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
+	SENSOR_ATTR_2(temp1_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 1),
 	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 1),
 	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
 		0, 1),
+	SENSOR_ATTR_2(temp1_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 5),
+	SENSOR_ATTR_2(temp1_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 5),
 	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 1),
-	SENSOR_ATTR_2(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 1),
-	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
 	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 2),
 	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 2),
 	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
 		store_temp_max_hyst, 0, 2),
+	/* Should be temp2_max_alarm, see temp1_alarm note */
+	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
+	SENSOR_ATTR_2(temp2_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 2),
 	SENSOR_ATTR_2(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 2),
 	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
 		0, 2),
+	SENSOR_ATTR_2(temp2_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 6),
+	SENSOR_ATTR_2(temp2_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 6),
 	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 2),
-	SENSOR_ATTR_2(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 2),
-	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
 	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
 	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 3),
 	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 3),
 	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
 		store_temp_max_hyst, 0, 3),
+	/* Should be temp3_max_alarm, see temp1_alarm note */
+	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 3),
+	SENSOR_ATTR_2(temp3_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 3),
 	SENSOR_ATTR_2(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 3),
 	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
 		0, 3),
+	SENSOR_ATTR_2(temp3_crit_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 7),
+	SENSOR_ATTR_2(temp3_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 7),
 	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 3),
-	SENSOR_ATTR_2(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 3),
-	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 3),
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 3),
 };
 

--------------070001030205080908060602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070001030205080908060602--
