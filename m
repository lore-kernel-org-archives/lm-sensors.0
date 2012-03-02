From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Mar 2012 07:47:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Restore original configuration if probe function fails
Message-Id: <20120302084756.2436ba97@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330376387-30456-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1330376387-30456-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 27 Feb 2012 12:59:47 -0800, Guenter Roeck wrote:
> The lm90 driver restores the original chip configuration in its exit function.
> However, the chip configuration is not restored if the probe function fails.
> Restore it there as well.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm90.c |   21 +++++++++++++--------
>  1 files changed, 13 insertions(+), 8 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
