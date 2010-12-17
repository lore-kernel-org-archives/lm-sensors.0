From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Dec 2010 19:42:51 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101217204251.3bc1e9b6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 17 Dec 2010 12:43:35 -0600 (CST), Jeff Rickman wrote:
> > The SCH5127 has an automatic fan speed control mode which you should be
> > able to setup by writing the proper values to sysfs. Should be
> > equivalent to "fancontrol" but more reactive and less CPU-intensive.
> 
> I studied the sysfs entries carefully while using fancontrol
> and not using fancontrol. I decided to do the following:
> 
> echo 1 > /sys/devices/platform/dme1737.2160/pwm1_enable
> echo 255 > /sys/devices/platform/dme1737.2160/pwm1
> 
> Works fine.

This puts the fan to full speed (100% duty cycle.) This is equivalent
to, but presumably less efficient than:

$ echo 0 > /sys/devices/platform/dme1737.2160/pwm1_enable

If the noise is bearable then you're done indeed. But what I actually
had in mind was setting to automatic mode:

$ echo 2 > /sys/devices/platform/dme1737.2160/pwm1_enable

And then fine-tuning the pwm1_auto_channels_zone,
zone*_auto_channels_temp and zone*_auto_point*_temp values. This would
let you tune the fan speeds from medium at idle to full speed under load
(best noise/temperature trade-off.) If you try that, you'll have to
read the documentation in Documentation/hwmon/dme1737.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
