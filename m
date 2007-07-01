From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 01 Jul 2007 17:26:39 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] use mutex instead of semaphore in SMSC
Message-Id: <20070701172639.GN3516@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701162529.GC3940@traven> <20070701163224.GF3940@traven>
In-Reply-To: <20070701163224.GF3940@traven>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>, khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Hi Matthias:

* Matthias Kaehlcke <matthias.kaehlcke@gmail.com> [2007-07-01 18:32:24 +0200]:
> The SMSC LPC47M192 driver uses a semaphore as mutex. Use the mutex API
> instead of the (binary) semaphore.
> 
> Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

Already in my testing tree[1] and therefore in latest -mm as well.

[1] http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=shortlog;h=testing

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
