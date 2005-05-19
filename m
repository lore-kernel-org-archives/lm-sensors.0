From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: lm_sensors (missing modules)
Message-Id: <1073900099.40026a430936c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401120909.i0C99HQ00763@mailgate5.cinetic.de>
In-Reply-To: <200401120909.i0C99HQ00763@mailgate5.cinetic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting hpfaasen@compuserve.de:

> after some datalosses, caused by overheated components, I searched
> for a monitoring-tool and found lm_sensors. The installation went
> fine, eccept one:
> sensors-detect found a sensor on my graphic-accellerator (gForce
> 2MX), but it could not load the module, cause it?s not in the
> package. So I tried to get it from the given downlaud-page
> (http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml), but that
> didn't work, because I had no permission for accessing.
> Would you please show me another way to get the module and could you
> give me some tips, how to install it?

http://rivatv.sourceforge.net/

Frankly, you didn't even try searching the web for it? A search on
"rivatv" with google returns the link above in first position.

The URL has been fixed in our package some times ago already.

> (I need it, because some problems on the display seem to be caused by
> an overheated graphicchip and I would like to verify this before I
> start with hardware-changes like build-in a fan or change the case.)
> Wouldn't it be so much easier to integrat it into the package?

The RivaTV project is something completely different. As its name says,
it aims at supporting video in and out on Riva (and later) based video
boards. It happens that the video stuff is on the same bus as hardware
monitoring stuff, so their driver can be used in LM Sensors. Still this
wouldn't make any sense to duplicate their code in our project, this is
why we point the user to the RivaTV project instead.

Same applies to Matrox users (driver is included in the kernel tree
itself), because the i2c bus driver for these cards is included in the
framebuffer driver. That's not something we can change. The only video
adapters drivers we have inside our project are the ones that only
handle the I2C bus (Voodoo3, Savage4).

> Thanks for your help and the great job you`ve already done!

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
