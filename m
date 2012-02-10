From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Feb 2012 14:50:18 +0000
Subject: Re: [lm-sensors] [PATCH] HWMON: DA9052/53 hwmon driver v2
Message-Id: <20120210145018.GB603@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328878702.30549.155.camel@dhruva>
In-Reply-To: <1328878702.30549.155.camel@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ashish Jangam <ashish.jangam@kpitcummins.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "dchen@diasemi.com" <dchen@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Feb 10, 2012 at 07:58:22AM -0500, Ashish Jangam wrote:
> The DA9052 PMIC provides an Analogue to Digital Converter with 10 bits
> resolution and 10 channels.
> 
> This patch montiors the DA9052 PMIC's ADC channels mostly for battery
> parameters like battery temperature, junction temperature, battery
> current etc.
> 
> This patch is functionally tested on Samsung SMDKV6410.
> 
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>

Ashish,

at first glance looks good. I am about to be travelling for a week;
I'll get back afterwards unless Jean picks it up from here. No hurry,
though, since the next release is still a bit out.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
