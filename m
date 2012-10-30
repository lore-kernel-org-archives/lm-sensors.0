From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Oct 2012 16:52:02 +0000
Subject: Re: [lm-sensors] [PATCH v2 7/9] hwmon: (it87) Replace pwm group macro with direct attribute definiti
Message-Id: <20121030175202.53b933d4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 29 Oct 2012 17:45:47 -0700, Guenter Roeck wrote:
> Fix checkpatch error:
> 
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: s/S_IRUGOWU/S_IRUGO | S_IWUSR/
> 
>  drivers/hwmon/it87.c |  115 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 74 insertions(+), 41 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
