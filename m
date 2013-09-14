From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Sep 2013 11:06:35 +0000
Subject: Re: [lm-sensors] [PATCH 01/12] hwmon: Remove unnecessary semicolons
Message-Id: <20130914130635.0962a043@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379147615-7703-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1379147615-7703-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 14 Sep 2013 01:33:24 -0700, Guenter Roeck wrote:
> Semicolons after closing } of conditional blocks are not needed
> and can be removed.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adm1026.c |    6 +++---
>  drivers/hwmon/asc7621.c |   12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> (...)

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
