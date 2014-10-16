From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 16 Oct 2014 18:35:01 +0000
Subject: Re: [lm-sensors] [PATCH v6 3/4] pmbus: add regulator support
Message-Id: <20141016183501.GA21253@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1413399310-19277-1-git-send-email-atull@opensource.altera.com>
 <1413399310-19277-4-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1413399310-19277-4-git-send-email-atull@opensource.altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: atull@opensource.altera.com
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On Wed, Oct 15, 2014 at 01:55:09PM -0500, atull@opensource.altera.com wrote:
> From: Alan Tull <atull@opensource.altera.com>
> 
> Add support for simple on/off control of each channel.
> 
> To add regulator support, the pmbus part driver needs to add
> regulator_desc information and number of regulators to its
> pmbus_driver_info struct.
> 
> regulator_desc can be declared using default macro for a
> regulator (PMBUS_REGULATOR) that is in pmbus.h
> 
> The regulator_init_data can be initialized from either
> platform data or the device tree.
> 
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>

Hi Alan,

I am still seeing lots of the following:

vout0: Failed to create debugfs directory
vout1: Failed to create debugfs directory
vout2: Failed to create debugfs directory
vout3: Failed to create debugfs directory
vout4: Failed to create debugfs directory
vout5: Failed to create debugfs directory
vout6: Failed to create debugfs directory
vout7: Failed to create debugfs directory

I thought there was a problem in the regulator core, but after looking
into it concluded that the regulator core _should_ prepend the names
with the device name when creating the debugfs entries, unless no device
name is specified. So something must be missing. We'll need to sort
this out before I can accept the code.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
