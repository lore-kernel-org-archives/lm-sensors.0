From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 20 Sep 2006 16:30:45 +0000
Subject: [lm-sensors] Call for 2.10.1
Message-Id: <20060920183045.45e141b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060819105454.c6c438ed.khali@linux-fr.org>
In-Reply-To: <20060819105454.c6c438ed.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> I started working on the patch a couple of days ago and realized that
> the current sensors does have some issues with the new 2.6 driver.
> Since the temp mapping changed, the 'old' single alarms sysfs node now
> has some bits swapped. So alaram reporting is broken.

Oops, good catch. This basically means that we must have the same order
for the 2.4 and the 2.6 driver, at the very least.

Will you have the time to provide a patch "fixing" the 2.4 driver by
the end of the week?

(One more reason to keep adding individual alarm bits to all drivers...)

Thanks,
-- 
Jean Delvare

