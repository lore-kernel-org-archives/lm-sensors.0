From: jumpyboy@infinito.it (Gianni)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: lm_sensors 2.8.3
Message-Id: <200401311944.53557.jumpyboy@infinito.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401291139.58838.jumpyboy@infinito.it>
In-Reply-To: <200401291139.58838.jumpyboy@infinito.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alle 19:38, venerd? 30 gennaio 2004, Jean Delvare ha scritto:
> > it87-isa-0290
> > Adapter: ISA adapter
> > Algorithm: ISA algorithm
> > VCore 1:   +1.76 V  (min =  +1.53 V, max =  +1.87 V)
> > VCore 2:   +0.00 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
> > +3.3V:     +6.46 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
> > +5V:       +4.86 V  (min =  +4.50 V, max =  +5.48 V)
> > +12V:     +12.52 V  (min = +11.36 V, max = +13.80 V)
> > -12V:     -27.36 V  (min = -15.86 V, max = -13.40 V)   ALARM
> > -5V:      -13.64 V  (min = -10.13 V, max =  -9.44 V)   ALARM
> > Stdby:     +4.97 V  (min =  +4.50 V, max =  +5.48 V)
> > VBat:      +4.08 V
> > fan1:     3729 RPM  (min = 3000 RPM, div = 2)
> > fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> > fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> > ERROR: Can't get TEMP1 data!
> > ERROR: Can't get TEMP2 data!
> > ERROR: Can't get TEMP3 data!
> > (...)
> > Why I cannot get temperature?
>
> This is a FAQ. Support for the it87 is broken in the Linux 2.6.1 +
> lm_sensors 2.8.3 combination, which is the one you are using. Either
> downgrade to lm_sensors 2.8.2 or upgrade to lm_sensors CVS.
>
I have taken the CVS version. Ok.
> > All those ALARM depend on /etc/sensors.conf? I have to change that file?
>
> First of all, make sure you did not forget to run "sensors -s". This
> configures the chipset.
>
> Then, yes you have to edit /etc/sensors.conf. Look for the "it87-*"
> section and edit to fit your hardware. You obviously can add "ignore"
> statements for in1 (VCore 2) and probably fan2 and fan3 (I guess you
> don't have these fans).
>
> For +3.3V, there's a line to change in the configuration file. It's
> commented inside, you should find it easily.
>
Done.
> Your values for negative voltages are really strange. If they don't get
> any better after you running "sensors -s", it may simply mean that these
> inputs are not wired to the monitoring chipset and you can ignore them
> too. If your BIOS setup screen shows some hardware monitoring values but
> there's nothing for negative voltages, it's probably the case.
Now I've got:
sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.76 V  (min =  +1.56 V, max =  +1.72 V)   ALARM <<-- is it 
dangerous? It is stable to this value and for XP is 1.65 Volt.
+3.3V:     +3.23 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.89 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.52 V  (min = +11.36 V, max = +12.60 V)
Stdby:     +4.97 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +4.08 V
fan1:     3668 RPM  (min =    0 RPM, div = 2)
CPU Temp:    +58?C  (low  =   +43?C, high =   +43?C)   sensor = thermistor <-- 
this is right but I think in winter is too much.
M/B Temp:    -39?C  (low  =   +15?C, high =   +45?C)   sensor = invalid
Temp3:      +127?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor <-- 
What does it need?

eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at e800
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

Why M/B temp is negative? A lm_sensors2 bug or a bad settings into 
sensors.conf? From BIOS I get that temperature, maybe we need to know the 
formula tu calculare M/B temperature of Asus A7V600?
Thank you for all,
Gianni
