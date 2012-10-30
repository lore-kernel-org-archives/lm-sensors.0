From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Oct 2012 16:45:38 +0000
Subject: Re: [lm-sensors] [PATCH v3 5/9] hwmon: (it87) Save fan registers in 2-dimensional array
Message-Id: <20121030174538.481d000b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 29 Oct 2012 17:45:45 -0700, Guenter Roeck wrote:
> Also unify fan functions to use the same code for 8 and 16 bit fans
> 
> This patch reduces code size by approximately 1,200 bytes on x86_64.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: s/S_IRUGOWU/S_IRUGO | S_IWUSR/
>     Reverse has_16bit_fans() logic in set_fan()
> v2: Drop has_16bit_fans flag, since we'll deal with it in patch 8/8.
> 
>  drivers/hwmon/it87.c |  263 ++++++++++++++++++++------------------------------
>  1 file changed, 104 insertions(+), 159 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
