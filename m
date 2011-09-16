From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 16 Sep 2011 22:11:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (coretemp) Drop duplicate
Message-Id: <1316211111.4630.16.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110916212143.557f8495@endymion.delvare>
In-Reply-To: <20110916212143.557f8495@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-09-16 at 15:21 -0400, Jean Delvare wrote:
> Function get_pkg_tjmax is a simplified copy of get_tjmax. Drop it and
> always use get_tjmax, result is the same and this avoids code
> duplication.
> 
> Also make get_tjmax less verbose: don't warn about MSR read failure
> when failure was expected, and don't report TjMax in the logs unless
> debugging is enabled.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Durgadoss R <durgadoss.r@intel.com>
> ---

Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
