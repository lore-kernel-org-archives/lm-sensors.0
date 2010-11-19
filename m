From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 19 Nov 2010 18:10:59 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lis3lv02d_i2c) Fix compile
Message-Id: <20101119181059.GA9559@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101119145510.1c59d6c4@endymion.delvare>
In-Reply-To: <20101119145510.1c59d6c4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 19, 2010 at 10:49:29AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 19 Nov 2010 06:59:53 -0800, Guenter Roeck wrote:
> > This commit fixes the following compile warnings.
> > 
> > From v2.6.37-rc2/m68k/m68k-allmodconfig, v2.6.37-rc2/powerpc/powerpc-randconfig:
> > drivers/hwmon/lis3lv02d_i2c.c:222: warning: 'lis3_i2c_runtime_suspend' defined but not used
> > drivers/hwmon/lis3lv02d_i2c.c:231: warning: 'lis3_i2c_runtime_resume' defined but not used
> 
> Your patch definitely fixes that one.
> 
> > 
> > From v2.6.37-rc2/sh4/sh-allyesconfig:
> > drivers/hwmon/lis3lv02d_i2c.c:191: warning: 'lis3lv02d_i2c_suspend' defined but not used
> > drivers/hwmon/lis3lv02d_i2c.c:201: warning: 'lis3lv02d_i2c_resume' defined but not used
> 
> But that one? I doubt it. If CONFIG_PM is set but CONFIG_PM_SLEEP
> isn't, it's still present. I don't think it can happen on x86, but
> apparently on sh4 it can.
> 
It can happen on x86 as well. You have to disable hibernation, suspend, and xen support.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
