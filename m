From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Aug 2006 07:10:45 +0000
Subject: [lm-sensors] [PATCH] AMD K8 digital sensor
Message-Id: <20060823091045.170439cf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C69648.9060808@sh.cvut.cz>
In-Reply-To: <44C69648.9060808@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >> diff -uprN linux-2.6.18-rc2/drivers/hwmon/k8temp.c linux-2.6.18-rc2-patched/drivers/hwmon/k8temp.c
> >> --- linux-2.6.18-rc2/drivers/hwmon/k8temp.c	1970-01-01 01:00:00.000000000 +0100
> >> +++ linux-2.6.18-rc2-patched/drivers/hwmon/k8temp.c	2006-07-25 23:45:00.274085500 +0200
> >> @@ -0,0 +1,278 @@
> >> +/*
> >> + * k8temp.c - Part of lm_sensors, Linux kernel modules for hardware
> >> + *               monitoring
> > 
> > No, this is part of the Linux kernel.
> 
> Well this was cut & paste maybe we should change it?

This makes some sense for drivers which were ported from the lm_sensors
project, so I don't mind leaving it for these. But we shouldn't include
that sentence in new drivers.

> Many thanks too. It is funny that even if I tried hard not to screw stuff in the 
> driver there is always something.

Heh, no worry. That's the whole point of reviewing patches, and also
the reason why I would like my own patches to get some review too.

Thanks,
-- 
Jean Delvare

