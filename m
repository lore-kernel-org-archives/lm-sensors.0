From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Apr 2014 17:06:56 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: vexpress: Use devm helper for hwmon device registration
Message-Id: <20140430170656.GB3389@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1398874030-8759-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1398874030-8759-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 30, 2014 at 05:07:10PM +0100, Pawel Moll wrote:
> Use devm_hwmon_device_register_with_groups instead of
> the old-style manual attributes and hwmon device registration.
> 
> Also, unroll the attribute group macros for better code
> readability.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
