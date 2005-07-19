From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 19 Jul 2005 17:38:34 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <1EWvk9oq.1121787110.2238810.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Timothy,

On 2005-07-19, Timothy Findlay wrote:
> My correction sorry, it was actually lm78.h that I needed. There's an
> include directive at the top of the w83627ehf.c file.

You really mean lm75.h then. I now remember the w83627ehf driver needs
it. Should be OK though.

> usr/src/lm-sensors/tim/w83627ehf.c:525: warning: initialization from
> incompatible pointer type

I think I see what happens here. We had a recent change in the sysfs
callback function parameters. You probably need to revert them for your
older kernel. Search for callback functions with the following
parameters:

static ssize_t
show_reg_fan_##offset(struct device *dev, struct device_attribute *attr,
                      char *buf)

And drop the "struct device_attribute *attr" one, resulting in:

static ssize_t
show_reg_fan_##offset(struct device *dev, char *buf)

Do that for all warnings you had when compiling, and hopefully the driver
should then work.

And a note for next time... Never assume that warnings are OK when
porting a driver. Drivers usually compile without any warning (at least
all i2c and hardware monitoring drivers do), so new warnings are always
the sign that something else changed and the driver code needs to be
updated to match that change. That was the case here.

Oh, and please CC the sensors list on replies.

--
Jean Delvare
