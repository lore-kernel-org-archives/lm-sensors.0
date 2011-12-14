From: undersys <undersys@basstech.net>
Date: Wed, 14 Dec 2011 23:32:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix oops on driver load
Message-Id: <f1dfc989-fa3c-4348-abe9-e2dc67b7f66f@basstech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111201110047.130190a5@endymion.delvare>
In-Reply-To: <20111201110047.130190a5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



----- Original Message -----
From: "Jean Delvare" <khali@linux-fr.org>
To: undersys@basstech.net
Cc: lm-sensors@lm-sensors.org, "Durgadoss R" <Durgadoss.r@intel.com>, "guenter roeck" <guenter.roeck@ericsson.com>
Sent: Sunday, 11 December, 2011 8:49:50 PM
Subject: Re: [PATCH] hwmon: (coretemp) Fix oops on driver load

On Tue, 06 Dec 2011 19:50:04 +0800 (HKT), undersys wrote:
> I would like to see the contents of /proc/cpuinfo.
> 
> undersys -> attached

I can only confirm that this is one of the series where the microcode
needs to be recent enough. No surprise here.

> > Micro code was working on 2.6.29 and 2.6.39 , then I jumped to 3.0.6.
> 
> I admit I don't quite get it for now. While the device probing logic
> was modified a lot in the coretemp driver of kernel 3.0, the microcode
> check did not change, so I just don't get why the new driver would
> behave differently from the previous ones in this respect.
> 
> For testing purposes, I made the 2.6.39 version of the coretemp driver
> available as a standalone driver:
> http://khali.linux-fr.org/devel/misc/coretemp_old/
> (Instructions at http://khali.linux-fr.org/devel/misc/INSTALL )
> 
> I would like you to test it on your 3.0 kernel and report whether it is
> working or not. You'll have to rmmod the original coretemp driver
> before loading coretemp_old, you can't have both loaded at once.
> 
> If coretemp_old works, then please rmmod it and modprobe coretemp
> again, and see if it then works.
> 
> undersys ->
> 
> I built your module(coretemp_old), works fine no kernel opps.
> The only lines printed to "dmesg" are :-
> [  133.603204] coretemp coretemp.0: Errata AE18 not fixed, update BIOS or microcode of the CPU!
> [  133.603277] coretemp coretemp.1: Errata AE18 not fixed, update BIOS or microcode of the CPU!
> [  133.603329] coretemp coretemp.2: Errata AE18 not fixed, update BIOS or microcode of the CPU!
> [  133.603379] coretemp coretemp.3: Errata AE18 not fixed, update BIOS or microcode of the CPU!
> 
> If i remove it and then attempt to re-probe the new one, the new one fails.

I'm giving up on this one. I tried reproducing on one of my systems by
simulating a wrong microcode version. I obtain the same behavior for
the 2.6.32, 2.6.39 and (fixed) 3.0 versions of the coretemp driver:
error message in the log, driver loads without crashing, and "sensors"
show no coretemp device. So this is all as expected and I don't see any
regression here, thus there is nothing for me to fix.

-- 
Jean Delvare

Hi Jean,

No worries. Thanks for your time spent ! For now I will go back to getting the data from the IPMI card.
It would be nice if this Xeon was oneday supported but hey :)

Thanks


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
