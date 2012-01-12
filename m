From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jan 2012 20:41:31 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm63) Add support for writing the external critical temperature
Message-Id: <20120112214131.0456e8c5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326223430-3297-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326223430-3297-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 Jan 2012 11:23:50 -0800, Guenter Roeck wrote:
> On LM64, the external critical temperature limit is always writable. On LM96163,
> it is writable if the chip is configured for it. Add conditional support for
> writing the register dependent on chip type and configuration.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm63.c |   55 ++++++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 44 insertions(+), 11 deletions(-)
> (...)

Looks good. Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
