From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
Date: Tue, 15 May 2012 13:29:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Generic ADC support for hwmon
Message-Id: <20120515132919.GA11693@jake.ruivo.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1337092008-31263-1-git-send-email-jenny.tc@intel.com>
In-Reply-To: <1337092008-31263-1-git-send-email-jenny.tc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jenny TC <jenny.tc@intel.com>
Cc: khali@linux-fr.org, guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Jenny,
On Tue, May 15, 2012 at 07:56:48PM +0530, Jenny TC wrote:
> --- /dev/null
> +++ b/drivers/hwmon/hwmon-adc.c
> @@ -0,0 +1,212 @@
> +/*
> + *  hwmon-adc.c - Generic adc support for hardware monitoring  subsystem.
> + *
> + *  Copyright (C) 2012 Intel Corp
> + *
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + * Author : Jenny TC <jenny.tc@intel.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-adc.h>
> +
> +LIST_HEAD(adc_lst);
> +DEFINE_MUTEX(list_lock);
need static here?

> +struct device *hwmon_adc_device_register(struct device *dev,
> +					 struct hwmon_adc_ops *adc_ops)
> +{
> +	struct hwmon_adc *adc_node;
> +	struct device *hwdev;
> +
> +	hwdev = hwmon_device_register(dev);
> +	if (IS_ERR(hwdev))
> +		return hwdev;
> +
> +	adc_node = kzalloc(sizeof(struct hwmon_adc), GFP_ATOMIC);
why are you using GFP_ATOMIC here? and you need to handle the case when the
allocation fails

-- 
Aristeu


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
