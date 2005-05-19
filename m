From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <AM46Y3QI.1111570385.4530770.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Thinking about the fan_div setting, it is a read/modify/write
> (RMW) operation to a chip register, should we take action to
> prevent another process accessing the chip on i2c during this
> RMW action?

Can you (or anyone) point out a concrete example where the lack of
locking on write could cause a problem that locking would actually
resolve? It's better to know what we are trying to fix before we change
anything.

Thanks,
--
Jean Delvare
