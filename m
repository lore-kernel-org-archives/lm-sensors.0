From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 Jun 2012 16:34:29 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <20120629163429.GA20993@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com>
 <20120627171505.GB12712@roeck-us.net>
 <4FEB90A8.8050901@googlemail.com>
 <20120628014548.GA15994@srcf.ucam.org>
 <4FEC3CDF.7050901@googlemail.com>
 <20120628144035.36ac75a0@endymion.delvare>
 <4FEC53DD.8050403@googlemail.com>
 <20120628152754.2ab6697a@endymion.delvare>
 <4FED3EB3.4000602@gmail.com>
 <4FED9B58.3090102@googlemail.com>
In-Reply-To: <4FED9B58.3090102@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Zintakis <michael.zintakis@googlemail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

On Fri, Jun 29, 2012 at 01:11:04PM +0100, Michael Zintakis wrote:
> 
[ ... ]
> Interesting and it sort-of confirms my "findings" from yesterday's
> bout I've had with ACPI.
> 
> When I completely deactivate ACPI ("acpi=off" in the kernel command
> line), there is obviously no more conflict errors reported, but what
> I also discovered is that the problem I've had with the fans not
> able to start (when they are at standstill initially) is not there
> any more!
> 
> When I forcefully stop a fan by "echo 1 > pwmX" (you were right,
> when I deactivate any sort of temperature, fan & voltage management
> in BIOS and ACPI is OFF, the fans run at maximum speed), then select
> "automatic" management and pass control over to the f71882fg driver,

You are giving too much credit to the driver. The driver only reads and sets
register values, but does not perform any activities beyond that.

> when the temperature rises enough for the fan to start spinning, but
> not enough to push it over the "safe" minimum speed threshold, this
> raises an alarm event (fanX_alarm gets triggered) and the f71882fg
> driver then, completely by itself, pushes the fan to its maximum
> speed momentarily and the fan starts spinning - exactly the
> behaviour I was "simulating" with my bash script.
> 
No, the driver doesn't. The chip does that.

[ ... ]

> Last couple of queries regarding the f71882fg driver:
> 
> What is the purpose of "pwmX_auto_channels_temp" (I have default
> values of 4, 2 and 1 for my 3 fans), "pwmX_auto_pointY_temp_hyst"

pwmX_auto_channels_temp Temperature input channel. Matches temp[1-4]_input to
the pwm channel X.

> and "pwmX_interpolate"? I think the latter could be a boolean value

pwmX_interpolate: Data sheet says "Set 1 will enable the interpolation of the
fan expect table", whatever that means. My guess is that, if enabled, the chip
does not just take the temperatures in the auto_point table and sets the
respective pwm value, but interpolates for temperatures in between.

pwmX_auto_pointY_temp_hyst is, as the name suggests, a hysteresis value.
pwm value increases if a temperature trip point is reached (from below),
and decreases to the previous value if the respective hysteresis point
is reached (from above).

> whether the f71882fg driver should interpolate values between the
> temperature points in order to determine fan speed, but can't be
> sure.
> 
> Also, is it possible to select which temperature reading should be
> used when selecting the fan speed? By default, to determine fan1's
> speed, temp1 is used and pwm1 value is then manipulated. Is it
> possible to instruct the driver to use a different sensor reading
> for the temperature in order to determine the speed of the fan?
> 

See above; you can use pwmX_auto_channels_temp for that purpose.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
