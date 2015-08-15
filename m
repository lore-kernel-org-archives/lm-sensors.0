From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 15 Aug 2015 15:13:02 +0000
Subject: Re: [lm-sensors] [RFC 0/1] i2c: acpi: revert setting a "stable" device name
Message-Id: <20150815151302.GA10020@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1439581034-5972-1-git-send-email-dustin@cumulusnetworks.com>
In-Reply-To: <1439581034-5972-1-git-send-email-dustin@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.nikula@linux.intel.com, jdelvare@suse.com, lm-sensors@lm-sensors.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org

On Fri, Aug 14, 2015 at 12:37:13PM -0700, Dustin Byford wrote:
> 70762ab from 11/2014 (i2c: Use stable dev_name for ACPI enumerated I2C
> slaves) modified the sysfs-visible dev_name() for ACPI enumerated I2C
> devices.  With that change, /sys/bus/i2c/devices/i2c-0-004a, for
> example, became /sys/bus/i2c/devices/i2c-PNPXXXX:xx
> 
> That causes problems for userspace code such as 'sensors' which does
> this:
> 
> lib/sysfs.c:665:
> if ((!subsys || !strcmp(subsys, "i2c")) &&
>     sscanf(dev_name, "%hd-%x", &entry.chip.bus.nr,
>            &entry.chip.addr) = 2) {
> ...
> 
> Therefore, in theory, sensors that were previously visible by running
> 'sensors' no longer show up.  On the other hand, there are probably few,
> if any, cases of this because ACPI enumerated I2C hwmon devices are not
> common.
> 
> I'm not defending the 'sensors' code, I'm sure there are better ways to
> discover a hwmon I2C device from userspace.  But, I'm also not sure

Is it necessary to defend user space applications nowadays if a kernel change
breaks a well established ABI ? WHat happened to "Thou Shalt Not Break
Userspace" ?

I absolutely agree that i2c bus renumbering across reboots is a problem.
However, it seems to me that 70762ab doesn't solve that problem, it just
paints it over. And, as you have noticed, it introduces new problems along
the way.

Guenter

> 70762ab achieved its stated goal in a meaningful way.  Won't
> "i2c-<acpi_dev_name>" also vary with ACPI scan order, BIOS settings,
> firmware upgrades, etc...?
> 
> Hence the RFC patch.  To submit a change like this I would need to
> consider the fallout for ALSA SoC.  The other option is to see what can
> be done in 'sensors' to include the ACPI enumerated hwmon devices.
> 
> Any opinions on which way to go?
> 
>    --Dustin
> 
> Dustin Byford (1):
>   i2c: acpi: revert setting a "stable" device name
> 
>  drivers/i2c/i2c-core.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> -- 
> 2.1.4
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
