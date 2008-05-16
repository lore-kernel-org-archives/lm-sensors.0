From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 16 May 2008 22:20:36 +0000
Subject: Re: [lm-sensors] abituguru probe failure
Message-Id: <482E08B4.2090706@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805162307.28224.alistair@devzero.co.uk>
In-Reply-To: <200805162307.28224.alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alistair John Strachan wrote:
> Hi,
> 
> I have an IP35 Pro mainboard with the uGuru feature. Until recently I was
> using the abituguru hwmon driver without issue. Recently (possibly since
> upgrading the BIOS to 16) the driver no longer loads, citing:
> 
> abituguru3: no Abit uGuru3 found, data = 0x00, cmd = 0x55
> 
> After looking at the code in the driver, I found the force module parameter
> and tried it. Sure enough, the module loaded fine:
> 

<snip>

> A fix that works here is to add 0x55 as an additional cmd_val check in
> abituguru3_detect(), but I think we all know this function is starting to
> look a bit suspicious. I've attached a patch which does this (tested as
> working), but I won't be surprised if you guys don't want to apply it.
> 

Well I'm afraid that even though that makes the detection rather weak it is 
still the best thing todo, having to use force with a newer BIOS is no good.

I guess that to limit any potential issues we can best first do a DMI based 
check to see if this is an Abit motherboard at all before doing any IO based 
probing, just like we are already doing for the abituguru (note no 3) driver.

Alistair, can you send me the output of the dmidecode command on your 
motherboard, I need that to make sure Abit hasn't changed their DMi 
manufacturer string on newer motherboards.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
