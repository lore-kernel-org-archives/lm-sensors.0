From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 Jan 2012 19:23:53 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of LM96080
Message-Id: <20120128192353.GA4635@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 28, 2012 at 01:37:56PM -0500, Jean Delvare wrote:
> Add detection of the National Semiconductor (now Texas Instruments)
> LM96080. It is functionally compatible with the LM80 but detection is
> completely different.
> ---
> Frans, if you want to test this, a pre-patched version of
> sensors-detect is available at:
> http://khali.linux-fr.org/devel/misc/sensors-detect
> 
Looks good. Should we do the same for drivers/hwmon/lm80.c ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
