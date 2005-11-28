From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 28 Nov 2005 10:41:21 +0000
Subject: [Fwd: Re: [lm-sensors] Kernel hangs with i2c-i801 driver?]
Message-Id: <438AD09C.7060002@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051126073613.GG26906@oden.homeip.net>
In-Reply-To: <20051126073613.GG26906@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Sorry for a delay.

> I was finally able to get into a situation where I can reproduce the
> hang in a repeatable fashion. I'm using this script to set the values:
> 
> find /sys/bus/i2c/devices/0-002c/ -name 'in*_min' -exec /bin/sh -c '/bin/echo 0 > {}' \; 
> find /sys/bus/i2c/devices/0-002c/ -name 'in*_max' -exec /bin/sh -c '/bin/echo 10000 > {}' \; 
> find /sys/bus/i2c/devices/0-002c/ -name 'temp*_min' -exec /bin/sh -c '/bin/echo 0 > {}' \;
> find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max' -exec /bin/sh -c '/bin/echo 100000 > {}' \;
> find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max_hyst' -exec /bin/sh -c '/bin/echo 0 > {}' \;
> #find /sys/bus/i2c/devices/0-002c/ -name 'fan*_min' -exec /bin/sh -c '/bin/echo 0 > {}' \;
> #find /sys/bus/i2c/devices/0-002c/ -name 'fan*_div' -exec /bin/sh -c '/bin/echo 2 > {}' \;
> 
> If I uncommment the last two lines I can always get the system to
> hang, but I have sometimes been able to get it to hang by just setting
> the in* and temp* limits as well.
> 
> I tried executing 'setpci  -s 0:1f.3 40.b=1', that command completed
> without complaining but I didn't see any difference in the
> behaviour. But I don't know how to verify that the setpci command
> actually did what you were expecting it to do.

This just disables the smbalert signal. Maybe the output from a chip is routed
to other pin. Please can you provide the dump after cold boot and BEFORE loading
the w83792d driver?

i2cdump 0 0x2c

> I noticed one more thing that might not make a difference here, in my
> initial post I probably showed the output from sensors with the fan
> sensors that are not used hidden (by setting the ignore option in
> sensors.conf). I noticed that Fan7 is giving a negative value and has a
> different default divisor and  min value. It is also the only fan
> giving an alarm in the default state. I thought this might be
> significant since setting the fan limits in the script above seem to
> be what always caused the hang.

We have a patch from Yuan, I hope it is not malformed by my stupid mail client.

--- linux-2.6.14-rc5.orig/drivers/hwmon/w83792d.c	2005-11-09 11:27:44.000000000 +0800
+++ linux-2.6.14-rc5/drivers/hwmon/w83792d.c	2005-11-11 17:05:50.000000000 +0800
@@ -257,7 +257,7 @@ DIV_TO_REG(long val)
 {
 	int i;
 	val = SENSORS_LIMIT(val, 1, 128) >> 1;
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
 		val >>= 1;
@@ -1284,8 +1284,8 @@ w83792d_detect(struct i2c_adapter *adapt
 	w83792d_init_client(new_client);

 	/* A few vars need to be filled upon startup */
-	for (i = 1; i <= 7; i++) {
-		data->fan_min[i - 1] = w83792d_read_value(new_client,
+	for (i = 0; i < 7; i++) {
+		data->fan_min[i] = w83792d_read_value(new_client,
 					W83792D_REG_FAN_MIN[i]);
 	}

@@ -1311,7 +1311,9 @@ w83792d_detect(struct i2c_adapter *adapt
 	device_create_file_fan(new_client, 4);
 	device_create_file_fan(new_client, 5);
 	device_create_file_fan(new_client, 6);
-	device_create_file_fan(new_client, 7);
+	val1 = w83792d_read_value(new_client, W83792D_REG_PIN);
+	if ( val1 & 0x04 )
+		device_create_file_fan(new_client, 7);

 	device_create_file_temp1(new_client);		/* Temp1 */
 	device_create_file_temp_add(new_client, 2);	/* Temp2 */

You may extend this from:

+	if ( val1 & 0x04 )
+		device_create_file_fan(new_client, 7);

add:

- 	device_create_file_fan(new_client, 6);
+	if ( val1 & 0x40 )
+		device_create_file_fan(new_client, 6);

Because fan6 and fan7 - mean their pins are programmable so correct would be to create their files when
they actual outputs are really used for fans...


> oden:~# sensors
> w83792d-i2c-0-2c
> Adapter: SMBus I801 adapter at 3080
> VCoreA:    +1.69 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
> VCoreB:    +1.70 V  (min =  +1.48 V, max =  +1.60 V)       ALARM
> VIN0:      +2.96 V  (min =  +3.20 V, max =  +3.39 V)       ALARM
> VIN1:      +2.97 V  (min =  +3.09 V, max =  +3.30 V)       ALARM
> VIN2:      +2.96 V  (min =  +1.39 V, max =  +1.49 V)       ALARM
> VIN3:      +2.96 V  (min =  +2.59 V, max =  +2.64 V)       ALARM
> 5VCC:      +4.94 V  (min =  +4.73 V, max =  +5.23 V)
> 5VSB:      +5.06 V  (min =  +4.73 V, max =  +5.23 V)
> VBAT:      +3.23 V  (min =  +2.85 V, max =  +3.14 V)       ALARM
> Fan1:     2616 RPM  (min = 1500 RPM, div = 4)
> Fan2:        0 RPM  (min =  703 RPM, div = 8)
> Fan3:     1480 RPM  (min =  703 RPM, div = 8)
> Fan4:        0 RPM  (min =  703 RPM, div = 8)
> Fan5:        0 RPM  (min =  703 RPM, div = 8)
> Fan6:        0 RPM  (min =  703 RPM, div = 8)
> Fan7:       -1 RPM  (min =    0 RPM, div = 2)              ALARM
> Temp1:     +22.0?C  (high = +36.0?C, hyst = +31.0?C)   ALARM
> Temp2:     +41.0?C  (high = +60.0?C, hyst = +57.0?C)   ALARM
> Temp3:     +46.5?C  (high = +96.0?C, hyst = +93.0?C)   ALARM
> chassis:  Chassis is normal.
> 
> Should I still try the UP kernel and an older kernel version?

Lets wait if the patch solve this. I think it should solve the fan7 for sure.
Thanks
Regards
Rudolf
