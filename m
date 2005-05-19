From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <D7qJgteK.1111594884.6953330.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Philip, all,

> It's obvious to me
> that the functions that *set* the values need to be protected to prevent
> an SMP machine from borking things up.  That's why I added the down/up
> calls in all of the write paths of the drivers I wrote.

It looks to me like locking is only needed when we R/U/WB a register
which has more than one "function", like is the case for fan clock
dividers for the ADM1026. In the case a given register has only one
function of interest to our driver, is there still a benefit in using
the lock? Concrete example anyone?

Thanks,
--
Jean Delvare
