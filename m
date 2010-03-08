From: Phillip Pi <ant@zimage.com>
Date: Mon, 08 Mar 2010 21:39:19 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <20100308213919.GZ22889@alpha.zimage.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >> >> I am scared to use the lax method since it is not recommended. Is there
> >> >> another way to show the datas safely? Or do I have to use this trick or
> >> >> live without them?
> >> >
> >> > Asus provides an ACPI interface for accessing the sensors in a safe
> >> > way; I don't know what it's used on MSI boards, but I can take a look:
> >> > please send me a dump of the DSDT table
> >>
> >> Nothing interesting in the DSDT; the hwmon chip is used only for
> >> reading a temperature (TZ).
> >> I think you can use "acpi_enforce_resources=lax", there not other ways
> >> to access the sensor data.
> >
> > If you do, please make sure to blacklist the ACPI "thermal" driver.
> 
> Hum, I'd rather live with the race condition. The thermal driver is
> also responsible for controlling the cooling state.
> Would it be totally horrible to use acpi_ex_{enter,exit}_interpreter
> inside hwmon code to serialize execution?

Another thing. Is this going to be harmful if I enable AMD's
Cool'n'Quiet in its CMOS and use PowerNow-k8 module? I used to use it in 
the past, but currently disabled for testingn purposes.

modprobe powernow-k8
echo ondemand >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1 >/sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice_load
-- 
Quote of the Week: "This isn't a war. It never was a war, any more than
there's war between man and ants." --artilleryman from H.G. Wells' The
War of the Worlds
  /\___/\
 / /\ /\ \         Phil./Ant @ http://antfarm.ma.cx (Personal Web Site)
| |o   o| |                Ant's Quality Foraged Links: http://aqfl.net
   \ _ /                 E-mail: philpi@earthlink.net or ant@zimage.com
    ( )

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
