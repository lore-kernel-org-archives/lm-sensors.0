From: Stephen Warren <swarren@wwwdotorg.org>
Date: Fri, 05 Jul 2013 17:35:05 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (lm90) add support to handle irq
Message-Id: <51D703C9.1060607@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372924670-16355-1-git-send-email-wni@nvidia.com> <1372924670-16355-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1372924670-16355-3-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/04/2013 01:57 AM, Wei Ni wrote:
> Add support to handle irq. When the temperature touch
> the limit value, the driver can handle the interrupt.

> +	if (client->irq >= 0) {

0 isn't a valid IRQ, so you can write that as simply if (client->irq).

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
