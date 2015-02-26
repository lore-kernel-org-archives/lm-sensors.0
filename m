From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 26 Feb 2015 10:22:05 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/5] hwmon: (it87) Add feature flags for fans count and 16-bit fan config
Message-Id: <20150226112205.4d459c4f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424884581-2348-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1424884581-2348-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Feb 2015 09:16:18 -0800, Guenter Roeck wrote:
> Fans 4-5 are not supported on all chips and revisions. Also, 16-bit fan
> counters are always enabled on some chips. Provide feature flags to
> simplify adding support for new chips.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Modified description.
>     Modified chip version dependent feature flag handling for IT8705F
> 	and IT8712F.
>     Simplified has_fan16_config() macro.
>     16-bit only fan configuration is now introduced in separate patch.
> 
>  drivers/hwmon/it87.c | 69 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 33 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
