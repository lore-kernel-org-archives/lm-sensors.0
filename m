From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 18 Jul 2007 21:50:45 +0000
Subject: Re: [lm-sensors] patches vs. 2.6.22 for release - last chance
Message-Id: <191fb4ca0707181450i62d77bb1n9d0ee2c3d577e68@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070718203038.GC3406@jupiter.solarsys.private>
In-Reply-To: <20070718203038.GC3406@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark,

Please consider including
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020495.html

It fixes a defect in the new dme1737 driver.

...juerg



On 7/18/07, Mark M. Hoffman <mhoffman@lightlink.com> wrote:
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
> Regards,
>
> --
> Mark M. Hoffman
> mhoffman@lightlink.com
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
