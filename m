From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Feb 2014 11:25:22 +0000
Subject: Re: [lm-sensors] (PATCH] hwmon: (lm95241) Avoid initializing the same field twice
Message-Id: <52FB5A22.3080204@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140212100446.2cac0b90@endymion.delvare>
In-Reply-To: <20140212100446.2cac0b90@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/12/2014 01:04 AM, Jean Delvare wrote:
> data is kzalloc'd, so data->valid and data->model are already 0.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---

Thanks, applied.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
