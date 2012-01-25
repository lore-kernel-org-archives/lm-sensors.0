From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Jan 2012 08:47:01 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (lm78) Fix checkpatch issues
Message-Id: <20120125094701.36d9c376@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327445112-23654-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327445112-23654-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 Jan 2012 14:45:12 -0800, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Fixed:
> ERROR: code indent should use tabs where possible
> ERROR: do not use assignment in if condition
> ERROR: space prohibited before that close parenthesis ')'
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: spaces required around that '<' (ctx:VxV)
> ERROR: spaces required around that '=' (ctx:VxV)
> ERROR: trailing statements should be on next line
> ERROR: trailing whitespace
> WARNING: simple_strtol is obsolete, use kstrtol instead
> WARNING: simple_strtoul is obsolete, use kstrtoul instead
> 
> Modify multi-line comments to follow Documentation/CodingStyle.
> 
> Not fixed (false positive):
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Merged checkpatch and multi-line patches into one
> v3: Comment cleanup per review feedback
> 
>  drivers/hwmon/lm78.c |  206 ++++++++++++++++++++++++++++++++------------------
>  1 files changed, 132 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
> index 6df0b46..f6bc414 100644
> --- a/drivers/hwmon/lm78.c
> +++ b/drivers/hwmon/lm78.c
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
