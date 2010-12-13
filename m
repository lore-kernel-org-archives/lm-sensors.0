From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Dec 2010 17:09:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4215) make sysfs file match the
Message-Id: <20101213170915.GA26675@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292258550-14783-1-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1292258550-14783-1-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 13, 2010 at 11:42:30AM -0500, Ira W. Snyder wrote:
> The ltc4215 driver used the chip's "power good" status bit to provide
> the power1_alarm file. This is wrong: the chip is really reporting the
> status of one of the monitored voltages.
> 
> Change the sysfs file from power1_alarm to in2_min_alarm instead. This
> matches the voltage that the chip is raising an alarm for.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
