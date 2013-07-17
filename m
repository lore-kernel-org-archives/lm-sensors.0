From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 17 Jul 2013 22:23:49 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] i2c: Add DIMM bus code
Message-Id: <20130717222349.GD990@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374093761.git.luto@amacapital.net>
 <b8e50b55358b4f0cd1db96174a9e6a2e69780359.1374093761.git.luto@amacapital.net>
In-Reply-To: <b8e50b55358b4f0cd1db96174a9e6a2e69780359.1374093761.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On Wed, Jul 17, 2013 at 01:53:05PM -0700, Andy Lutomirski wrote:
> Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
> contains DIMMs.  This will probe (and autoload modules!) for useful
> SMBUS devices that live on DIMMs.
> 
> As more SMBUS-addressable DIMM components become supported, this
> code can be extended to probe for them.
> 
I don't think this code is necessary. The temperature sensor would be
auto-detected if you mark the bus driver as I2C_CLASS_HWMON, and DIM eeprom
auto-detection should not be needed.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
