From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 30 Jun 2011 14:22:19 +0000
Subject: Re: [lm-sensors] [PATCH 6/11] HWMON: DA9052 hwmon driver v2
Message-Id: <20110630142219.GA13161@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309439728.4656.0.camel@L-0532.kpit.com>
In-Reply-To: <1309439728.4656.0.camel@L-0532.kpit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ashishj3 <ashish.jangam@kpitcummins.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "dchen@diasemi.com" <dchen@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Jun 30, 2011 at 09:15:27AM -0400, ashishj3 wrote:
> The DA9052 PMIC provides an Analogue to Digital Converter with 10 bits
> resolution and 10 channels.
> 
> This patch montiors the DA9052 PMIC's ADC channels mostly for battery parameters
> like battery temperature, junction temperature, battery current etc.
> 
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

I assume this patch will be handled as part of a patchset, correct ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
