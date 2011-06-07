From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 07 Jun 2011 19:17:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Drop unused struct
Message-Id: <20110607191736.GA3979@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110607211426.19169f7a@endymion.delvare>
In-Reply-To: <20110607211426.19169f7a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 07, 2011 at 03:14:26PM -0400, Jean Delvare wrote:
> pdev_entry.cpu and pdev_entry.cpu_core_id aren't used anywhere in the
> driver code so we can drop these struct members.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Durgadoss R <durgadoss.r@intel.com>

Nice catch ... thanks, applied.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
