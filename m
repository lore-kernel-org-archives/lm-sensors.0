From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 May 2011 13:40:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix section mismatch
Message-Id: <20110526134003.GA29291@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110526120154.2b7b6c4e@endymion.delvare>
In-Reply-To: <20110526120154.2b7b6c4e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 26, 2011 at 06:01:54AM -0400, Jean Delvare wrote:
> chk_ucode_version() is only called from coretemp_probe() which is
> __devinit, so it can be marked __devinit too.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Durgadoss R <durgadoss.r@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Applied, thanks.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
