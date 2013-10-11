From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Oct 2013 07:17:41 +0000
Subject: Re: [lm-sensors] [PATCH v5] hwmon: (lm90) split set&show temp as common codes
Message-Id: <20131011091741.59cdaf31@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381215866-20608-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1381215866-20608-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 8 Oct 2013 15:04:26 +0800, Wei Ni wrote:
> Split set&show temp codes as common functions, so we can use it
> directly when implement linux thermal framework.
> And handle error return value for the lm90_select_remote_channel
> and write_tempx, then set_temp8 and set_temp11 could return it
> to user-space.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |  166 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 113 insertions(+), 53 deletions(-)
> (...)

Applied with minor edits, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
