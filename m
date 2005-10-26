From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 22:46:31 +0000
Subject: [lm-sensors]
Message-Id: <20051026224609.23e5f9e6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mauro,

> Please don't send this patch to Andrew or mainstream. I'll apply it on
> my tree and I will send it at the end my patchset series, for not
> breaking these.

Fine with me, as long as it ultimately gets done.

My motivation for this cleanup is that I plan to work soon on a new way
for drivers to instantiate i2c "clients". This new way will most
certainly require i2c IDs, so I need to have an accurate view of how
these are currently used. Having them centralized, as they were
supposed to be in the first place, should make my analysis easier, and
should reduce the risk to get things wrong.

Note that the new client instantiation method should suit the
media/video drivers needs much better than the old "general probing"
way did (which, with the RTC drivers, is actually the reason why I want
to implement this). I'll make sure to CC you and the v4l list on my
proposal to get your feedback.

> I have several patches that are including newer IDs on
> linux/media/i2c-id.h and I'm just preparing a patch, on V4L tree, to
> remove this file from kernel.

I guess we must read this as: adding news IDs to linux/i2c-id.h, and
removing the media/id.h file?

> If this is applied, it may break dozens of patches I've already
> prepared (at
> http://www.linuxtv.org/download/video4linux/patches/2.6.14-rc5)
> 
> Maybe it would be wiser if patches that touches drivers/media devices
> maintained on V4L go first to me, and I send to Andrew. This way, it
> would help us not to redo an entire patchset for fixing broken stuff
> because they would be included on a wrong order.

I did send this patch to you and the v4l list two days ago, stating
that I would send it to Greg quickly. I did not get any answer, so I
did. When a patch of mine gets in your way, just say so and I'll delay
it or leave it to you altogether.

I try to CC you an all i2c patches that affect media/video drivers, but
not all of these can go through your path to Andrew rather than mine.
Changes to these drivers which are needed because of a change to
i2c-core or the core i2c structures must obviously be done all at once,
so I have to handle them. Two such changes are in the works right now,
the second being Laurent Riffard's .owner and .name cleanup patchset.
Relevant patches have been sent to the v4l list already.

Thanks,
-- 
Jean Delvare
