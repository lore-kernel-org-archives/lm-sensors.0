From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 10 Jun 2005 03:33:16 +0000
Subject: [lm-sensors] Re: More archs need to include hwmon/Kconfig
Message-Id: <20050610013239.GA23717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050609185703.78784b2f.khali@linux-fr.org>
In-Reply-To: <20050609185703.78784b2f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Jean, ...:

* Greg KH <greg@kroah.com> [2005-06-09 10:00:45 -0700]:
> Hm, this is getting quite messy.

It was just my subtle way of getting the error paths tested... ;)

> Mark, how about I just drop the hwmon patches from my tree right now,
> until you respin them, fixing these issues up?

Fair enough, though, I'm not sure on what tree to base my next set of
patches.  I guess: 2.6.12-rc6-mm1 *minus* the three hwmon patches.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

