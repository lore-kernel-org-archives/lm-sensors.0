From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 19 Jul 2007 14:04:00 +0000
Subject: Re: [lm-sensors] patches vs. 2.6.22 for release - last chance
Message-Id: <469F6F50.6090607@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070718203038.GC3406@jupiter.solarsys.private>
In-Reply-To: <20070718203038.GC3406@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi all:
> 
> I'm back from my vacation, and of course the email has piled up.
> 
> Linus released 2.6.22 so I've updated my testing and release trees; they are
> now identical:
> 
> http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=shortlog;h=release
> 
> Unless I hear good reasons, I'll ask Linus to pull from this tomorrow.
> 
> Also, I realize there's still a backlog of patches.  In the past, Linus has
> not objected to merging brand new drivers in addition to bugfixes after -rc1,
> so I think there is still the chance to get some of these in if we can work
> quickly.  Unfortunately, the alarm file patches qualify as neither of these,
> so they'll have to wait until the next round.
> 

Mark,

If possible I would like to see the fintek f71882fg driver included into 
2.6.23, it has been reviewed and I've posted a second version with all issues 
raised during the review fixed (unfortunately there has been no ack on the 
ammended version though).

Its available here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020441.html

Also I've reviewed and acked the adt7470 driver posted here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020429.html

If you pick this up, also please include these 2 bugfixes to it:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020487.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020490.html

Since I haven't done that yet, I hereby ack these 2 bugfixes:
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Thanks & Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
