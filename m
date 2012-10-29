From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Oct 2012 12:26:03 +0000
Subject: Re: [lm-sensors] [PATCH 7/9] hwmon: (it87) Replace pwm group macro with direct attribute definitions
Message-Id: <20121029132603.625c2a73@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-8-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-8-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Oct 2012 11:19:59 -0700, Guenter Roeck wrote:
> Fix checkpatch error:
> 
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c |  115 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 74 insertions(+), 41 deletions(-)
> (...)

Looks good.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
