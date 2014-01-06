From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 06 Jan 2014 13:03:07 +0000
Subject: Re: [lm-sensors] wrong datas ?
Message-Id: <20140106140307.33e2c7ad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1388001150.7351.YahooMailBasic@web173205.mail.ir2.yahoo.com>
In-Reply-To: <1388001150.7351.YahooMailBasic@web173205.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Dec 2013 19:52:30 +0000 (GMT), linuxcbon wrote:
> Hi,
> I run ssensors version 3.3.4 with libsensors version 3.3.4. (got the same results with other versions).

Most important here is the kernel version, and the board brand and
model.

> # sensors
> it8718-isa-0228
> Adapter: ISA adapter
> in0:          +1.04 V  (min =  +0.00 V, max =  +4.08 V)
> in1:          +1.84 V  (min =  +0.00 V, max =  +4.08 V)
> in2:          +3.33 V  (min =  +0.00 V, max =  +4.08 V)
> +5V:          +3.01 V  (min =  +0.00 V, max =  +4.08 V)
> in4:          +3.04 V  (min =  +0.00 V, max =  +4.08 V)
> in5:          +3.22 V  (min =  +0.00 V, max =  +4.08 V)
> in6:          +4.08 V  (min =  +0.00 V, max =  +4.08 V)  ALARM
> in7:          +2.00 V  (min =  +0.00 V, max =  +4.08 V)
> Vbat:         +3.20 V  
> fan1:        1979 RPM  (min =   10 RPM)
> fan2:           0 RPM  (min =    0 RPM)
> fan3:           0 RPM  (min =    0 RPM)
> fan4:           0 RPM  (min =    0 RPM)
> temp1:        +34.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> temp2:        +35.0 C  (low  = +127.0 C, high = +70.0 C)  sensor = thermal diode
> temp3:        +44.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> cpu0_vid:    +1.050 V
> intrusion0:  OK
> 
> Remarks :
> Is it normal that +5V is displayed as  +3.01 V ? Or should it be renamed as +...something else ?

The IT8718F can monitor voltages up to 4 Volts directly, anything above
this limit requires scaling resistors, which must then be mentioned in
your configuration file so that "sensors" (or any libsensors-based
application) can compute the actual voltage. For example, try adding
the following to a new file under /etc/sensors.d:

chip "it8718-*"

    compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)

This should make the +5V line look reasonable. The exact scaling factor
depends on your board.

Note that other voltage inputs may need scaling factors too, in
particular +12V (which I suspect is connected to in4.) See this article
for how you can figure out the voltage labels and scaling factors:

http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling

in0 is most likely Vcore, in1 could be Vram if the system is using
DDR2, in2 would be +3.3V:

   label in0 "Vcore"
   label in1 "Vram"
   label in2 "+3.3V"

But first check if we do not already have a configuration file for your
board...

> in6 should not be ALARM ?

in6 reads 4.08 V which is the maximum supported by the ADC. This means
the pin is not wired to a real voltage input, so it can be ignored.
This can be done by adding the following statement to your
configuration file (in the right chip section):

   ignore in6

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
