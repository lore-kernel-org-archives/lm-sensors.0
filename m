From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Nov 2013 10:33:33 +0000
Subject: Re: [lm-sensors] [PATCH RESEND v4 2/3] hwmon: (lm90) add support to handle IRQ
Message-Id: <20131104113333.1d385eaa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1383560793-11039-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1383560793-11039-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 4 Nov 2013 18:26:33 +0800, Wei Ni wrote:
> When the temperature exceed the limit range value,
> the driver can handle the interrupt.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
