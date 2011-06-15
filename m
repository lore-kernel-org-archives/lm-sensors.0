From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 15 Jun 2011 14:44:39 +0000
Subject: Re: [lm-sensors] NCT6775F driver
Message-Id: <20110615144439.GB12757@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
In-Reply-To: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 15, 2011 at 09:01:20AM -0400, Scott Lipcon wrote:
> Hello,
> 
> I've got a new machine - Intel DP67DE motherboard, Core i5 CPU.
> 
> sensors-detect shows that it has a NCT6775F chip, so I've compiled the driver
> from http://roeck-us.net/linux/drivers/w83627ehf/  and it successfully detects
> and provides output, although I'm doubting some of the values, and wanted to
> see if I could help debug/test driver updates.   
> 
> Here's the current output:
> 
> 
> 
>  nct6775-isa-0290
> Adapter: ISA adapter
> VCore:         +0.89 V  (min =  +0.50 V, max =  +1.74 V)   
> +12V:         +17.54 V  (min = +10.75 V, max = +13.18 V)   ALARM
> AVCC:          +3.41 V  (min =  +2.98 V, max =  +3.63 V)   
> +3.3V:         +3.41 V  (min =  +3.14 V, max =  +3.47 V)   
> +5V:           +4.19 V  (min =  +4.74 V, max =  +5.25 V)   ALARM
> +1.3V:         +1.06 V  (min =  +1.17 V, max =  +1.43 V)   ALARM
> VSB:           +3.42 V  (min =  +2.98 V, max =  +3.63 V)   
> VBAT:          +3.38 V  (min =  +2.40 V, max =  +3.60 V)   
> fan1:          620 RPM  (min =    0 RPM, div = 32)  ALARM
> fan2:         1054 RPM  (min =    0 RPM, div = 32)  ALARM
> fan3:          620 RPM  (min =    0 RPM, div = 32)  ALARM
> fan4:            0 RPM  (div = 128)
> SYSTIN:        +28.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor = diode
> CPUTIN:        +27.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = diode
> PECI Agent 0:  +32.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = diode
> PCH_CHIP_TEMP: +45.0 C                                    
> PECI Agent 1:   +0.0 C  (high = +80.0 C, hyst = +75.0 C)  
> cpu0_vid:     +2.050 V
> 
> 
> 
> The voltages are a bit surprising - obviously the three with ALARM are out of
> range.  I'm not sure if I can validate these in the BIOS but I'll try tonight
> when I'm home, but somehow I really doubt my +12V is putting out +17.5.   
> 
Agreed, that is unlikely. Most likely your sensors.conf entries, specifically the 
multiplication factors, are wrong. Try to run sensors -u to see the raw output.

> I'm not sure why the first 3 fans are showing ALARM, but the values seem
> reasonable.  The motherboard only has 3 fan connectors, so fan4 = 0 makes
> sense.   
> 
Possibly you need to repeat the command a couple of times, to make the alarm go away.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
