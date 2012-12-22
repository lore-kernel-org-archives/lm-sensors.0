From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 22 Dec 2012 01:30:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: detect i2c bus errors before scnprintf()
Message-Id: <20121222013056.GA2068@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 21, 2012 at 01:58:34AM -0800, Chris Verges wrote:
> If an LM73 device does not exist on an I2C bus, attempts to communicate
> with the device result in an error code returned from the i2c read/write
> functions.  The current lm73 driver casts that return value from a s32
> type to a s16 type, then converts it to a temperature in celsius.
> Because negative temperatures are valid, it is difficult to distinguish
> between an error code printed to the response buffer and a negative
> temperature recorded by the sensor.
> 
> The solution is to evaluate the return value from the i2c functions
> before performing any temperature calculations.  If the i2c function did
> not succeed, the error code should be passed back through the virtual
> file system layer instead of being printed into the response buffer.
> 
> Before:
> 
>    $ cat /sys/class/hwmon/hwmon0/device/temp1_input
>    -46
> 
> After:
> 
>    $ cat /sys/class/hwmon/hwmon0/device/temp1_input
>    cat: read error: No such device or address
> 
> Signed-off-by: Chris Verges <kg4ysn@gmail.com>

Applied.

Just wondering - how comes the detect function did not report the error ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
