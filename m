From: Curt.Blank@curtronics.com (Curt Blank)
Date: Fri, 23 Mar 2007 03:00:53 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use w83627ehf
Message-Id: <460342E5.1000301@curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
In-Reply-To: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jan,

Thanks.

Jan van Tiggelen wrote:
> Curt, hi,-
> 
> Assuming that you've figured out a correct setting for your FAN divisors,
> last thing left to do is setting right labels and Vin calculation for the
> other channels.

The divisors were ok out of the box, I was just trying to change 4 & 5 
to see if there where fans connected before I had the schematic and it 
showed there were no fans connected.

> 
> So, based on your feedback of voltage levels, and with the schematics of the
> MSI K9N4 SLI-F and the pre-set definitions of the W83627EHF calculations I
> could suggest for sensors.conf:
> 
> chip "w83627dhg-*"
> 
> labels:
> label in0 "VCore"
> label in1 "+12V"
> label in2 "5V"
> label in3 "-12V"
> label in5 "AVCC"
> label in7 "VSB"
> label in8 "VBAT"
> 
> computations:
> compute in1 @*(1+(56/10)), @/(1+(56/10))
> compute in2 @*(1+(22/10)), @/(1+(22/10))
> compute in3 -@*(1+(56/10)), -@/(1+(56/10))
> 
> Let me know if this gives you the correct readings. If it's not, I'll try
> and get the values for Rin and Rf.

I'll give this a try.

> 
> And for the FAN labels:
> Label fan3 "Northbridge Fan"

I did already. :)

> 
> 
> Honestly speaking: for the voltage computations I lost track a bit, since
> 627EH is derived from 781D in turn...
> Maybe you could post a better update, with the mainboard on hand?

Ok, but what do you mean by a better update? And MB on hand?

Here's the results of plugging in your equations:

w83627dhg-isa-0a10
Adapter: ISA adapter
VCore:     +1.23 V  (min =  +0.00 V, max =  +1.74 V)
+12V:     +12.30 V  (min =  +6.97 V, max =  +5.23 V)
5V:       +10.44 V  (min =  +7.48 V, max = +10.75 V)
-12V:     -21.54 V  (min =  -5.91 V, max = -18.27 V)
in4:       +1.54 V  (min =  +1.23 V, max =  +0.02 V)
AVCC:      +1.46 V  (min =  +0.24 V, max =  +0.78 V)
in6:       +1.61 V  (min =  +0.17 V, max =  +0.53 V)
VSB:       +3.26 V  (min =  +2.18 V, max =  +2.26 V)
VBAT:      +2.99 V  (min =  +2.08 V, max =  +0.86 V)

-Curt

> 
> Kind regards,
> 
> Jan van Tiggelen
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

