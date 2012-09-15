From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 15 Sep 2012 16:00:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Drop dependencies on EXPERIMENTAL
Message-Id: <20120915180033.48e398c3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347721525-22792-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347721525-22792-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 15 Sep 2012 08:05:25 -0700, Guenter Roeck wrote:
> CONFIG_EXPERIMENTAL is expected to be removed, so drop dependencies on it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/Kconfig |   81 ++++++++++++++++++++++++-------------------------
>  1 file changed, 40 insertions(+), 41 deletions(-)
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
