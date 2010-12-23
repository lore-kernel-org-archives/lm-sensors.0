From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 23 Dec 2010 19:55:20 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS620
Message-Id: <20101223195520.GA29280@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D0FB795.3010006@antcom.de>
In-Reply-To: <4D0FB795.3010006@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 20, 2010 at 03:07:49PM -0500, Roland Stigge wrote:
> Hi,
> 
> I'm attaching a patch with support for the temperature sensor DS620
> (ds620.c). It is based on ds1621.c but the device is sufficiently
> different to warrant a separate driver. E.g., configuration registers is
> different and includes 16bit values instead of 8bit.
> 
> Thanks for considering.
> 
> bye,
>   Roland

Please run your patch through scripts/checkpatch.pl and ensure it reports
no errors or warnings. Also please provide Documentation/hwmon/ds620.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
