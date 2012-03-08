From: Ashish Jangam <Ashish.Jangam@kpitcummins.com>
Date: Thu, 08 Mar 2012 02:21:34 +0000
Subject: Re: [lm-sensors] [PATCH 02/03] HWMON: HWMON driver for DA9052/53 PMIC v3
Message-Id: <C3AE124F08223B42BC95AEB82F0F6CED2B9A6FE5@KCHJEXMB02.kpit.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330698545.21817.31.camel@dhruva>
 <1331147302.23014.370.camel@groeck-laptop>
In-Reply-To: <1331147302.23014.370.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "guenter.roeck@ericsson.com" <guenter.roeck@ericsson.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "dchen@diasemi.com" <dchen@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>

> Only comment I would have is that it might make sense to use
> DIV_ROUND_CLOSEST(). That is a minor issue, though, so feel free to add
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Question is where this is going. I can not add it to hwmon-next without
> the matching mfd changes. Any idea ?
This patch will depends on DA9052 MFD which is already merged in main line. However this
also depends on a incremental patch for MFD which is yet to get ACK but soon should be in. 
> 
> Thanks,
> Guenter
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
