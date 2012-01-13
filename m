From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 08:47:10 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (lm63) Add sensor type attribute for external sensor on LM961
Message-Id: <20120113094710.05586475@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326407015-7181-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326407015-7181-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Jan 2012 14:23:35 -0800, Guenter Roeck wrote:
> On LM96163, the external temperature sensor type is configurable to
> either a thermal diode or a 3904 transistor. The chip reports a wrong
> temperature if misconfigured. Add writable attribute to support it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2:
> - snprintf -> sprintf
> - set temp sensor type to 1(CPU diode) instead of 3 (thermal diode) if trutherm
>   is enabled
> - return error code from kstrtoul()
> - When configuring the diode type, only set trutherm enable bit
> - When detecting configured diode type, only check trutherm enable bit
> - Document that configuring the thermal sensor type is supported for LM96163

I don't see such documentation addition. Forgot to add the file to the
patch?

>  drivers/hwmon/lm63.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> (...)
> +	reg = i2c_smbus_read_byte_data(client, LM96163_REG_TRUTHERM) & ~0x02;
> +	i2c_smbus_write_byte_data(client, LM96163_REG_TRUTHERM,
> +				  reg | data->trutherm ? 0x02 : 0x00);

This lacks parentheses to do the right thing. | has higher precedence
than ?:. It works by chance because reg has value 0 in practice.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
