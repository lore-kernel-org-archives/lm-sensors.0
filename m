From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Jun 2010 21:06:05 +0000
Subject: Re: [lm-sensors] Too low temp readings on overclocked Intel Atom CPU
Message-Id: <20100621230605.2c0df205@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
In-Reply-To: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Ulf,

On Mon, 21 Jun 2010 12:19:50 +0200, Ulf Granlund wrote:
> 
> Hello,
> I am running an Asrock Ion computer under Ubuntu 10.4. It has four Intel Atom CPU cores. In the Asrock BIOS thereis an option to introduce overclocking. I have set the frequency to 1800 MHz insetad of the standard 1600 MHz.

By doing this, you are unsupported. If you decide to use your hardware
beyond its specification, you shouldn't be surprised if it fails.

Please tell us the exact CPU model.

Do you know if the overclocking alters only the frequency, or also the
CPU core voltage?

> After having the computer switched on for several hours, but the CPU:s mainly idle, the output from the sensors command is as below,in a room where ambient temperature is about 22 C.
> coretemp-isa-0000Adapter: ISA adapterCore 0:       +4.0°C  (crit = +90.0°C)                  
> coretemp-isa-0001Adapter: ISA adapterCore 1:      +16.0°C  (crit = +90.0°C)                  
> coretemp-isa-0002Adapter: ISA adapterCore 2:       +3.0°C  (crit = +90.0°C)                  
> coretemp-isa-0003Adapter: ISA adapterCore 3:      +16.0°C  (crit = +90.0°C)

This is horribly formatted.

> Clearly these temperatures are way too low.However, if I set the processor frequency to the standard 1600 MHz,I get:
> coretemp-isa-0000Adapter: ISA adapterCore 0:      +17.0°C  (crit = +90.0°C)                  
> coretemp-isa-0001Adapter: ISA adapterCore 1:      +25.0°C  (crit = +90.0°C)                  
> coretemp-isa-0002Adapter: ISA adapterCore 2:      +18.0°C  (crit = +90.0°C)                  
> coretemp-isa-0003Adapter: ISA adapterCore 3:      +25.0°C  (crit = +90.0°C) 
> Which at least seems far more reasonable.

This is very interesting. Adding the coretemp driver maintainer in Cc.

> It seems that the more I overclock, the lower the temperature readings get.Can somebody explain how to get correct temp readings? It is of course more importantto me to get correct readings in the overclocked situation than in the standard situation...
> The lm-sensors version used is 3.1.2 and the linux kernel version is 2.6.32.

First thing to check is: do the temperature values increase or decrease
when you load the CPUs?

Then I guess you could give a try to the latest version of the driver,
as it received changes recently:
http://khali.linux-fr.org/devel/misc/coretemp/

But anyway, odds are that the sensors are affected by overclocking and
nothing can be done, except: don't do it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
