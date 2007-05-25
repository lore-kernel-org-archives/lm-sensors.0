From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 12:07:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/pc87360: Convert to a platform driver
Message-Id: <20070525140726.263ea353@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070521171943.420aa00b@hyperion.delvare>
In-Reply-To: <20070521171943.420aa00b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 24 May 2007 09:34:37 -0600, Jim Cromie wrote:
> Jean Delvare wrote:
> > I finally found some time to convert the pc87360 driver to a platform
> > driver. Jim (or anyone else with access to supported hardware), could
> > you please give it a try and confirm that it works OK?
> 
> yes it works!
> 
> these are with the conf in debian unstable -
> 
> soekris:~# uname -a
> Linux soekris 2.6.22-rc2-sk #2 Mon May 21 19:15:36 MDT 2007 i586 GNU/Linux
> soekris:~#
> soekris:~# sensors
> pc87366-isa-6620
> Adapter: ISA adapter
> in0:       +3.01 V  (min =  +0.00 V, max =  +3.01 V)      
> in1:       +2.01 V  (min =  +0.00 V, max =  +3.01 V)      
> in2:       +2.48 V  (min =  +0.00 V, max =  +3.01 V)      
> in3:       +0.66 V  (min =  +0.00 V, max =  +3.01 V)      
> in4:       +2.46 V  (min =  +0.00 V, max =  +3.01 V)      
> in5:       +2.49 V  (min =  +0.00 V, max =  +3.01 V)      
> in6:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)      
> Vsb:       +3.31 V  (min =  +0.00 V, max =  +6.03 V)      
> Vdd:       +2.98 V  (min =  +0.00 V, max =  +6.03 V)      
> Vbat:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)      
> AVdd:      +3.28 V  (min =  +0.00 V, max =  +6.03 V)      
> CPU0 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
> CPU0 Crit:  +127 C ALARM
> CPU1 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
> CPU1 Crit:  +127 C ALARM
> S-IO Temp:   +93 C  (low  =   -55 C, high =  +127 C) 
> S-IO Crit:  +127 C

Thanks for the report, Jim! Hopefully the output looks the same as
without my patch? Did you try unloading and reloading the driver too?

This patch is now in -mm.

> [ 1903.061714] hwmon-vid: requested unknown VRM version
> vid:      +0.000 V  (VRM Version 0.0)

Hmmm, we should probably fix this warning, too. Maybe your CPU doesn't
even have VID pins. Patch follows.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
