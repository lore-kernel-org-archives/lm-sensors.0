From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Nov 2013 08:31:42 +0000
Subject: Re: [lm-sensors] [PATCH RESEND v4 1/3] hwmon: (lm90) Define status bits
Message-Id: <20131104093142.6a02b212@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1383188862-4157-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1383188862-4157-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 31 Oct 2013 11:07:41 +0800, Wei Ni wrote:
> Add bit defines for the status register. And add a function
> lm90_is_tripped() which will read status register and return
> tripped or not, then lm90_alert can call it directly, and in the
> future the IRQ thread also can use it.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |   75 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 51 insertions(+), 24 deletions(-)
> (...)

Looks good now. Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
