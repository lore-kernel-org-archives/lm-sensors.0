From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Apr 2011 12:53:21 +0000
Subject: Re: [lm-sensors] [PATCH] [hwmon] lm90: Support NCT1008 sensor
Message-Id: <20110413145321.181484bf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302695508-2002-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1302695508-2002-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wni@nvidia.com
Cc: guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, olofj@chromium.org, achew@nvidia.com

Hi Wei,

On Wed, 13 Apr 2011 19:51:48 +0800, wni@nvidia.com wrote:
> From: Wei Ni <wni@nvidia.com>
> 
> NCT1008 is the register-compatible with the ADM1032 and ADT7461,
> so support it in this lm90 driver.
> And add alarm function, suspend/resume callback.

We already have a patch pending adding support for the NCT1008:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-lm90-01-add-support-for-adt7461a-and-nct1008.patch

Your own patch should apply on top of this, and only focus on adding
support for the new features. BTW, you stand a better chance of getting
your changes reviewed and accepted quickly if you split them into
logical steps. For example, suspend/resume support would be useful on
its own, so it could be a separate patch, etc.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
