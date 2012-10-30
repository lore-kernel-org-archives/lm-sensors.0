From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Oct 2012 20:23:13 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/3] hwmon: (it87) Introduce support for tempX_offset sysfs attribute
Message-Id: <20121030212313.0ceded32@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351624399-22595-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351624399-22595-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 Oct 2012 12:13:17 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4: Add missing chip types (it8718 and it8720) to has_temp_offset()
>     Clean up set_temp() a bit more
> v3: s/S_IRUGOWU/S_IRUGO | S_IWUSR/
>     Limit support for new attributes to IT8716F and higher
>     Clarify code to select target register in set_temp().
>     Only clear valid flag when writing into offset registers,
>     not for any other temperature limit set operations.
> v2: The macro to calculate IT87_REG_TEMP_OFFSET was broken. Use array instead.
>     When writing the temperature offset attribute, set the flag to enable it.
>     Add documentation describing the new attributes.
> 
>  Documentation/hwmon/it87 |    9 +++++++
>  drivers/hwmon/it87.c     |   66 ++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 70 insertions(+), 5 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
