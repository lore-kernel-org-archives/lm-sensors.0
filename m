From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Jun 2011 15:14:26 +0000
Subject: Re: [lm-sensors] NCT6775F driver
Message-Id: <20110616151426.GA18607@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
In-Reply-To: <BANLkTimDkWRZ53GL5erkDaFqqj3kJBOj9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 15, 2011 at 11:39:03PM -0400, Scott Lipcon wrote:
> Sorry, should have included that.   I think I can figure out computation
> factors, if I can figure out which BIOS voltage maps to which sensors
> voltage...  but since they're in different orders and there aren't the same
> number of them, I'm a bit confused.
> 
> 
> 
> nct6775-isa-0290
> Adapter: ISA adapter
> VCore:         +0.90 V  (min =  +0.50 V, max =  +1.74 V)   
> +12V:          +1.10 V  (min =  +2.04 V, max =  +2.04 V)   ALARM

That seems to be simple, factor 11.

> AVCC:          +3.41 V  (min =  +2.98 V, max =  +3.63 V)   
> +3.3V:         +3.41 V  (min =  +3.14 V, max =  +3.47 V)   

One of this is likely +5V, with factor 1.5. 

> +5V:           +1.06 V  (min =  +2.04 V, max =  +2.04 V)   ALARM
> +1.3V:         +1.06 V  (min =  +1.17 V, max =  +1.43 V)   ALARM

One of those seems to be PCH, the other memory with factor 1.5.
If you change the system load, one may change, possibly in line 
with the CPU voltage. This would then be PCH.

> VSB:           +3.42 V  (min =  +2.98 V, max =  +3.63 V)   
> VBAT:          +3.38 V  (min =  +2.40 V, max =  +3.60 V)   
> fan1:          594 RPM  (min =    0 RPM, div = 32)  ALARM
> fan2:         1054 RPM  (min =    0 RPM, div = 32)  ALARM
> fan3:          629 RPM  (min =    0 RPM, div = 32)  ALARM
> fan4:            0 RPM  (div = 128)
> SYSTIN:        +29.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor = diode
> CPUTIN:        +29.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = diode
> PECI Agent 0:  +38.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = diode
> PCH_CHIP_TEMP: +45.0 C                                    
> PECI Agent 1:   +0.0 C  (high = +80.0 C, hyst = +75.0 C)  
> cpu0_vid:     +2.050 V
> 
> 
> On Wed, Jun 15, 2011 at 11:07 PM, Ian Dobson <i.dobson@planet-ian.com> wrote:
> 
>     Hi,
> 
>     From: Scott Lipcon
>     Sent: Thursday, June 16, 2011 4:18 AM
>     To: Guenter Roeck
>     Cc: lm-sensors@lm-sensors.org
>     Subject: Re: [lm-sensors] NCT6775F driver
> 
>     OK, so I checked in BIOS, and its not clear what the right mapping is....
>     this is what I had in BIOS (in order)
> 
>     +12V = 12.14V   (min = 11.1, max = 12.9 )
>     +5V = 5.19V      (4.6 - 5.4 )
> 
>     +3.3V = 3.40V     ( 3.0 - 3.6)
> 
>     Memory VCC = 1.58  (0.4 - 2.0)
> 
>     Process Vcc = 1.15 (0.6 - 1.6)
> 
>     PCH Vcc = 1.07 (0.6 - 1.6)
> 
>     +3.3V Standby = 3.42 (3.0 - 3.6)
> 
> 
> 
> 
>     Not sure how these (7) map to the (8) that are shown in the sensors output
>     - the orders or names don't seem to line up.
> 
>     Any help?
> 
>     Thanks,
>     Scott
> 
> 
> 
>     On Wed, Jun 15, 2011 at 10:44 AM, Guenter Roeck <guenter.roeck@ericsson.com
>     > wrote:
> 
>         On Wed, Jun 15, 2011 at 09:01:20AM -0400, Scott Lipcon wrote:
>         > Hello,
>         >
>         > I've got a new machine - Intel DP67DE motherboard, Core i5 CPU.
>         >
>         > sensors-detect shows that it has a NCT6775F chip, so I've compiled
>         the driver
>         > from http://roeck-us.net/linux/drivers/w83627ehf/  and it
>         successfully detects
>         > and provides output, although I'm doubting some of the values, and
>         wanted to
>         > see if I could help debug/test driver updates.
>         >
>         > Here's the current output:
>         >
>         >
>         >
>         >  nct6775-isa-0290
>         > Adapter: ISA adapter
>         > VCore:         +0.89 V  (min =  +0.50 V, max =  +1.74 V)
>         > +12V:         +17.54 V  (min = +10.75 V, max = +13.18 V)   ALARM
>         > AVCC:          +3.41 V  (min =  +2.98 V, max =  +3.63 V)
>         > +3.3V:         +3.41 V  (min =  +3.14 V, max =  +3.47 V)
>         > +5V:           +4.19 V  (min =  +4.74 V, max =  +5.25 V)   ALARM
>         > +1.3V:         +1.06 V  (min =  +1.17 V, max =  +1.43 V)   ALARM
>         > VSB:           +3.42 V  (min =  +2.98 V, max =  +3.63 V)
>         > VBAT:          +3.38 V  (min =  +2.40 V, max =  +3.60 V)
>         > fan1:          620 RPM  (min =    0 RPM, div = 32)  ALARM
>         > fan2:         1054 RPM  (min =    0 RPM, div = 32)  ALARM
>         > fan3:          620 RPM  (min =    0 RPM, div = 32)  ALARM
>         > fan4:            0 RPM  (div = 128)
>         > SYSTIN:        +28.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  
>         sensor = diode
>         > CPUTIN:        +27.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor >         diode
>         > PECI Agent 0:  +32.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor >         diode
>         > PCH_CHIP_TEMP: +45.0 C
>         > PECI Agent 1:   +0.0 C  (high = +80.0 C, hyst = +75.0 C)
>         > cpu0_vid:     +2.050 V
>         >
>         >
>         >
>         > The voltages are a bit surprising - obviously the three with ALARM
>         are out of
>         > range.  I'm not sure if I can validate these in the BIOS but I'll try
>         tonight
>         > when I'm home, but somehow I really doubt my +12V is putting out
>         +17.5.
>         >
>         Agreed, that is unlikely. Most likely your sensors.conf entries,
>         specifically the
>         multiplication factors, are wrong. Try to run sensors -u to see the raw
>         output.
> 
>         > I'm not sure why the first 3 fans are showing ALARM, but the values
>         seem
>         > reasonable.  The motherboard only has 3 fan connectors, so fan4 = 0
>         makes
>         > sense.
>         >
>         Possibly you need to repeat the command a couple of times, to make the
>         alarm go away.
> 
>         Thanks,
>         Guenter
> 
> 
>     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
>    
>     _______________________________________________
>     lm-sensors mailing list
>     lm-sensors@lm-sensors.org
>     http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>      
>     And what does sensos show without any calculation factors for voltages?
>      
>     Regards
>     Ian Dobson
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
