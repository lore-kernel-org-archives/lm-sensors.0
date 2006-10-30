From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Mon, 30 Oct 2006 23:13:27 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG
Message-Id: <200610310013.27367.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David

a small note on fan control below.

Best regards
	Christian

Am Sonntag, 29. Oktober 2006 21:33 schrieben Sie:
> >
> > How to do? Which values to echo in?
>
> There is documentation in the kernel source under
> linux/documentation/hwmon. Basically, set pwmN_enable to 1 for manual
> control, 2 for automatic "thermal cruise" or "SmartFan 1". In manual
> mode, echo "0" > pwmN stops the fan, and echo "255" > pwmN to run the
> fan at full speed.
>


I did some study of the documentation, assuming that the notes for either 
w83792d or w83627hf do apply whatever sounds more likely - no precise info on w83627HDG ...

fan connections
For me, the relatationship between the 5 fan tacho reads and the 4 pwm-control ports are somewhat unclear to me: All "chassis" type fans I have installed (1,4,5) seem to be connected to pwm4 ? I cannot control them individually, they all move in sync.

pwm*enable
- I can read value "4" from pwm*_enable after having set "Silent" in Bios. Is this out of range? which values are allowe 0..3?

- When I try to set values, I can set "1" and "2" but neither "0" for "off" or "4" for "Thermal cruise" (whatever this is).

The driver prevents this. Please have a look to line 920 ff:

static ssize_t
store_pwm_enable(struct device *dev, struct device_attribute *attr,
			const char *buf, size_t count)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct w83627ehf_data *data = i2c_get_clientdata(client);
	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
	int nr = sensor_attr->index;
	u32 val = simple_strtoul(buf, NULL, 10);
	u16 reg;

	if (!val || (val > 2))	/* only modes 1 and 2 are supported */
		return -EINVAL;
	mutex_lock(&data->update_lock);
	reg = w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
	data->pwm_enable[nr] = val;
	reg &= ~(0x03 << W83627EHF_PWM_ENABLE_SHIFT[nr]);
	reg |= (val - 1) << W83627EHF_PWM_ENABLE_SHIFT[nr];
	w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr], reg);
	mutex_unlock(&data->update_lock);
	return count;
}

Can you check in the data sheet for W83627DHG whether its correct to expand the range to 0..3 or whatever suitable? will the shift masks be still correct also for the  W83627DHG ?

1=Manual mode
when I set  pwm4_enable to 1 I can control all 3 fan speeds simultanously by  "echo xx >pwm4" 
2= Smartfan 1 mode
this brings the fans to such a low speed that the fan reading becomes jumping back and forth -  fan registers showing erraneously either zero or 5000...15000 rpm
I am still experimenting here, to lower the CPU temp (pwm-target?) to check 
 pwm*-registers
pwm*min_output:  purpose seems unclear to me. seems to work as lower fan limit value in case of smartfan mode1. no function in manual mode.
pwm*_stop_time : no idea
pwm*_target : seems to compare to temp2_input when in smartfan 1 mode
pwm*_tolerance  : hysteresis for pwm_target?
... my studies so far....
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061031/a5b50538/attachment.html 
