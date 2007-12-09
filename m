From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 09 Dec 2007 00:05:54 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <20071209000554.GF20441@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071204215154.7f26285e.mikeserv@bmts.com>
In-Reply-To: <20071204215154.7f26285e.mikeserv@bmts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Houston <mikeserv@bmts.com>
Cc: linux-kernel@vger.kernel.org, mhoffman@lightlink.com, lm-sensors@lm-sensors.org

On Tue, Dec 04, 2007 at 09:51:54PM -0500, Mike Houston wrote:
> I finally got around to testing Linux 2.6.24 (2.6.24-rc4) and found
> that the it87 driver fails to probe and consequently, my sensors no
> longer work. This was fine with Linux 2.6.23.8 (the last kernel I was
> using)
> 
> The necessary modules load, but:
> 
> it87: Found IT8718F chip at 0x290, revision 2
> it87: in3 is VCC (+5V)
> it87 it87.656: Failed to request region 0x290-0x297
> it87: probe of it87.656 failed with error -16
> 
> Coretemp still works.
> 
> It appears it has something to do with the ioport range being
> reserved for some reason:
> 
> system 00:01: ioport range 0x290-0x29f has been reserved
> 
> At least I don't see that happening on previous kernels.
> 
> In any case, the changes to it87.c itself don't appear to have caused
> this. (CC'd hwmon maintainer anyways, my apologies if that was
> inappropriate)
> 
> dmesg:
> http://www.mikeserv.com/temp/dmesg-2.6.24-rc4.txt
> 
> config:
> http://www.mikeserv.com/temp/config-2.6.24-rc4.txt

Thanks for your report.

Please also provide:
- dmesg from 2.6.23.8
- The output of "cat /proc/ioports" for both kernels

> Thanks for any help or suggestions,
> 
> Mike Houston

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
