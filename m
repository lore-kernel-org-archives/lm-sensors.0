From: tomaz.mertelj@guest.arnes.si
Date: Fri, 12 Jun 2009 18:16:03 +0000
Subject: [lm-sensors] =?UTF-8?Q?Re: [PATCH] hwmon: Add driver for VIA CPU
Message-Id: <20090612_181603_063915.tomaz.mertelj@guest.arnes.si>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090612_144621_045117.tomaz.mertelj@guest.arnes.si>
In-Reply-To: <20090612_144621_045117.tomaz.mertelj@guest.arnes.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Michael S. Zick" <lkml@morethan.org>, tomaz.mertelj@guest.arnes.si
Cc: Harald Welte <HaraldWelte@viatech.com>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

> On Fri June 12 2009, Michael S. Zick wrote:
> 
> And the output of sensors with H.W. driver built-in:
> 
> root@cb01:~# sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +48.8�C  (crit = +94.8�C)
> 
> via-cputemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +50.0�C
> 
> Which looks reasonable to me, on this machine.
> 
> Mike 

On VIA VB7002  acpitz  obviously does not work so I can not compare. I 
guess BIOS does not support the temperature reading since there is no 
temperature readout in BIOS. 

acpitz-virtual-0
Adapter: Virtual device
temp1:      -247.7 C  (crit = +140.0 C)

via-cputemp-isa-0000
Adapter: ISA adapter
Core 0:      +27.0 C

Is there a way to reset the CPU temperature calibration to the factory 
default?  

Tomaz Mertelj 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
