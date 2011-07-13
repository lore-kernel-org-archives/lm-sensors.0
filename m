From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 13 Jul 2011 20:48:11 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <1310590091.609.4.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-07-12 at 07:07 -0400, Durgadoss R wrote: 
> This patch adds the core and pkg support to coretemp.
> These thresholds can be configured via the sysfs interfaces tempX_max
> and tempX_max_hyst. An interrupt is generated when CPU temperature reaches
> or crosses above tempX_max OR drops below tempX_max_hyst.
> 
> This patch is based on the documentation in IA Manual vol 3A, that can be
> downloaded from here:
> http://download.intel.com/design/processor/manuals/253668.pdf
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

Looks like it is working now, so I applied the patch to -next.

Thanks,
Guenter





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
