From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jan 2012 08:11:26 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (lm87) Fix checkpatch issues
Message-Id: <20120126091126.30be6b6e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327508806-23953-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327508806-23953-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Jan 2012 08:26:46 -0800, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Fixed:
> ERROR: do not use assignment in if condition
> ERROR: space required after that close brace '}'
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: spaces required around that '<' (ctx:VxV)
> ERROR: trailing statements should be on next line
> WARNING: line over 80 characters
> WARNING: simple_strtol is obsolete, use kstrtol instead
> WARNING: simple_strtoul is obsolete, use kstrtoul instead
> 
> Modify multi-line comments to follow Documentation/CodingStyle.
> 
> Not fixed everywhere (code complexity):
> ERROR: do not use assignment in if condition
> 
> As a side effect of the changes made, attribute set functions now return an
> error if an attempt is made to write a non-numeric value. Previously, such
> writes were interpreted as writing 0.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Merged checkpatch and multi-line comment patches into a single patch
> v3: Fixed some alignment issues. Added note to commit log describing that
>     set functions now return error codes.
> 
>  drivers/hwmon/lm87.c |  257 ++++++++++++++++++++++++++++++++++----------------
>  1 files changed, 174 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
> index 126d0cc..0216592 100644
> --- a/drivers/hwmon/lm87.c
> +++ b/drivers/hwmon/lm87.c
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
