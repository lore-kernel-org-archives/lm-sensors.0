From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Mon, 20 Oct 2008 16:24:17 +0000
Subject: Re: [lm-sensors] abituguru3: Please send .. to the abituguru3 (see
Message-Id: <200810201724.17975.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0810191251550.19058@p34.internal.lan>
In-Reply-To: <alpine.DEB.1.10.0810191251550.19058@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Justin,

On Monday 20 October 2008 16:10:51 Justin Piszcz wrote:
[snip]
> Reboot, dmesg:
>
> [   10.247075] abituguru3: found Abit uGuru3, motherboard ID: 0016
>
> Success.. and the sensors continue to work, btw the colon is off in one of
> the sensors (display artifact), not related to this patch/etc, just FYI:
[snip]

Thanks for testing, and reporting back.

Thanks also for noticing this small cosmetic artifact. When I looked into this 
in more detail, I found many similar errors across other supported board 
sensors. I've fixed them all up, together with the cosmetic issue in the 
original "see MAINTAINERS" message, and I'll send this patch along shortly.

> There should be another fan running as well, will have to check that
> later, but the rest of the sensors look normal.

We had a report just recently of an unreported fan on a different mainboard. 
It's entirely possible that the driver erroneously ignores it. When you next 
get a chance, please verify that the machine's UGURU BIOS section can see the 
fan and read its speed. If it can, we'll get the driver to export this fan.

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
