From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Feb 2014 11:25:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95245) Avoid initializing the same field twice
Message-Id: <52FB5A3C.3090304@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140212100527.447d3e3c@endymion.delvare>
In-Reply-To: <20140212100527.447d3e3c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/12/2014 01:05 AM, Jean Delvare wrote:
> data is kzalloc'd, so data->valid is already 0.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Thanks, applied.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
