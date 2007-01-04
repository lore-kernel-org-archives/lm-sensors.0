From: james.oden@gmail.com (James Olin Oden)
Date: Thu, 04 Jan 2007 20:38:36 +0000
Subject: [lm-sensors] "sensors" no longer finding pcf8574 and pca9541
Message-Id: <ac921f990701041238y35e92d7bpc586f59f54ea9e13@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <459BC8E4.1010106@kr4jb.net>
In-Reply-To: <459BC8E4.1010106@kr4jb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

<snip>
> This is expected. Since lm_sensors 2.10.0, libsensors non longer
> handles non-hardware-monitoring chips on recent Linux 2.6 kernels. This
> was briefly documented in the CHANGES document, although only the
> "eeprom" driver case is explicitely listed. This is part of our plan to
> cleanly separate the i2c and hardware monitoring subsystems.
>
> The PCF8574 chip isn't a hardware monitoring chip, so it is no longer
> handled by libsensors. It never actually belang there. For the PCA9541
> I can't tell, the driver doesn't appear to be in the mainline kernel.
>
> So it's really not a bug, it's a feature. You'll have to handle your
> PCF8574 chips directly through sysfs, or write your own script or
> application.
>
Jean I work with Alan, and I can definately say that that is easy
enough, but don't you think there ought to be some generic way to list
from a CLI and/or an API the I2C devices (similar to lspci for PCI
devices)?

Just my 2 cents...james

