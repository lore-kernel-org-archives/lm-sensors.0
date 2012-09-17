From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Sep 2012 12:08:02 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (max1111) Add support for MAX1110, MAX1112, and MAX1113
Message-Id: <20120917140802.60bdde8f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347396657-30534-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347396657-30534-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Sep 2012 13:50:57 -0700, Guenter Roeck wrote:
> MAX1110 is similar to MAX1111, with 8 instead of 4 channels. MAX1112 and MAX1113
> are similar to MAX1110 and MAX1111, with 4.096V reference voltage instead of
> 2.048V.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Use to_spi_device(dev)->modalias to get device name in show_name function
> 
> v2: Review feedback
>     Kconfig: MAX1112 -> MAX1110
>     mmax1110 -> max1110
>     Remove unused variables
>     Use unique error messages
>     Remove unnecessary label
> 
>  drivers/hwmon/Kconfig   |    5 ++--
>  drivers/hwmon/max1111.c |   74 ++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 70 insertions(+), 9 deletions(-)
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
