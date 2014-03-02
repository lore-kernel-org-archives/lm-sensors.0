From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Mar 2014 14:43:41 +0000
Subject: Re: [lm-sensors] LM73 chip access through userspace
Message-Id: <20140302154341.0949f358@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAi8uRy6EmTDvKavChvx6_bUZvcoVD3Et=Tt5R66h6NkkHAcUA@mail.gmail.com>
In-Reply-To: <CAAi8uRy6EmTDvKavChvx6_bUZvcoVD3Et=Tt5R66h6NkkHAcUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

On Sat, 1 Mar 2014 23:30:33 -0800, Romanic Dean wrote:
> Hi all,
> 
> I am working with 3.8 version of kernel and its device tree driven kernel
> I wanted to read temperature from lm73 sensor.It should happen from user
> land application.
> 
> Now first of all have enabled the dts support for lm73 device by adding
> below in my dts file
> 
> dtt@49 {
>     compatible = "lm73";
>     reg = <0x49>;
>     };
> 
> and kernel driver compiled is lm73.o .
> 
> I could see in my boot logs that driver's probe method is called ,so now
> how DO I confirm that lm73 device is Probed OK and usable?

You can look under /sys/class/hwmon, one of the entries should be for your
LM73 chip.

> Now if it initialized OK then what all expected entries I should see in
> /sys/bus/i2c/devices file system?

That would be looking at the wrong place. What you are interested in is
the hwmon interface exposed by the lm73 driver, not the I2C bus side of
things. /sys/class/hwmon is the place to explore.

> How Do I read temperature from lm73 sensor using sysfs in userspace?

Using "sensors" or any other libsensors-based application. Both
libsensors and sensors come from lm-sensors, but exact packaging
details vary from one distribution to the next (e.g. on openSUSE you'd
install "sensors" and let it draw libsensors4 as a dependency.)

Hope that helps,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
