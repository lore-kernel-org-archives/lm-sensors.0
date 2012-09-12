From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Sep 2012 08:26:36 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/5] hwmon: (ina2xx) Use structure array to distinguish chip types
Message-Id: <20120912102636.655456c6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347381259-14585-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347381259-14585-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Sep 2012 09:34:18 -0700, Guenter Roeck wrote:
> Replace per-device initialization and per-device calculation code with
> per-device configuration data, which is then used to configure the chip and
> perform calculations based on that data.
> 
> This patch reduces code size by more than 400 bytes on x86_64.
> 
> Cc: Lothar Felten <l-felten@ti.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Review feedback:
>     Fix for word swap operations split to second patch
>     Change config variable name to config_default
>     Change variable types to const where appropriate
>     Use DIV_ROUND_CLOSEST for divide operation in INA2XX_BUS_VOLTAGE case
>     Get rid of data->registers (use data->config->registers instead)
> 
>  drivers/hwmon/ina2xx.c |  159 +++++++++++++++++-------------------------------
>  1 file changed, 56 insertions(+), 103 deletions(-)
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
