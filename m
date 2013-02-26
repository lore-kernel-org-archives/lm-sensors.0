From: Joe Perches <joe@perches.com>
Date: Tue, 26 Feb 2013 18:35:14 +0000
Subject: Re: [lm-sensors] [PATCH v5 03/12] hwmon: (nct6775) Add support for temperature sensors
Message-Id: <1361903714.2023.19.camel@joe-AO722>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361903020-18526-1-git-send-email-linux@roeck-us.net>
	 <1361903020-18526-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1361903020-18526-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, 2013-02-26 at 10:23 -0800, Guenter Roeck wrote:
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
[]
> +static const u16 NCT6779_REG_TEMP_CONFIG[11] = { 0x18, 0x152 };

Isn't 11 too magic a number?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
