From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 12:46:03 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (lm63) Add sensor type attribute for external sensor on LM96163
Message-Id: <20120113134603.24e5693c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326454963-1852-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326454963-1852-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 13 Jan 2012 03:42:43 -0800, Guenter Roeck wrote:
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
> v3:
> - Really attach documentation update this time
> - Add missing parentheses
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
