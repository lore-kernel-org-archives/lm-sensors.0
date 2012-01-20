From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Jan 2012 16:05:39 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (it87) Fix multi-line comments
Message-Id: <20120120170539.3c87c225@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327073911-26882-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327073911-26882-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 20 Jan 2012 07:38:31 -0800, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Fix multi-line comments, and clean up some of the affected comments.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Some additional comment cleanup
> 
>  drivers/hwmon/it87.c |  170 ++++++++++++++++++++++++++++++++------------------
>  1 files changed, 108 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 0054d6f..93a197b 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
