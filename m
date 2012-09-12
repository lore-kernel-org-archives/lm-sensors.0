From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Sep 2012 08:17:32 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/5] hwmon: (max1111) Add support for MAX1110, MAX1112, and MAX1113
Message-Id: <20120912101732.3ec34f7a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347381259-14585-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347381259-14585-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Sep 2012 09:34:16 -0700, Guenter Roeck wrote:
> MAX1110 is similar to MAX1111, with 8 instead of 4 channels. MAX1112 and MAX1113
> are similar to MAX1110 and MAX1111, with 4.096V reference voltage instead of
> 2.048V.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Review feedback
>     Kconfig: MAX1112 -> MAX1110
>     mmax1110 -> max1110
>     Remove unused variables
>     Use unique error messages
>     Remove unnecessary label
> 
>  drivers/hwmon/Kconfig   |    5 +--
>  drivers/hwmon/max1111.c |   81 +++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 77 insertions(+), 9 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
