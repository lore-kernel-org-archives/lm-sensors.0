From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: Works with K7S5A
Message-Id: <20040228180134.38701ba5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1077974373.1114.4.camel@garrett.darkzone>
In-Reply-To: <1077974373.1114.4.camel@garrett.darkzone>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I just want to tell you that today's CVS of lm_sensors2 works fine
> with kernel 2.6.3, Elitegroup K7S5A Mainboard (it87 Sensor with
> temp_type=0x31) on Debian sid.

Great :)

You may be interested in Takeru Komoriya's patches to the it87 driver:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.3-i2c-it87-1-sensor-type.diff
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.3-i2c-it87-2-reset.diff

The first one moves the sensor type selection from module loading to
user-space (i.e. controled by /etc/sensors.conf and sensors -s), much
like for the w83781d driver. If you are using temp_type=0x31 for now,
you'll want lines like:

    set sensor1 3
    set sensor2 2
    set sensor3 2

in the it87-* section of your configuration file.

The second one makes the it87 reset and reconfiguration optional.

These two patches (and possibly a few others) will be part of Linux
2.6.4, so let us know if you have problems with them.

> Keep up the good work :-)

We'll do our best is that sense :)

> BTW: is there an updated Xsensors package available? Or even better: a
> Gnome 2.4 Panel applet?

Xsensors 0.40 did work rather well for me, except that it lacks support
for many chipset types. Since it works with libsensors, xsensors will
work on every system where sensors works (providing the specific chip is
also supported).

Other projects you might be interested in:
http://www.coverfire.com/sensor_sweep_applet/
http://www.it.unikol.com.pl/~adolf/gnosens.html
http://web.wt.net/~billw/gkrellm/gkrellm.html

I haven't checked them myself. Note that if these apps do not rely on
libsensors, you can bet they won't work correctly with Linux 2.6
kernels, at least until the new sysfs is defined.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
