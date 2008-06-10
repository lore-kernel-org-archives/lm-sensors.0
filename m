From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jun 2008 11:47:26 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: Handle I2C/ISA aliases in the
Message-Id: <20080610134726.534adee6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Some hardware monitoring chips can be connected to either the ISA (or
LPC) bus or an I2C bus. For some of them (VT1211, W83627HF) we know
that the ISA access is always present, so our drivers don't even offer
support for the I2C access. But older chips (LM78, LM79, W83781D and
W83782D) can really be connected to the I2C bus and not the ISA bus, so
our drivers support both access methods.

One problem that can happen is that a chip is connected to both buses.
In that case, the driver will pick both and present them to the user.
That's both confusing (the user thinks he/she has two chips) and unsafe
(concurrent access from both interfaces is, in general, not guaranteed
to work.) For this reason, sensors-detect is detecting such
"aliases" (by comparing a bunch of selected registers), and tells the
user to pass an "ignore" parameter to the driver in that case, so that
only the ISA access is used and the I2C interface is ignored.

However, this approach is fragile: the user may load the driver without
running sensors-detect, and the i2c bus numbers are not stable across
reboots and hardware changes. So, I think we would be much better
handling the alias detection in the drivers directly. Only two drivers
need this: lm78 and w83781d.

This is one of the two common use cases of the "ignore" i2c driver
parameters. The other one is misdetections. After applying these
patches, if we can solve the few misdetection cases, we might be able
to get rid of the "ignore" parameter entirely.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
