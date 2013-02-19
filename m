From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 19 Feb 2013 23:00:05 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/9] hwmon: (lm90) add support to handle irq
Message-Id: <512403F5.5010005@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-4-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-4-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni@nvidia.com>
Cc: durgadoss.r@intel.com, rui.zhang@intel.com, MLongnecker@nvidia.com, khali@linux-fr.org, devicetree-discuss@lists.ozlabs.org, linux-tegra@vger.kernel.org, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.orgrs.org, linux-arm-kernel@lists.infradead.org, Alexandre Courbot <acourbot@nvidia.com>

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Add support to handle irq. When the temperature touch the limit value, the
> driver can handle the interrupt.

> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c

> +static void lm90_irq_work(struct work_struct *work)
...
> +	enable_irq(client->irq);
> +}
> +
> +static irqreturn_t lm90_irq(int irq, void *dev_id)
> +{
> +	struct lm90_data *data = dev_id;
> +
> +	disable_irq_nosync(irq);

I think IRQF_ONESHOT would enable you to remove the manual
enable/disable_irq calls.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
