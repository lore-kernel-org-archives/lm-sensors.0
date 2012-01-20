From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Jan 2012 13:33:46 +0000
Subject: Re: [lm-sensors] [PATCH 12/39] hwmon: (f71805f) Fix checkpatch issues
Message-Id: <20120120143346.22adffe7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326703781-14272-13-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326703781-14272-13-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 Jan 2012 00:49:14 -0800, Guenter Roeck wrote:
> Fixed:
> ERROR: code indent should use tabs where possible
> ERROR: do not use assignment in if condition
> ERROR: "foo* bar" should be "foo *bar"
> ERROR: need consistent spacing around '|' (ctx:VxW)
> WARNING: simple_strtol is obsolete, use kstrtol instead
> WARNING: simple_strtoul is obsolete, use kstrtoul instead
> WARNING: static const char * array should probably be static const char * const
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/f71805f.c |  163 ++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 118 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
> index 92f9497..859b203 100644
> --- a/drivers/hwmon/f71805f.c
> +++ b/drivers/hwmon/f71805f.c
> (...)

Looks OK, tested without problems.

Acked-by: Jean Delvare <khali@linux-fr.org>

I noticed an unrelated bug during my testing, I'll investigate it and
send a fix.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
