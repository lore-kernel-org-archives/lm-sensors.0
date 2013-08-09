From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Date: Fri, 09 Aug 2013 10:50:11 +0000
Subject: Re: [lm-sensors] =?utf-8?q?Proposal=3A_I2C_device_power_=28Was=3A_hwm?=
Message-Id: <1376045411.585130456@f141.i.mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1376027820.695103970@f416.i.mail.ru>
 <20130809102757.GT6427@sirena.org.uk>
In-Reply-To: <20130809102757.GT6427@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>
Cc: =?UTF-8?B?V2VpIE5p?= <wni@nvidia.com>, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, MLongnecker@nvidia.com, =?UTF-8?B?R3VlbnRlciBSb2Vjaw==?= <linux@roeck-us.net>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> On Fri, Aug 09, 2013 at 09:57:00AM +0400, Alexander Shiyan wrote:
> 
> > Instead of adding the support of regulators in each device, let's think about
> > whether it is possible to create a global regulator for any device on the I2C bus.
> 
> > I see it like this:
> > We add an extra field in the i2c_board_info structure "power_name" and handle
> > it in the i2c_device_{probe/remove} functions.
> 
> This would need to be an array of supplies, relatively few devices need
> only a single power supply.  This is also not something that should be
> handled in I2C, power is not something that's uniquely needed by devices
> on an I2C bus.

Additional regulators can be handled in the driver, or "parent"-scheme can
be used. Is not it?

---
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
