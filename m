From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Oct 2008 07:05:09 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081020090509.5b342ce2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthew,

On Sun, 19 Oct 2008 19:02:57 +0100, Matthew Garrett wrote:
> On Sun, Oct 19, 2008 at 06:20:00PM +0200, Jean Delvare wrote:
> 
> > If you instead refer to a board-specific offset that should be applied
> > to compensate for the distance between the thermal sensor and the
> > graphics core, or for a non-standard thermal diode, the lm90 driver
> > exposes attribute temp2_offset so user-space can set and read the
> > temperature offset.
> 
> Right. My kernel driver is in the privileged position of knowing 
> precisely what offset should be applied to the lm90 readings, so doing 
> this in-kernel would be advantageous :)

There's nothing preventing you from accessing the LM99's registers
directly and retrieve the temperature that way. Alternatively, we could
add an internal interface to access some of the hwmon device features.
It would take some time to define something everybody agrees on. If you
have an interest in this, please make a proposal and we can discuss it.

> > Why do you want to retrieve the temperature value from the kernel?
> > Please explain your use case.
> 
> I'm implementing power management for GPUs. These typically have several 
> different performance constraints, but one of them is chip temperature. 
> The maximum supported temperature is generally exported via tables in 
> the graphics card BIOS, so it's necesssary for the kernel driver to be 
> aware of the current temperature in order to limit the available 
> performance modes to ensure the GPU stays within its thermal envelope.

OK, I see. Then indeed it makes sense to deviate from the traditional
hwmon model. You could prevent auto-detection of the hwmon device (by
dropping I2C_CLASS_HWMON from i2c_adapter.class) and instantiate the
lm99 device manually instead (using i2c_new_device()). This gives you
two things: a handle on the created device (so that you can access the
chip registers directly if needed, and its private data too) and the
possibility to pass platform data to the driver for specific
initialization purposes. The lm90 driver doesn't implement the later
yet, but we have another driver doing that (lm87) so it could be added
if needed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
