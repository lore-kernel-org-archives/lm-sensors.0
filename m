From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 15:51:39 +0000
Subject: Re: [lm-sensors] [PATCH 46/95] hwmon: (lm78) Convert to use devm_ functions
Message-Id: <20120616175139.12765bfa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-47-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-47-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:23:27 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm78.c |   38 ++++++++++++--------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
> index f6bc414..1eacac9 100644
> --- a/drivers/hwmon/lm78.c
> +++ b/drivers/hwmon/lm78.c
> (...)
> @@ -885,28 +880,19 @@ static int __devinit lm78_isa_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> - exit_remove_files:
> +exit_remove_files:

The space before the label wasn't a mistake, it's there on purpose. The
goal is to let diff -p display function names rather than labels. I
seemed to recall that Documentation/CodingStyle mentioned that, but I
can't find it again. You'll notice though that checkpatch doesn't
complain about it, not even in strict mode.

Other than this:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
