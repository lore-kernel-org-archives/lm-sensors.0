From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jul 2007 18:37:00 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru-check-dmi-vendor.patch
Message-Id: <20070709203700.270ecfd4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4690D52A.7040402@hhs.nl>
In-Reply-To: <4690D52A.7040402@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Mark,

On Sun, 08 Jul 2007 20:06:10 +0200, Hans de Goede wrote:
> No 2.6.23 is fine. No worries, they should have named the thread 
> CONFIG_SHOOT_MYSELF_IN_THE_FOOT.

Agreed.

>                                   This patch is just a layer of security to 
> prevent people doing stupid things. I only wrote the patch because some people 
> thought it would be a good idea to prevent people from doing stupid things with 
> regards to medling with the kernel, however when you enter into that realm 
> there is really no end of stupid things one can do, so I wonder how wise it is 
> to try and protect people against themselves.

I don't consider loading a kernel driver to be a "stupid thing". And
even if you think it is, well, people sometimes do that. I can remember
several posts to the lm-sensors list in the past few years, starting
with "I tried to load all the drivers, but without success." Given that
the abituguru accesses I/O ports without requesting them, and has a
relatively weak detection, I believe it is fair to make sure it won't
load on boards where it has no chance to be useful.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
