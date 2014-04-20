From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Apr 2014 15:40:59 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] libsensors: Add support for temp[1-*]_min_hyst and temp[1-*]_lcrit_hyst
Message-Id: <5353EA8B.1060801@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022134628.5224289d@hyperion.delvare>
In-Reply-To: <20081022134628.5224289d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/20/2014 05:53 AM, Jean Delvare wrote:
> Add support for sysfs attributes temp[1-*]_min_hyst (already
> implemented by drivers adt7x10, lm77 and lm92) and
> temp[1-*]_lcrit_hyst (no known users yet.)

Looks good. I'll see if I can test and the next patch
later today or tomorrow.

For both patches:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
