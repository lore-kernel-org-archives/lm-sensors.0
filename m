From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 23 May 2005 09:45:55 +0000
Subject: [lm-sensors] report of sensor inaccuracy for hardware
Message-Id: <2oJiCVq7.1116833861.6636470.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050523035157.47128.qmail@web30911.mail.mud.yahoo.com>
In-Reply-To: <20050523035157.47128.qmail@web30911.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stewart,

> Hardware is Asus A7V8X-X (with AMD Athlon XP 1700 cpu)
> (...)
> # sensors
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.79 V  (min =  +1.42 V, max =  +1.57 V)  ALARM
> VCore 2:   +0.00 V  (min =  +2.40 V, max =  +2.61 V)  ALARM
> +3.3V:     +6.72 V  (min =  +3.14 V, max =  +3.46 V)  ALARM
> +5V:       +4.92 V  (min =  +4.74 V, max =  +5.24 V)
> +12V:     +12.16 V  (min = +11.40 V, max = +12.60 V)
> -12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)  ALARM
> -5V:      -13.64 V  (min =  -5.24 V, max =  -4.76 V)  ALARM
> Stdby:     +4.89 V  (min =  +4.74 V, max =  +5.24 V)
> VBat:      +4.08 V
> fan1:     4192 RPM  (min =     RPM, div = 2)
> fan2:         RPM  (min = 3000 RPM, div = 2)          ALARM
> fan3:         RPM  (min = 3000 RPM, div = 2)          ALARM
> M/B Temp:    +36 C  (low  =   +15 C, high =   +40 C) sensor = thermistor
> CPU Temp:    +30 C  (low  =   +15 C, high =   +45 C) sensor = thermistor
> Temp3:        -1 C  (low  =   +15 C, high =   +45 C) sensor = disabled
>
> Fan2 is missing (does show in Bios/Setup)

FAQ 4.1.1

"Q: Fans sometimes/always read 0!!
(...)
A: You may need to increase the 'fan divisor'. See doc/fan-divisors in
our package for further information."

In other words, adding:
   set fan2_div 4
   set fan3_div 4
to the it8712-* section of your /etc/sensors.conf file should solve the
problem.

> M/B Temp and CPU Temp are reversed.

From the default sensors.conf, it8712-* section:

"
# The A7V8X-X has temperatures inverted, and needs a conversion for
# CPU temp. Thanks to Preben Randhol for the formula.
#   label temp1       "CPU Temp"
#   label temp2       "M/B Temp"
#   compute temp1     (-15.096+1.4893*@), (@+15.096)/1.4893
"

The compute line may or may not work for you, BTW.

> voltages are ... interesting.

And can easily be tinkered with:

> VCore 1:   +1.79 V  (min =  +1.42 V, max =  +1.57 V)  ALARM

If VID works for you, comment out "ignore vid" and use:
   set in0_min vid*0.95
   set in0_max vid*1.05
If VID isn't correct, hardcode the nominal Vcore value for you CPU:
   set in0_min 1.75*0.95
   set in0_max 1.75*1.05

> VCore 2:   +0.00 V  (min =  +2.40 V, max =  +2.61 V)  ALARM

Seems to be wired to ground, so you would comment out these lines:
#   set in1_min 2.4
#   set in1_max 2.6
and add:
   ignore in1

> +3.3V:     +6.72 V  (min =  +3.14 V, max =  +3.46 V)  ALARM

From the default sensors.conf, it8712-* section:

"
# If 3.3V reads 2X too high (Soyo Dragon and Asus A7V8X-X, for example),
# comment out following line.
    compute in2   2*@ , @/2
"

So just comment out this compute line. (I think it should be the default
BTW.)

> +5V:       +4.92 V  (min =  +4.74 V, max =  +5.24 V)
> +12V:     +12.16 V  (min = +11.40 V, max = +12.60 V)

These ones are OK.

> -12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)  ALARM
> -5V:      -13.64 V  (min =  -5.24 V, max =  -4.76 V)  ALARM

Most probably not connected, as per FAQ 4.6.1:

"Q: -5V and -12V readings are way out of range!

A: It's very frequent that negative voltage lines are not wired because
motherboard manufacturers don't think they're worth monitoring (they
are mostly unused these days). You can just add ignore inN lines to
/etc/sensors.conf to hide them."

Additionally, I'd invite you to comment out set in{5,6}_(min,max} lines
so as to prevent irrelevant alarms and speed up "sensors -s".

> Stdby:     +4.89 V  (min =  +4.74 V, max =  +5.24 V)

This one is OK.

> VBat:      +4.08 V

Overflow here, no idea what Asus made with this one.

> The only module I didn't load is eeprom, as I can't
> find it in kernel-config.

You should find it at:
Hardware sensors support > Other I2C devices > EEprom (DIMM) reader

But this is unrelated with your sensors readings, which will be improved
only by tweaking the it7812-* section of /etc/sensors.conf as described
earlier.

--
Jean Delvare
