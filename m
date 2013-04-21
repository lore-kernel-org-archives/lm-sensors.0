From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Apr 2013 08:58:12 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (tmp401) Simplification and cleanup
Message-Id: <20130421105812.69d72bc6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1366478293-8167-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1366478293-8167-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 20 Apr 2013 10:18:10 -0700, Guenter Roeck wrote:
> Use two-dimensional array pointing to registers
> Merge temperature and limit access functions into a single function
> Return error codes from I2C reads
> Use DIV_ROUND_CLOSEST for rounding operations and improve rounding
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Improve rounding
>     Fix spelling error in commit log
>     Fix rounding error when writing critical limit
> 
> v2: Fix spelling error in commit log, and clarify that only i2c reads
>     return errors
>     Mark unused array entries by using 0 instead of 0x00 for improved
>     readability
>     Fix rounding error when writing critical limit
>     Don't rename reg to regval in store_temp
>     Use local client variable in store_temp
> 
>  drivers/hwmon/tmp401.c |  371 ++++++++++++++++++------------------------------
>  1 file changed, 137 insertions(+), 234 deletions(-)
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

BTW, with all the work you've done on the driver, I think you could add
your name and copyright on top of it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
