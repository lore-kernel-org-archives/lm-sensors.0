From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jan 2012 16:13:02 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] hwmon: (lm63) Add support for LM96163
Message-Id: <20120110171302.4650a88b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326166923-11187-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326166923-11187-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon,  9 Jan 2012 19:42:00 -0800, Guenter Roeck wrote:
> From: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> LM96163 is an enhanced version of LM63 with improved PWM resolution. Add chip
> detection code as well as support for improved PWM resolution if the chip is
> configured to use it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/lm63 |    8 ++++++++
>  drivers/hwmon/Kconfig    |    4 ++--
>  drivers/hwmon/lm63.c     |   41 ++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 46 insertions(+), 7 deletions(-)
> (...)

I already have reviewed that one. You have a minor bug in your copy,
BTW, which is fixed in mine:

> +			dev_warn(&client->dev,
> +				 "Unsigned format for High and Crit setpoints enabled but not supported by driver");

Missing \n at the end of this string.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
