From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Oct 2012 15:35:28 +0000
Subject: Re: [lm-sensors] [Patch v4 5/7] HWMON: DA9055 HWMON driver
Message-Id: <20121008153528.GA3629@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349702807.17349.8.camel@dhruva>
In-Reply-To: <1349702807.17349.8.camel@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 08, 2012 at 06:56:47PM +0530, Ashish Jangam wrote:
> This is the HWMON patch for DA9055 PMIC and has got dependency on the
> DA9055 MFD core.
> 
> This patch monitors the DA9055 PMIC's ADC channels vddout, junction temperature
> and auxiliary channels.
> 
> This patch is functionally tested on Samsung SMDKV6410.
> 
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume this will be pushed upstream together with the aother patches in the
series.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
