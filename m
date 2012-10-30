From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Oct 2012 20:25:01 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/3] hwmon: (it87) Manage device specific features with table
Message-Id: <20121030212501.0580298a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351624399-22595-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351624399-22595-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 Oct 2012 12:13:18 -0700, Guenter Roeck wrote:
> This simplifies the code, improves runtime performance, reduces
> code size (about 280 bytes on x86_64), and makes it easier
> to add support for new devices.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4: s/override/overwrite/
>     Add back lost break statement in it87_probe()
> v3: s/define^I/define /
>     Handle new conditional FEAT_TEMP_OFFSET
>     const char * const name -> const char *name
>     define "features" flag consistently as u16
> v2: Don't introduce new chip type for IT8726F. Doing that would break backward
>     compatibility.
>     Since we dropped the has_16bit_fans flag from patch 5/8, changing the code
>     back to use has_16bit_fans() is no longer needed.
> 
>  drivers/hwmon/it87.c |  155 ++++++++++++++++++++++++++------------------------
>  1 file changed, 81 insertions(+), 74 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
