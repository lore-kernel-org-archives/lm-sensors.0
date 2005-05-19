From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Query on apparently 'disconnected' sysfs interfaces
Message-Id: <20050319102224.36039cc1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
In-Reply-To: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> > > analog_out
> > > aout_output	< analog_out ?
> > > out0_output
> >
> > This is the same thing. If we follow the naming convention for the
> > other channels, the correct one would be out0_output. Should be
> > documented, and drivers using analog_out and aout_output should be
> > fixed.
>
> okay, but I prefer analog in name because some drivers have digital 
> out -- GPIO pins. analog0_out?

GPIO pins are not digital out. They can as well be digital in, and we
won't rename in0 to analog0_in because of it. Thus I don't see any
problem with the out0_output name. Hardware monitoring chips are analog
by nature (for voltages and temperatures), so it's quite natural not to
mention "analog" on all analog inputs.

> Any chips out there with multi-channel DAC's?

Not that I know of.

> Currently we have three chips with a single analog_out:
> lm87, adm1026 and adm9240 (so far).

You forgot pcf8591, so it's 4 chips.

That being said, I still believe that, for hardware monitoring chips
(which excludes the pcf8591), analog out is meant for fan control, which
means that it makes everyone's life easier if we name it pwm1. Some
driver already do (w83627hf for the W83627THF chip). Agreed, the pwmN
files should have been named fanN_speed or something like that, but it's
a bit late to change this again now... Maybe we can add pwmN_mode with
values "DC" and "PWM". Some chips can do both (W83792D I think).

Thanks,
-- 
Jean Delvare
