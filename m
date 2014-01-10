From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Jan 2014 08:10:27 +0000
Subject: Re: [lm-sensors] ASUS KGPE-D16 and CentOS 6.5
Message-Id: <20140110091027.280519d4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E4175F3D57744A468314267E51135306@W710>
In-Reply-To: <E4175F3D57744A468314267E51135306@W710>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Seth,

On Thu, 9 Jan 2014 15:24:05 -0700, Seth Bardash wrote:
> Jean,
> 
> That did it.
> 
> New i2c-piix4 driver plus w83795 driver and the previously
> mentioned addition to the /etc/sensors3.conf now has all the
> sensors working.

Great!

> The CPU sensors seem a bit low but the extra thermocouples
> included with the motherboard are reading right on.
> Now I will know if the machine has a fan failure or cooling is
> bad.

The AMDSI sensors (which are the same as what the k10temp driver
reports) are notoriously inaccurate in the low temperature ranges. As
long as the reading is way below the critical limit, you're safe and
the exact numbers are meaningless.

> Thanks very much for your help.
> If you want I can post exactly what was done so that CentOS 6.5
> support for the ASUS KGPE-D16 is documented.

You're welcome. I've added your configuration file to the wiki with a
link to this discussion thread so we should be all set now :)

http://www.lm-sensors.org/wiki/Configurations/Asus/KGPE-D16

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
