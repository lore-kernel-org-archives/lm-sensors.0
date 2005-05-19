From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: Gigabyte GA7-VRXP
Message-Id: <20030704231948.056d10a8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


First, thank you for your fast and complete answer! I hadn't expected so
much :)

> > What is the revision of your motherboard?
> 
> 2.0

Great, this is the one that is supposed to have a LM83 on it, as seen on
this page:
http://mbm.livewiredev.com/comp/gigabyte.html

> > Did you ever installed LM Sensors on one of your systems?
> 
> I have, and some of the outputs are valid, while others are not.
> 
> $ sensors -v
> sensors version 2.7.0

Great that you're already used to LM Sensors. We'll probably have to
tweak a pair of files to make everything work, so it's better that you
know the basics of our package.

> $ sensors   
> lm78-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.74 V  (min =  +0.00 V, max =  +1.32 V)   ALARM
> VCore 2:   +1.24 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> +3.3V:     +3.31 V  (min =  +2.97 V, max =  +0.00 V)   ALARM
> +5V:       +4.84 V  (min =  +4.50 V, max =  +5.48 V)   ALARM
> +12V:     +12.16 V  (min = +10.79 V, max = +13.11 V)   ALARM
> -12V:      -5.32 V  (min = -13.18 V, max = -10.78 V)   ALARM
> -5V:       -1.38 V  (min =  -5.48 V, max =  -4.50 V)   ALARM
> fan1:       -1 RPM  (min = 6000 RPM, div = 1)          ALARM
> fan2:     25471 RPM  (min = 6000 RPM, div = 1)          
> fan3:     3358 RPM  (min = 3000 RPM, div = 2)          ALARM
> temp:      -68.0?C  (limit =  +60?C, hysteresis =  +50?C) ALARM
> vid:       +3.50 V
> alarms:   Board temperature input (LM75)               ALARM
> alarms:   Chassis intrusion detection                  ALARM
> 
> As you can see the sensors for the temperature, -5V and -12 are "less
> optimal" wrt their output.

What I see here is that you don't have a LM78. I think the chip has been
misdetected. You are supposed to have an IT87 as your main sensor chip
(actually, a SiS950 which is compatible with the IT87) using the it87
driver.

> > Would you accept to test my driver?
> 
> It would be a pleasure.

Really glad to read that :)

> Ok, much better now:
> $ sensors -v
> sensors version 2.8.0-CVS

Hey, you have been doing much much more than I'd have expected :)

> # lsmod
> Module                  Size  Used by    Tainted: PF 
> it87                    6636   0  (unused)
> eeprom                  3572   0  (unused)
> lm83                    3296   0  (unused)
> i2c-isa                  748   0  (unused)
> i2c-dev                 4128   0 
> i2c-viapro              3468   0 
> lm78                    7000   0  (unused)
> i2c-proc                6708   0  [it87 eeprom lm83 lm78]
> i2c-core               14820   0  [it87 eeprom lm83 i2c-isa i2c-dev
>                                    i2c-viapro lm78 i2c-proc]

I think you can unload the lm78 module, it won't be used anyway. The
rest of the modules look OK. Did the new sensors-detect tell you to
still use the lm78 module? This would need to be fixed.

BTW, the complete output (using script for example) of sensors-detect
would be very welcome. I'd like to see if it behaves as it should.

> $ sensors
> eeprom-i2c-0-50
> Adapter: SMBus Via Pro adapter at 0400
> Algorithm: Non-I2C SMBus adapter
> Memory type:            DDR SDRAM DIMM SPD
> Memory size (MB):       512

Do you have a single memory chip on the system, or is the second one not
detected?

> it87-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.72 V  (min =  +1.42 V, max =  +1.56 V)   ALARM
> VCore 2:   +1.24 V  (min =  +2.40 V, max =  +2.60 V)   ALARM
> +3.3V:     +6.62 V  (min =  +3.12 V, max =  +3.44 V)   ALARM
> +5V:       +4.80 V  (min =  +4.72 V, max =  +5.24 V)   
> +12V:     +12.84 V  (min = +11.36 V, max = +12.60 V)   ALARM
> -12V:     -14.24 V  (min = -12.63 V, max = -11.41 V)   ALARM
> -5V:       -7.15 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
> Stdby:     +5.04 V  (min =  +4.72 V, max =  +5.24 V)   
> VBat:      +0.00 V
> fan1:     2848 RPM  (min =    0 RPM, div = 2)          
> fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> Temp1/MB:    +54?C  (min =  +20?C, max =  +40?C) 
> Temp2/CPU:   +87?C  (min =  +25?C, max =  +45?C) 
> Temp3:       -55?C  (min =  +25?C, max =  +45?C)

This is far better than with lm78, isn't it? :) Some things would need
tweaking though. +3.3V needs to be correcting as described in the
/etc/sensors.conf file (this is a known problem). Fans 2 and 3 are
probably not present and should be ignored. Temp3 is probably not used
(-55 is a common value to mean "no diode connected") and should be
ignored too (add ignore statements in config file). BTW, please note
that the config file is *not* overwritten by lm_sensors installations,
which in a way is great since it will keep your own changes, but on the
other hand could make you miss updates we do on the default config file.

> The CPU temp can't be right, I use a XP2100+ with a Spire WhisperRock
> III cooler, which seems very adaquate.
> In the BIOS the monitor tells me both CPU and MB reach about 54
> deg. C.

The it87 module has a temp_type parameter that should help. Try
temp_type=0x38 and see if it's any better. If not (it could say -55 as
temp3) it may mean that these sensors are not used, and this would make
sense because the LM83 that is supposed to be present on your
motherboard is a 4-temperature sensor.

> No problems making and installing Jean, so thanks for mentioning this
> update and your work on the driver of course.

You're welcome. Actually I need you more than you need me.

The problem now is that the lm83 data doesn't show at all, while it is
supposed to. Could you please:
1* Tell me what you see in /proc/bus/i2c* (file names and contents)?
2* Tell me what you see in /proc/dev/sensors/ (file names and contents)?
3* Recompile the whole lm_sensors2 package using the DEBUG option (see
the main Makefile)? I added some debug prints that should show in you
system logs. This would be more than useful for debugging.

If you encounter any problem compiling/installing the CVS checkouts,
please let me know. We plan to release 2.8.0 soon now.

If you are used to IRC, you may meet me on #sensorstuff on Freenode
(nick Khali). This may make the driver debugging faster :)

Thanks a lot again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
