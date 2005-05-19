From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: PC87366 with the net4801
Message-Id: <200406280814.i5S8EBqR095973@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Upon further examination, I'm now noticing a problem -- wild temperature
>swings.
>
>soekris1# sensors
>pc87366-isa-6620
>Adapter: ISA adapter
>in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
>in1:       +2.24 V  (min =  +1.18 V, max =   1.45 V)       ALARM
>in2:       +2.79 V  (min =  +0.00 V, max =   2.95 V)
>in3:       +0.77 V  (min =  +0.00 V, max =   2.95 V)
>in4:       +2.76 V  (min =  +0.00 V, max =   2.95 V)
>in5:       +2.78 V  (min =  +1.27 V, max =   1.55 V)       ALARM
>in6:       +0.00 V  (min =  +1.18 V, max =   1.45 V)       ALARM
>Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
>Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
>Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
>AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM
>temp4:       +28 C  (low  =    -0 C, high =   +85 C)
>temp4_crit:
>              -9 C
>temp5:       +31 C  (low  =    -0 C, high =   +85 C)
>temp5_crit:
>              -9 C
>
>soekris1# sensors
>pc87366-isa-6620
>Adapter: ISA adapter
>in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
>in1:       +2.24 V  (min =  +1.18 V, max =   1.45 V)       ALARM
>in2:       +2.78 V  (min =  +0.00 V, max =   2.95 V)
>in3:       +0.77 V  (min =  +0.00 V, max =   2.95 V)
>in4:       +2.76 V  (min =  +0.00 V, max =   2.95 V)
>in5:       +2.77 V  (min =  +1.27 V, max =   1.55 V)       ALARM
>in6:       +0.00 V  (min =  +1.18 V, max =   1.45 V)       ALARM
>Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
>Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
>Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
>AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM
>temp4:       +39 C  (low  =    -0 C, high =   +85 C)
>temp4_crit:
>              -9 C
>temp5:       +41 C  (low  =    -0 C, high =   +85 C)
>temp5_crit:
>              -9 C
>
>This may sound strange, but it seems like the more I run sensors, the higher
>the temperature goes. If I let it "rest" for a while by not running sensors,
>the readings seem to return to 20-25C. They *seem* to stay there as long as
>I don't run sensors too often. Running sensors two or more times in quick
>succession will almost always yield the swings.

Admittedly weird, especially since thermistor-based measurements are
passive (while thermal diode measurements are active). At any rate,
running "sensors" doesn't trigger the physical measurements. These
are done in the background, whether you read them or not. So I have no
explanation to what you see.

You may try the following command:

isaset -f 0x6627 0x02

It'll increase the sampling rate (at the cost of power consumption, I
suppose). You can revert to the old speed at any time using:

isaset -f 0x6627 0x00

Let me know if it changes anything.

Once again, it would be very valuable to know for sure from Soekris if we
are dealing with thermistors, and of what kind.

Jean Delvare
