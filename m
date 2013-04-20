From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Apr 2013 08:48:28 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (tmp401) Add support for update_interval attribute
Message-Id: <20130420104828.65233781@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365962173-28311-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365962173-28311-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 14 Apr 2013 10:56:12 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Improve indentation in tmp401_update_device
>     Improve and simplify calculations in set_update_interval
>     Move calculations outside the locked code section
>     Make update_interval variable unsigned
> 
>  drivers/hwmon/tmp401.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> (...)

Looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
