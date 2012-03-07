From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 07 Mar 2012 19:08:22 +0000
Subject: Re: [lm-sensors] [PATCH 02/03] HWMON: HWMON driver for DA9052/53 PMIC v3
Message-Id: <1331147302.23014.370.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330698545.21817.31.camel@dhruva>
In-Reply-To: <1330698545.21817.31.camel@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ashish Jangam <ashish.jangam@kpitcummins.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "dchen@diasemi.com" <dchen@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>

On Fri, 2012-03-02 at 09:29 -0500, Ashish Jangam wrote:
> The DA9052 PMIC provides an Analogue to Digital Converter with 10 bits
> resolution and 10 channels.
> 
> This patch monitors the DA9052 PMIC's ADC channels mostly for battery
> parameters like battery temperature, junction temperature, battery
> current etc.
> 
> This patch is functionally tested on Samsung SMDKV6410
> 
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>

Only comment I would have is that it might make sense to use
DIV_ROUND_CLOSEST(). That is a minor issue, though, so feel free to add

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Question is where this is going. I can not add it to hwmon-next without
the matching mfd changes. Any idea ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
