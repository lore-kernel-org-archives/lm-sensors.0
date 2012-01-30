From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 30 Jan 2012 21:08:10 +0000
Subject: Re: [lm-sensors] pwmconfig and fancontrol don't work in ubuntu 10.11 archlinux kernel 3.2
Message-Id: <1327957690.2261.41.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F27026A.4080904@gmail.com>
In-Reply-To: <4F27026A.4080904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-01-30 at 15:49 -0500, David Kremer wrote:
> Hello.
> 
> I want to expose a problem I have met with pwmconfig.
> 
> With ubuntu 10.11, the pwmconfig complains there is no
> available system for monitoring the cpu fan.
> 
> With the last kernel in Archlinux, I have the same problem.
> With the LTS kernel in archlinux (3.0), the problem
> disappears, everything works fine.
> 
> I cannot understand why with the 3.0 kernel, I have a bug in ubuntu
> and not in archlinux (because the API should not to be broken).
> 
> In archlinux it is the two following versions :
> 
> local/linux-lts 3.0.17-2
> local/linux 3.2.2-1 (base)
> 
> In ubuntu 10.11, the kernel is :
>   3.0.0-15-generic-pae #26-Ubuntu SMP Fri Jan 20 17:07:31 UTC 2012 i686 
> i686 i386 GNU/Linux
> 
> When it fails, it seems that the coretemp interface is loaded, and I can 
> see the cpu temp
> in both cases (when fancontrol fails and when it doesn't fail), but only 
> the cpu temp.
> 
> When it doesn't fail, I have another interface which manage all the 
> sensors of my motherboard,
> including the control of fans (I can have up to 4 fans controlled). I am 
> going to be a bit
> approximative, but the interface being loaded when it works is called 
> "netxxxx" where the "xxxx"
> is some number. I could tell you more about this point the next time I 
> boot the archlinux LTS kernel.
> 
> My motherboard is H67 chipset :
> 
> http://www.asus.com/Motherboards/Intel_Socket_1155/P8H67M_LE/
> 
> I hope this helps to solve my problem
> 
There is a bug in the upstream driver affecting the number of fans
detected for NCT6776F. You can try a possible fix by loading and
installing the driver from
https://github.com/groeck/w83627ehf/archives/testing.

No idea if that helps, though. The bug has always been there, so I have
no explanation why it might have worked with archlinux 3.0 LTS.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
