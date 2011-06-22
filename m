From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 22 Jun 2011 02:50:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (zl6100) Add new chip support
Message-Id: <20110622025016.GA20421@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308707361-15558-1-git-send-email-b29983@freescale.com>
In-Reply-To: <1308707361-15558-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 21, 2011 at 09:49:21PM -0400, b29983@freescale.com wrote:
> From: Tang Yuantian <B29983@freescale.com>
> 
>         The ZL6100 is a digital power controller with Power Monitoring support.
>         It provides an I2C/SMBus digital interface that enables the user to
>         configure all aspects of the device operation as well as monitor the
>         input and output parameters. It accepts most standard PMBus commands.
>         Four parameters are output here which are Output Current, Output Voltage,
>         Local Temperature and Remote Temperature.
> 
>         This chip is currently used on some PowerPC platform.
> 
> Signed-off-by: Tang Yuantian <b29983@freescale.com>

Hi,

Did you try the generic pmbus driver ? Any reason why you did not use
the pmbus framework ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
