From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 02 Feb 2006 21:53:03 +0000
Subject: [lm-sensors] use of struct platform_device vs struct device in
Message-Id: <20060202225303.351c1f78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43E12BDF.1020805@gmail.com>
In-Reply-To: <43E12BDF.1020805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> while LXR'g  (http://sosdg.org/~coywolf/lxr/)
> for usage of struct platform_device, I found your code.
> 
> What were your reasons for using platform_device, what are the benefits ?
> 
> Were they special-case considerations, or is this something that
> other hwmon drivers should consider moving towards ?

Well, the reasons were simply that the Fintek F71805F/FG is not an
I2C/SMBus device. For too long, all hardware monitoring drivers have
been implemented as i2c drivers, even when they were absolutely not
I2C/SMBus related. This was made possible by the i2c-isa driver, which
has an historical reason for existing: some chips (LM78 and W83781D to
name the most popular ones) used to have two possible interfaces, I2C
and ISA. In order to avoid code duplication while keeping the drivers
simple, it was decided to handle the ISA interface as a fake I2C bus.

Now, there are more and more hardware monitoring devices which are
either integrated into PCI devices, of integrated into Super-I/O chips,
with a simple ISA interface. Depending on the whole i2c stack to drive
these is quite boring and inefficient now, so I have been working on a
clean separation between i2c and hwmon for the past few months. This
included a full rewrite of i2c-isa, and moving of all hardware
monitoring drivers from drivers/i2c/chips to drivers/hwmon, and a lot
of cleanups all around the place. Then we introduced the hwmon class,
which makes it possible for user-space to locate hardware monitoring
chips in sysfs regardless of their interface. This was supported by
libsensors in lm_sensors 2.9.2 for the first time.

The ultimate goal is to convert all non-I2C hardware monitoring drivers
to platform drivers. However, we need to wait for lm_sensors 2.9.2 and
later to be widely deployed before we modify the exiting drivers, as it
makes them incompatible with earlier releases of lm_sensors. For the
f71805f driver, it was new so compatibility wasn't an issue. All other
drivers, except the newly ported vt8231 driver, will have to wait at
least another 6 months before we can consider converting them. New
drivers or drivers being ported these days (e.g. vt1211) should be
implemented as platform drivers directly.

I hope I clarified the point :)

-- 
Jean Delvare

