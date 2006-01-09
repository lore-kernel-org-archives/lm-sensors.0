From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 09 Jan 2006 08:09:54 +0000
Subject: [lm-sensors] Temp and voltage on Gigabyte MB
Message-Id: <20060109090954.2cbfbaa6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200601082152.57625.cpollock@earthlink.net>
In-Reply-To: <200601082152.57625.cpollock@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chris,

> This is only the 2nd time I've had to get lm_sensors to work so I may ask 
> some dumb questions. I installed a new Gigabyte GA-K8VM800M board with an 
> AMD Sempron 2800+ processor. After some false starts I finally got the 
> correct kernel modules installed and loaded. Sensors is working, however 
> I'm having problems with the the following:
> 
> Mboard temp jumps all over the place:
> Temp1/MB:    +45?F  (low  =  +261?F, high =  +104?F)   sensor = thermistor
> Temp1/MB:    +81?F  (low  =  +261?F, high =  +104?F)   sensor = thermistor   
> ALARM

Maybe it's simply not wired. I have a Gigabyte motherboard (K8V
Ultra-939) where the "motherboard temperature" is reported as a
constant 25 degrees C due to a lack of actual sensor. Does your BIOS
display a value for motherboard temperature? If not, there probably is
no sensor at all.

> Some voltages aren't right either I suspect:
> +3.3V:     +6.78 V  (min =  +3.14 V, max =  +3.46 V)   ALARM

I assume an IT87xxF chip. Search for the following statement in your
configuration file:

# If 3.3V reads 2X too high (Soyo Dragon and Asus A7V8X-X, for example),
# comment out following line.
    compute in2   2*@ , @/2

And just do that: comment out the compute line. I've changed the
default configuration file in that way a few weeks ago, as only a few
(old) motherboards seem to actually need this compute line.

> +5V:       +4.01 V  (min =  +4.76 V, max =  +5.24 V)   ALARM

Maybe not wired, or uses non-standard resistors. Is it stable? Is it
displayed in the BIOS setup screen?

> +12V:     +12.35 V  (min = +11.39 V, max = +12.61 V)   
> -12V:      -7.72 V  (min = -12.63 V, max = -11.41 V)   ALARM
> -5V:       -4.77 V  (min =  -5.26 V, max =  -4.77 V)   ALARM

See our FAQ (4.6.1):
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e6

As a rule of thumb, you may assume that any value which isn't presented
in your BIOS setup screen simply isn't wired on your motherboard, and
can be safely ignored. Just comment out any compute and set lines
related to that input, add an "ignore" statement for it, and you're
done.

You may want to take a look at the largely commented configuration file
I wrote for my own Gigabyte motherboard:
  http://khali.linux-fr.org/devel/lm-sensors/sensors-Gigabyte-K8V-Ultra-939.conf
Maybe some points apply to yours as well.

> I also noticed that when loading sensord that three lines 
> in /etc/sensors.conf are bad:
> 
> # Important - if your temperature readings are completely whacky
> # you probably need to change the sensor type. This must be done
> # with 'modprobe it87 temp_type=0xXX', you can't fix it in this file.
> # See ../doc/chips/it87 for details and valid 'XX' values!!!
> #
> ? ? label temp1 ? ? ? "Temp1/MB"
> ? ? set ? temp1_over ?40
> ? ? set ? temp1_hyst ?20 <----------------line 1194
> ? ? label temp2 ? ? ? "Temp2/CPU"
> ? ? set ? temp2_over ?45
> ? ? set ? temp2_hyst ?25 <----------------line 1197
> # ? ignore temp3
> ? ? label temp3 ? ? ? "Temp3"
> ? ? set ? temp3_over ?45
> ? ? set ? temp3_hyst ?25 <----------------line 1201

Wow. This is a _very_ old configuration file you started from. These
lines are indeed not correct, and were fixed back in January 2004. You
may want to start all over again from a shiny new default configuration
file:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/sensors.conf.eg

> I read through the docs on the it87 chip, but I'm really not sure what to 
> place on the modprobe it87 temp_type= line.  As far as I can tell I have 
> all the correct modules loaded:
> 
> i2c-isa ? ? ? ? ? ? ? ? 1600 ?0
> it87 ? ? ? ? ? ? ? ? ? 20332 ?0
> i2c-sensor ? ? ? ? ? ? ?2240 ?1 it87
> i2c-viapro ? ? ? ? ? ? ?5900 ?0
> i2c-dev ? ? ? ? ? ? ? ? 7616 ?0
> i2c-core ? ? ? ? ? ? ? 19060 ?5 i2c-isa,it87,i2c-sensor,i2c-viapro,i2c-dev
> 
> This is on a Mandrive 10.1 Official release with kernel 2.6.

The temp_type module parameter was replaced long ago. You now have to
use "set sensorN" lines (with N = 1, 2 or 3) to select the sensor type
(although the BIOS should really have set this up properly for you).
This is all documented in the latest sensors.conf.eg file.

-- 
Jean Delvare

