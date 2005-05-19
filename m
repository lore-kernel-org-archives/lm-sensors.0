From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH: 2.6.11-rc5] i2c chips: add adt7461 support to lm90
Message-Id: <20050303205935.59b14c69.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4223513F.4030403@katalix.com>
In-Reply-To: <4223513F.4030403@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> ADT7461 will only be supported in lm90-compat mode.

Sounds like the best solution to me too. We can still support the other
mode later if someone really needs it.

> > I would also appreciate a patch to lm_sensors' sensors-detect script
> > for the ADT7461, and possibly a patch for libsensors and sensors as
> > well, unless you are not interested in these (in which case you
> > would need to explicitely mention in Kconfig that the ADT7461 has no
> > user-space support at the moment).
> 
> Patch to add adt7461 support to lmsensors-2.9.0 is attached. I'm new
> to the internals of lmsensors so I may not have done all I need to.

Patch is good but incomplete. You'd need to also "add support" in
prog/sensors/main.c and etc/sensors.conf.eg. Please provide a new patch
that does everything or a diffenet patch for me to apply additionally to
this one.

Thanks,
-- 
Jean Delvare
