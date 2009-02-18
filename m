From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Feb 2009 14:03:23 +0000
Subject: Re: [lm-sensors] [Bulk] Re:  Cannot make ver 3.0.3
Message-Id: <20090218150323.16473c7c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <499AF1B7.5020703@yahoo.co.uk>
In-Reply-To: <499AF1B7.5020703@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dave,

On Wed, 18 Feb 2009 14:52:15 +0100, DB wrote:
> Did the 'make install', which seemed successful on the 3rd attempt (it 
> spat out a couple of file problems which I took care of....)

That's pretty strange, "make install" only copies file around, it
shouldn't take more than a single attempt. You seem to have a strange
system...

> I've run sensors-detect, sensors -s, and even sensors -c 
> /etc/sensors3.conf -s, but still the labels as set in sensors3.conf are 
> not appearing.... Any idea what I have done wrong?
> 
> My sensors3.conf (clipped out of the original since I only have the 
> K7S5A board)
> 
> #(from /etc/sensors3.conf)
> 
> chip "lm78-*" "lm79-*" "w83781d-*"

This line says for which chips the following statements apply...

> 
> # These are as advised in the LM78 and LM79 data sheets, and used on almost
> # any mainboard we have seen.
> 
> label in0 "VCore 1"
> label in1 "VCore 2"
> label in2 "+3.3V"
> label in3 "+5V"
> label in4 "+12V"
> label in5 "-12V"
> label in6 "-5V"
> 
> # Elite Group K7S5A board
> #
> # compute in5 -(36/10)*@, -@/(36/10)
> # compute in6 -(56/10)*@, -@/(56/10)
> #
> compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)
> 
> set in0_min 1.5 * 0.95
> set in0_max 1.5 * 1.05
> set in1_min 2.4
> set in1_max 2.6
> set in2_min 3.3 * 0.95
> set in2_max 3.3 * 1.05
> set in3_min 5.0 * 0.95
> set in3_max 5.0 * 1.05
> set in4_min 12 * 0.95
> set in4_max 12 * 1.05
> set in5_max -12 * 0.95
> set in5_min -12 * 1.05
> set in6_max -5 * 0.95
> set in6_min -5 * 1.05
> set in7_min 5 * 0.95
> set in7_max 5 * 1.05
> #the chip does not support in8 min/max
> 
> # Temperature
> #
> # Important - if your temperature readings are completely whacky
> # you probably need to change the sensor type.
> # Adujst and uncomment the appropriate lines below.
> #
> # 2 = thermistor; 3 = thermal diode; 0 = unused
> # set temp1_type 3
> # set temp2_type 3
> # set temp3_type 3
> # If a given sensor isn't used, you will probably want to ignore it
> # (see ignore statement right below).
> 
> ignore temp1
> label temp1 "Temp 1"
> set temp1_max 40
> set temp1_min 15
> label temp2 "M/B Temp"
> set temp2_max 45
> set temp2_min 15
> label temp3 "CPU Temp"
> set temp3_max 45
> set temp3_min 15
> 
> And the response from my system:
> 
> root@Fedora-Blue Dave]# sensors -c /etc/sensors3.conf -s
> [root@Fedora-Blue Dave]# sensors
> it87-isa-0290

... but it doesn't match your chip. Your configuration file should
start with:

chip "it87-*"

> Adapter: ISA adapter
> in0: +1.73 V (min = +0.00 V, max = +4.08 V)
> in1: +2.46 V (min = +0.00 V, max = +4.08 V)
> in2: +3.33 V (min = +0.00 V, max = +4.08 V)
> in3: +2.93 V (min = +0.00 V, max = +4.08 V)
> in4: +3.02 V (min = +0.00 V, max = +4.08 V)
> in5: +3.44 V (min = +0.00 V, max = +4.08 V)
> in6: +1.14 V (min = +0.00 V, max = +4.08 V)
> in7: +3.01 V (min = +0.00 V, max = +4.08 V)
> in8: +3.42 V
> fan1: 2376 RPM (min = 0 RPM, div = 8)
> fan2: 3183 RPM (min = 0 RPM, div = 8)
> fan3: 0 RPM (min = 0 RPM, div = 2)
> temp1: +12.0?C (low = -1.0?C, high = +127.0?C) sensor = transistor
> temp2: +27.0?C (low = -1.0?C, high = +127.0?C) sensor = transistor
> temp3: +48.0?C (low = -1.0?C, high = +127.0?C) sensor = transistor
> 
> Thanks for your help

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
