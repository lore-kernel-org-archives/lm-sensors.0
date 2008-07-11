From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Jul 2008 12:56:13 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS75 thermal sensor
Message-Id: <20080711145613.14380360@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <487331DC.2020601@grandegger.com>
In-Reply-To: <487331DC.2020601@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfgang,

On Fri, 11 Jul 2008 14:40:58 +0200, Wolfgang Grandegger wrote:
> Jean Delvare wrote:
> > There's no "detection" involved for the new-style i2c devices.
> > Presumably you are still using the old binding model, not taking
> > benefit of the patch at all. Use i2c_register_board_info() to
> > instantiate your "ds75" i2c device from you board's platform code, and
> > it should work.
> 
> I have some general question on I2C device probing. Our board does have 
> two I2C buses. On the first on, there is an RTC at addr 0x32 and a DS75 
> at 0x4c. Both are defined in the Flattened Device Tree and therefore 
> i2c_register_board_info() will be called for them. On the second bus, 
> there are other I2C devices. Nevertheless, probing for RTC and DS75 at 
> addr 0x32 and 0x4c will be performed also on that bus. Is this the 
> normal/intended behavior? Can such probing be suppressed?

Probing isn't supposed to happen at all for RTC chips. There are a few
drivers which remain to be converted though (rtc-ds1672, rtc-max6900,
rtc-pcf8583.) If you use one of these and would like to help converting
it, please tell me (and Alessandro Zummo.)

For hwmon chips, probing only occurs if the i2c adapter accepts to be
probed, by setting the I2C_CLASS_HWMON flag in i2c_adapter.class. If
you do not want a given i2c bus to be probed, then do not set the flag
for that bus.

Additionally, with legacy i2c chip drivers you can prevent a probe from
happening by passing an "ignore" parameter. For example, loading the
lm75 driver with:

modprobe lm75 ignore=1,0x48,1,0x49

will prevent the lm75 driver from probing I2C addresses 0x48 and 0x49
on i2c bus 1.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
