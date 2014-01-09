From: "Seth Bardash" <seth@integratedsolutions.org>
Date: Thu, 09 Jan 2014 22:24:05 +0000
Subject: Re: [lm-sensors] ASUS KGPE-D16 and CentOS 6.5
Message-Id: <C399EB9A0E184571ADB9A53D243EBFDC@W710>
List-Id: <lm-sensors.vger.kernel.org>
References: <E4175F3D57744A468314267E51135306@W710>
In-Reply-To: <E4175F3D57744A468314267E51135306@W710>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

That did it.

New i2c-piix4 driver plus w83795 driver and the previously
mentioned addition to the /etc/sensors3.conf now has all the
sensors working.

The CPU sensors seem a bit low but the extra thermocouples
included with the motherboard are reading right on.
Now I will know if the machine has a fan failure or cooling is
bad.

Thanks very much for your help.
If you want I can post exactly what was done so that CentOS 6.5
support for the ASUS KGPE-D16 is documented.

Best Regards,

Seth Bardash

Integrated Solutions and Systems
1510 Old North Gate Road
Colorado Springs, CO 80921

719-495-5866 Shop
719-495-5870 Fax
719-337-4779 Cell

http://www.integratedsolutions.org

Failure can not cope with knowledge and perseverance! 
-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Thursday, January 09, 2014 5:14 AM
To: seth@integratedsolutions.org
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] ASUS KGPE-D16 and CentOS 6.5

On Thu, 9 Jan 2014 09:02:32 +0100, Jean Delvare wrote:
> Hi Seth,
> 
> On Wed, 8 Jan 2014 16:35:12 -0700, Seth Bardash wrote:
> > (...)
> > The CentOS based machine uses a much older kernel and
libsensors
> > code.
> > 
> > (opensuse) 3.7.10-1.16-desktop versus (CentOS)
> > 2.6.32-431.el6.x86_64
> > 
> > I downloaded the w83795 code and compiled it.
> > The loaded it with:
> > 
> > rmmod w83795
> > modprobe hwmon
> > modprobe hwmon-vid
> > modprobe i2c-core
> > insmod ./w83795.ko 
> > 
> > But get an error of no hwmon found.
> > I even ran modprobe i2c-piix4 first then ran the commands
above
> > but
> > there is no entry in dmesg and sensors -s then sensors does
not
> > show anything.
> 
> Odds are that you need an updated i2c-piix4 driver too. Check
the PCI
> ID of the SMBus controller (you can check which device got the
> i2c-piix4 driver attached on your openSUSE 13.1 system.)

Such an updated driver is now available for download from:

http://khali.linux-fr.org/devel/lm-sensors/drivers/i2c-piix4/

Hope it helps,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
