From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 21 Oct 2008 18:14:17 +0000
Subject: Re: [lm-sensors] PATCH: f71882fg move some io access from the
Message-Id: <48FE1BF9.6060009@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080600020207090905090304"
List-Id: <lm-sensors.vger.kernel.org>
References: <48FDE62B.7020607@redhat.com>
In-Reply-To: <48FDE62B.7020607@redhat.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080600020207090905090304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Hans,
> 
> On Tue, 21 Oct 2008 16:24:43 +0200, Hans de Goede wrote:
>> The f71882fg driver did some io to ioports it hadn't reserved yet in its
>> find (detect) function, this patches moves this io to the probe function
>> where these ports are reserved and this io belongs.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Review:
> 

<snip>

>> @@ -1507,12 +1507,31 @@
>>  	mutex_init(&data->update_lock);
>>  	platform_set_drvdata(pdev, data);
>>  
>> +	start_reg = f71882fg_read8(data, F71882FG_REG_START);
>> +	if (!(start_reg & 0x03)) {
>> +		printk(KERN_WARNING DRVNAME
>> +			": Hardware monitoring not activated\n");
> 
> Please use dev_info() instead.
> 

Done.

>> +		goto exit_free;
> 
> You're returning with err = 0, which means success. So when you unload
> the driver, the f71882fg_remove() function will be called and you'll
> double-free your private data structure. No good.
> 
> I think you should simply return -ENODEV here.
> 

Done.

>> +	}
>> +
>> +	/* If it is a 71862 and the fan / pwm part is enabled sanity check
>> +	   the pwm settings */
>> +	if (data->type == f71862fg && (start_reg & 0x02)) {
>> +		u8 reg = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
>> +		if ((reg & 0x15) != 0x15) {
>> +			printk(KERN_ERR DRVNAME
>> +				": Invalid (reserved) pwm settings: 0x%02x\n",
>> +				(unsigned int)reg);
> 
> Here again please use dev_err().
> 

Done.

>> +			err = -EIO;
> 
> This isn't actually an I/O error, I think I'd return -ENODEV as well.

Done.

> Or, ideally, you could simply disable the pwm features of the driver
> but still let it bind. After all, voltage, temperature and fan features
> are still useful, aren't they?
> 

This is a should never happen case, those bits I'm testing are reserved and 
should always be 1, the reason I'm testing them is because the 71862 only has 
PWM auto fan control, where as the 71882 has both PWM and RPM modes, the code 
paths used by both check these bits to see if the chip is in RPM or PWM mode, 
so if these *reserved* bits have the wrong value, the RPM mode code path can be 
entered on the 71862.

Even more troublesome is that as the 71862 clearly is a stripped down 71882 the 
chip itself may behave funny if programmed to be in the removed RPM modes. So I 
rather just bail completely when this register shows the should never happen 
readings. If this message gets triggered ever (and reported) we can revisit this.

I've attached an updated version of the patch.

Regards,

Hans

--------------080600020207090905090304
Content-Type: text/plain; name="f71882fg-no-io-to-unreserverd-ports-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="f71882fg-no-io-to-unreserverd-ports-v2.patch"

The f71882fg driver did some io to ioports it hadn't reserved yet in its
find (detect) function, this patches moves this io to the probe function
where these ports are reserved and this io belongs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- f71882fg.c.f71862fg	2008-10-21 15:34:41.000000000 +0200
+++ f71882fg.c	2008-10-21 19:56:11.000000000 +0200
@@ -1507,12 +1507,31 @@
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
+	start_reg = f71882fg_read8(data, F71882FG_REG_START);
+	if (!(start_reg & 0x03)) {
+		dev_info(&pdev->dev, ": Hardware monitoring not activated\n");
+		err = -ENODEV;
+		goto exit_free;
+	}
+
+	/* If it is a 71862 and the fan / pwm part is enabled sanity check
+	   the pwm settings */
+	if (data->type == f71862fg && (start_reg & 0x02)) {
+		u8 reg = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
+		if ((reg & 0x15) != 0x15) {
+			dev_err(&pdev->dev,
+				": Invalid (reserved) pwm settings: 0x%02x\n",
+				(unsigned int)reg);
+			err = -ENODEV;
+			goto exit_free;
+		}
+	}
+
 	/* Register sysfs interface files */
 	err = device_create_file(&pdev->dev, &dev_attr_name);
 	if (err)
 		goto exit_unregister_sysfs;
 
-	start_reg = f71882fg_read8(data, F71882FG_REG_START);
 	if (start_reg & 0x01) {
 		err = f71882fg_create_sysfs_files(pdev, f718x2fg_in_temp_attr,
 					ARRAY_SIZE(f718x2fg_in_temp_attr));
@@ -1558,7 +1577,9 @@
 
 exit_unregister_sysfs:
 	f71882fg_remove(pdev); /* Will unregister the sysfs files for us */
-
+	return err; /* f71882fg_remove() also frees our data */
+exit_free:
+	kfree(data);
 	return err;
 }
 
@@ -1600,8 +1621,6 @@
 {
 	int err = -ENODEV;
 	u16 devid;
-	u8 reg;
-	struct f71882fg_data data;
 
 	superio_enter(sioaddr);
 
@@ -1638,25 +1657,6 @@
 	}
 	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
 
-	data.addr = *address;
-	reg = f71882fg_read8(&data, F71882FG_REG_START);
-	if (!(reg & 0x03)) {
-		printk(KERN_WARNING DRVNAME
-			": Hardware monitoring not activated\n");
-		goto exit;
-	}
-
-	/* If it is a 71862 and the fan / pwm part is enabled sanity check
-	   the pwm settings */
-	if (sio_data->type == f71862fg && (reg & 0x02)) {
-		reg = f71882fg_read8(&data, F71882FG_REG_PWM_ENABLE);
-		if ((reg & 0x15) != 0x15) {
-			printk(KERN_ERR DRVNAME
-				": Invalid (reserved) pwm settings: 0x%02x\n",
-				(unsigned int)reg);
-			goto exit;
-		}
-	}
 	err = 0;
 	printk(KERN_INFO DRVNAME ": Found %s chip at %#x, revision %d\n",
 		f71882fg_names[sio_data->type],	(unsigned int)*address,

--------------080600020207090905090304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080600020207090905090304--
