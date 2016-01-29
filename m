From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 Jan 2016 17:53:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (vexpress) rename vexpress hwmon implementation
Message-Id: <56ABA701.6060101@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1454088952-24722-1-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1454088952-24722-1-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org

On 01/29/2016 09:35 AM, Sudeep Holla wrote:
> The vexpress hwmon implementation is currently just called vexpress.
> This is a problem because it clashes with another module with the same
> name in regulators.
>
> This patch renames the vexpress hwmon implementation to vexpress-hwmon
> so that there will be no clash in the module namespace.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: lm-sensors@lm-sensors.org
> Reported-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
