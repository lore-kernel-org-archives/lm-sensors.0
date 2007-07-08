From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jul 2007 17:52:45 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru-check-dmi-vendor.patch
Message-Id: <20070708175245.GE3591@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4690D52A.7040402@hhs.nl>
In-Reply-To: <4690D52A.7040402@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-07-08 14:14:34 +0200]:
> Hi all,
> 
> With this patch the abituguru refuses to load on non Abit motherboards, as
> discussed in lkml CONFIG_BREAK_MY_MACHINE thread.
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Regards,
> 
> Hans

> With this patch the abituguru refuses to load on non Abit motherboards, as 
> discussed in lkml CONFIG_BREAK_MY_MACHINE thread.
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

That thread worries me a bit.  Should this get in before 2.6.22?  I would
rather *not* try to get it in at this late hour, as it could potentially
cause regression for a lot of ABIT owners.  But if you think the alternative
is worse, then let me know ASAP and I'll send it.

For now, it's applied to testing (queued for the 2.6.23 merge window).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
