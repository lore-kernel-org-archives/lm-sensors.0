From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Jul 2015 20:26:56 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: (nct7802) Add pwm control
Message-Id: <55984190.7070606@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436035791-29950-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1436035791-29950-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/04/2015 11:49 AM, Constantine Shulyupin wrote:
> Added fan output control registers.
> Modes of operation are PWM (default) and DC.
>
> Introduced show_pwm, store_pwm, nct7802_pwm_attrs, nct7802_pwm_group.
>
> ---
> Change log:
> Fixed in v2:
> - renamed fanX_output to pwmX
> - introduced nct7802_pwm_group and nct7802_pwm_attrs
> - renamed show_dec to show_pwd
> - used kstrtou8 instead kstrtouint
> Fixed in v3:
> - spilt functions declarations to fit 80 columns
> - removed unnecessary initializations
> - rearranged variable declarations
> - shortened return expression
> - renamed store_u8 to store_pwm
> Fixed in v4:
> - compilation error: missing val
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
