From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Dec 2014 21:57:22 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add code to detect TMP435
Message-Id: <20141204215722.GA30215@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110406072137.GB23562@ericsson.com>
In-Reply-To: <20110406072137.GB23562@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 04, 2014 at 11:14:59AM -0800, Guenter Roeck wrote:
> Also update driver support status for TMP431 and TMP432.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    |  1 +
>  prog/detect/sensors-detect | 18 +++++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
[ ... ]

> +		name => "Texas Instruments TMP435",
> +		driver => "tmp401",
> +		i2c_addrs => [0x4c],

I requested samples to figure out if 0x4c is really the only
supported address.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
