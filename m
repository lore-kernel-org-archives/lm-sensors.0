From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 28 Dec 2005 22:28:19 +0000
Subject: [lm-sensors] [PATCH] X1205 cleanup
Message-Id: <20051228232819.545163e8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051213214058.2781e657@inspiron>
In-Reply-To: <20051213214058.2781e657@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alessandro,

> > What is the point of your cleanup? As I understand it, the driver is no
> > more exporting any functionality to the rest of the kernel. As it has no
> > user-space interface either, this means that the only thing the driver
> > is useful for is running x1205_hctosys at runtime - and even this only
> > happens if the module parameter hctosys has been set, which isn't the
> > default.
> 
> This cleanup was in preparation for the new rtc subsystem I'm writing,
> so I thought it was better to leave those functions there.

In that case, you are doing things in the wrong order. You should first
introduce your new RTC subsystem (which I think is a good idea,
although I lack time to actually look into your implementation), then
convert your driver directly to use it. Having an intermediate state
where your driver is mostly useless doesn't make much sense.

Thanks,
-- 
Jean Delvare

