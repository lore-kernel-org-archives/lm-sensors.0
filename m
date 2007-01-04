From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 04 Jan 2007 21:28:07 +0000
Subject: [lm-sensors] "sensors" no longer finding pcf8574 and pca9541
Message-Id: <20070104222807.91a39db3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <459BC8E4.1010106@kr4jb.net>
In-Reply-To: <459BC8E4.1010106@kr4jb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

Hey, long time no see, how are you?

On Thu, 4 Jan 2007 15:38:36 -0500, James Olin Oden wrote:
> Jean I work with Alan, and I can definately say that that is easy
> enough, but don't you think there ought to be some generic way to list
> from a CLI and/or an API the I2C devices (similar to lspci for PCI
> devices)?
> 
> Just my 2 cents...james

Well we have "i2cdetect -l" already, which lists the i2c busses, then
"i2cdetect N" to list the devices on i2c bus N. It doesn't give the
chip names though. The problem is that I2C differs fundamentally from
PCI in that the devices are not enumerated and have no unique ID.
i2cdetect attempts to detect the addresses where a device lives, but
it's only trick, we're not following any specification.

So you could write an "lsi2c" tool, but it would have to list the
devices known by the kernel, i.e. for which a driver has already been
loaded. That would be done by walking /sys, should be easy enough. But
it might be a bit confusing that it lists only "driven" devices, as
opposed to lspci or lsusb which list all present devices, even without
a driver.

Or you could add device identification to the tool, and it would
attempt to find out which devices are there, as sensors-detect is
trying to do for I2C/SMBus hardware monitoring chips. But then this is
a huge task, because many I2C chips are really hard to identify just by
probing them, and it some cases it can even be unsafe to just try.

All in all it really depends on what exactly you are trying to achieve.

-- 
Jean Delvare

