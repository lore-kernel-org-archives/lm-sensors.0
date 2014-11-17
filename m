From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 17 Nov 2014 08:25:59 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Add blank lines after declarations
Message-Id: <20141117092559.64be017f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416161714-23796-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1416161714-23796-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 16 Nov 2014 10:15:14 -0800, Guenter Roeck wrote:
> checkpatch complains about
> 	WARNING: Missing a blank line after declarations
> 
> Add missing blank lines. Also reorder variables length-wise where appropriate
> if a function header is touched anyway.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/nct6775.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
