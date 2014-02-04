From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 04 Feb 2014 03:14:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Avoid initializing the same field twice
Message-Id: <52F05B15.1030108@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140203184211.35536a4b@endymion.delvare>
In-Reply-To: <20140203184211.35536a4b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/03/2014 09:42 AM, Jean Delvare wrote:
> All hwmon drivers allocate their data structure with some form of
> kzalloc, so setting data fields to zero explicitly is a waste of time.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Forgot: Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Guenter, this is likely to conflict with your current conversion work,
> as most of these drivers have not been converted yet (lm63 is the
> exception.) I thought splitting this patch per driver was a little
> overkill but maybe this would be better for you? I think I'll split at
> least pc87360 anyway as it's non-trivial. Let me know how you want to
> proceed.

Also, yes, separating the pc87360 patch might make sense.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
