From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 20 Jul 2014 12:02:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (tmp421) Strengthen detect function
Message-Id: <20140720140222.2eaa9b68@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404680101-8843-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404680101-8843-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun,  6 Jul 2014 13:54:59 -0700, Guenter Roeck wrote:
> Not all supported chips support the entire I2C address range.
> Only accept specific chips at the addresses supported by that chip.
> Check for invalid values in conversion rate and status registers.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/tmp421 |  4 ++--
>  drivers/hwmon/tmp421.c     | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> (...)

Looks good.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
