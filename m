From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 09:33:11 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS75 thermal sensor
Message-Id: <20080716113311.384d211e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <487331DC.2020601@grandegger.com>
	<20080708115319.111226e6@hyperion.delvare>
	<4873670C.6080204@grandegger.com>
	<20080708152935.7457bc90@hyperion.delvare>
	<487754DA.1060207@grandegger.com>
	<20080711145613.14380360@hyperion.delvare>
	<487DBB92.1070100@grandegger.com>
In-Reply-To: <487DBB92.1070100@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org, Alan Clucas <alanc@pipstechnology.co.uk>, Detlev Zundel <dzu@denx.de>, lm-sensors@lm-sensors.org

Hi Wolfgang,

On Wed, 16 Jul 2008 11:12:50 +0200, Wolfgang Grandegger wrote:
> Jean Delvare wrote:
> > For hwmon chips, probing only occurs if the i2c adapter accepts to be
> > probed, by setting the I2C_CLASS_HWMON flag in i2c_adapter.class. If
> > you do not want a given i2c bus to be probed, then do not set the flag
> > for that bus.
> 
> I see. My problem is that I2C_CLASS_HWMON is set in the I2C bus driver 
> for the MPC:
> 
>    http://lxr.linux.no/linux+v2.6.26/drivers/i2c/busses/i2c-mpc.c#L314
> 
> If I disable it, the LM75 driver only probes the addresses of the I2C 
> nodes defined in the FDT DTS file. I wonder if this should not be the 
> default behaviour for kernels using OF platform description. For this 
> reason, I have put Linuxppc-dev ML on CC. I also realized, that there 
> are some patches for OF I2C pending. I will check.

The problem is that at this point in time, only a couple hwmon drivers
have been converted to new-style i2c. So, dropping the I2C_CLASS_HWMON
would break most systems.

I have a set of patches converting most hwmon drivers to new-style i2c.
I plan to send it to Linus later today. Once all drivers are converted,
everyone can start adding device definitions to platform code. And only
once this is done for all platforms, you may remove I2C_CLASS_HWMON
from the i2c-mpc driver.

But even then, you can't exclude the possibility that some people want
to keep relying on the auto-detection mode. In that case, the setting
of the I2C_CLASS_HWMON flag should become an attribute of eacg i2c-mpc
device.

Anyway, this is something for every platform community to decide and
work on. As the i2c subsystem maintainer, I made my best so that
everything (sensible) is possible. But in the end it's up to the
"users" (i.e. platform developers and maintainers) to make the decision
of how things should work in their area. I can give advice on migration
paths, but I can't take decisions for them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
