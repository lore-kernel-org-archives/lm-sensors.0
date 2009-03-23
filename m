From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Mar 2009 20:07:22 +0000
Subject: Re: [lm-sensors] new driver for adt746x.. need some hints
Message-Id: <20090323210722.7bd3ca7c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7b71803f0903221448m56cf985ev977bb1892e6c5702@mail.gmail.com>
In-Reply-To: <7b71803f0903221448m56cf985ev977bb1892e6c5702@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Mar 2009 14:06:05 +0100, DaNiMoTh wrote:

BTW, I strongly suggests that you give up CoWbOy-style. Really, we're
all grown-ups here.

> 2009/3/23 Jean Delvare <khali@linux-fr.org>:
> > On Sun, 22 Mar 2009 22:48:13 +0100, DaNiMoTh wrote:
> > This driver already exists: see drivers/macintosh/therm_adt746x.c.
> 
> Hello Jean,
> you're right, the driver already exists. But you know that the old
> module don't use the new model for i2c device,

Yes, that's right. Converting it is still on my to-do list but I never
seem to find the time to do it. I was hoping that the powerpc people
would try and to it themselves, but it didn't happen yet.

> and also it uses its
> own way to do all the things ( temp, pwm and fan reading / set ). So,

Indeed. This surprised me as well at first, but this is how Ben
Herrenschmidt (Cc'd) wants things to be, and he has reasonable
arguments. If you disagree, talk to him.

One thing that should be possible though, and I think Ben wouldn't
object, is to export the monitored values, read-only, using the
standard hwmon interface. That way you'd see the temperatures, fan
speeds etc. using "sensors" and any other libsensors-based monitoring
application. I think it would make a lot of sense.

> I ( and many mac users ) can't use the useful tools of lm_sensors. So,
> I try to rewrite it reading the upgrading the client faq, but it was
> very very difficult. I decided to rewrite it again, from zero, using
> the adt7470 example, which I think it looks very nice and works very
> good.
> 
> > I have a question too: how are we supposed to guess what is wrong
> > with you giving us _zero_ technical information? No source code, and
> > only a vague explanation of what you did. What do you think we are
> > doing here, cartomancy?
> 
> Excuse me, I try to be more clear.
> 
> I wrote the adt746x device driver with the new model, so I implemented
> the probe, detect and remove routine ( and I will post another
> question about these, but this isn't the time ). Also, I've used the
> attr table. For example, I wrote (following the sysfs interface
> documentation )
> 
> static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
> 		    show_pwm_tmin, set_pwm_tmin, 0);
> 
> adding it to the attr by
> 
> 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> 
> then, I wrote the two routines, show_pwm_tmin and set_pwm_tmin, that
> show and set the desidered value by the way written on datasheet. For
> example, I paste the (short) code of show_pwm_tmin
> 
> static ssize_t show_pwm_tmin(struct device *dev,
> 			     struct device_attribute *devattr,
> 			     char *buf)
> {
> 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> 	struct adt746x_data *data = adt746x_update_device(dev);
> 	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
> }
> 
> I can read the value, doing a simple command:
> cat /sys/class/hwmon/hwmon0/device/pwm1_auto_point1_temp
> 
> The problem is that (set_pwm_tmin) is written but I can't test it. How
> I can write to this value ( RW by spec ) ?
> If I do
> echo "50" > /sys/class/hwmon/hwmon0/device/pwm1_auto_point1_temp
> it returns me a permission denied. I tried echo -n "50", echo -n 50
> ... Without any win.

Writes only work as root. Are you root?

> Also, what is the right way to control the pwm ( like pwmX_enable,
> pwmX, pwmX_auto_* ) ? In the module itself ( but I don't see any " Set
> limit of temp1 to 80C" or "Set the temperature which fan starts to
> 60C" in the adt7470 code ), using a manual script that do these
> modifications on sysfs ( in a way that I don't know ) or by lm_sensors
> (also in a way that I don't know) ?

On PC, this works as follows. For manual control we have a simple
user-space daemon script called fancontrol, which writes to pwmN sysfs
files based on temperature values. For automatic control, you program
the pwmN_auto_* attributes once and for all at boot time (although for
many systems the BIOS thankfully does most of the work for you.)

On Mac though, thermal management is handled automatically by the
kernel drivers themselves.

> If the complete source code is still needed to answer my question, I'm
> glad to send it to this mailing list as a patch to 2.6.28 kernel ( or
> version that you want ).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
