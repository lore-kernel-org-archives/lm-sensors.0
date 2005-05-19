From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <20050131182542.GB21438@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41F6F1D5.90601@mvista.com>
In-Reply-To: <41F6F1D5.90601@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: phil@netroedge.com, sensors@stimpy.netroedge.com, lkml <linux-kernel@vger.kernel.org>

On Tue, Jan 25, 2005 at 06:26:45PM -0700, Mark A. Greer wrote:
> +static inline void
> +mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)

This is a much too big of a function to be "inline".  Please change it.
Same for your other inline functions, that's not really needed, right?

> +{
> +	pr_debug("mv64xxx_i2c_fsm: ENTER--state: %d, status: 0x%x\n",
> +		drv_data->state, status);

Please use the dev_* calls instead.  It gives you an accurate
description of the specific device that emits the messages.  Also use it
for all of the printk() calls in the driver too.

thanks,

greg k-h
