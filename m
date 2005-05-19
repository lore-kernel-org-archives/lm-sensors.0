From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <vciv71p672rmbavi4s203av76j240dhtsb@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Mon, 9 May 2005 15:35:36 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>> but if driver scaling has been vetoed, I'd rather know now than
>> submit something unwanted.  lm87 driver almost has it, carrying
>> scaling factors in private memory, loaded at chip detect time.
>
>The rule is: drivers should provide the voltages as seen at their pins.

Yes, so the Winbond drivers (at least w82627hf) do not report pin 
voltage for 5V and 5VSB thus need this or similar fix.

>This means that, where scaling is external, it has to be done in
>user-space, while where scaling is internal, it has to be done by the
>driver itself. All drivers respect that rule as far as I remember.

Except the exceptions :)

>> * These sensor chips perform internal scaling for 5V (in3) and 5VSB
>
>I don't think so. Can you point us to a datasheet stating this?

Any Winbond datasheet :)

W83L784R 6.3.1:
"The first function is to supply internal analog power in the W83L784R 
and the second function is that this voltage with 5V is connected to 
internal serial resistors to monitor the +5V voltage. The value of 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
two serial resistors are 34K ohms and 50K ohms so that input voltage 
                         ^^^^^^^^^^^^^^^^^^^^^
to ADC is 2.98V which is less than 4.096V of ADC maximum input voltage."

W83627HF:
"The first function is to supply internal analog power in the W83627HF 
and the second function is that this voltage with 5V is connected to 
internal serial resistors to monitor the +5V voltage. The value of two 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
serial resistors are 34K ohms and 50K ohms so that input voltage to ADC
                     ^^^^^^^^^^^^^^^^^^^^^
is 2.98V which is less than 4.096V of ADC maximum input voltage.

The Pin 61 is connected to 5VSB voltage. W83627HF monitors this voltage 
and the internal two serial resistors are 17K W and 33K W so that input 
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^-- W is ohm symbol
voltage to ADC is 3.3V which less than 4.096V of ADC maximum input voltage."

W83627THF Section 7.3.1 pin 114, pin 61 34k, 51k

Need I go on?  I surveyed every datasheet I could find (w83697hf circuit 
overlay problem been fixed too).
>
>> Comments?
>
>Your code makes sense for external resistors, but not for internal
>scaling as far as I can see, so it won't be of any help in the drivers.

Okay another exception for Winbond chips.  But this method can go 
either place, driver or user-space, I'm trying to demonstrate a 
different way of doing scaling that suits end-user calibration, as 
well as point out where drivers differ from sysfs standard usage.

>And libsensors mostly works the way you describe already, just not in as
>formal a way (because compute lines were meant for all values, not just
>voltages).

libsensors compute lines suit most situations, I hit one where it 
fails, plus the silliness (IMHO) of entering every formula twice, 
parameter based scaling avoids that, what I'm discussing here is 
something for voltages, that seems to work very well.  Whether it 
gets into sensors as an alternate compute method, or is a utility 
that produces 'normalised' compute terms doesn't really matter in 
long run.

The benefit of doing resistor based scaling is that resistor value 
are in a discrete value series so one may pick an unambiguous pair 
for a particular positive or negative voltage reading.  A user-space 
program can take observed reading (BIOS or measured) and produce 
'best match' pair that works, as mobo maker using same discrete 
value series.

You did ask me once how to do scaling without reciprocal formula 
entry?  This is one way how.  It doesn't have to go into driver, 
though perhaps partially, to meet self-scaled input requirements.

>So all in all I think that you are trying to fix a problem that doesn't
>exist in the first place, sorry.

Disagree :o)  The story:

I started on this originally because I could find no documentation on 
which adm9240 VccpX input was monitoring respective -5 and -12 volt 
inputs on Intel SE440BX-2 mobo -- what surprised me back then was the 
totally unambiguous answer the method of using resistor series values 
gave.  Not only told me resistor values, it unambiguously told me which 
sensor input was measuring which negative voltage.  I think I posted 
that here a while ago.  

libsensors cannot compute negative voltages for adm9240 as they require 
two inputs for the calculation?  You not corrected that notion for me, 
did I miss some thing in compute syntax or it simply isn't there?  
ADM9240 has no reference to drive top of resistor divider, so one must 
measure 5V and VccpX in order to discover negative reading.

There are notes in archives about adm9240 having problems displaying 
correct voltages, if they mean negative voltages I have the answer, 
further, as it compares observed vs measured value it accounts for 
input pin loading (~140k).

Parameter based conversion fixes the compute lines for voltages by 
relating them to 'real world' values that can be inferred, you might 
consider that idea for libsensors, I get terribly confused by the 
number of exceptions to the 'rules' for drivers :)

An alternative is to simply provide a script that does the resistor 
ratio stuff then 'normalise' the result so it can be plugged into 
sensors.  Least disturbance of the system?  Plus the ability to tell 
which input is monitoring what voltage -- maybe I was lucky with Intel, 
they used E12 (10%) series, E24 (5%) series works well, my studies 
indicate E24 series would be close enough, given the relatively poor 
resolution and accuracy of the sensor chip measurements. 

Trialling with E96 (1%) series is too noisy on 12V measurement due 
to poor measurement resolution, and it was a single bit (16mV) doing 
the damage -- when it was 'right' datasheet value came up (56/232), 
one bit higher and a different offering.

I'm still exploring the hwmon system, finding a balance between what 
can be done versus what should be done in drivers, I now see we don't 
really want a lot of extra accessors populating sysfs if that is so 
expensive.  I did go back to the Jan2003 sysfs discussions, so I'm 
dragging up stuff that you have already settled.  This is still new 
area for me.

Sensors needs a cleanup, and it seems right at the core parser, that's
not a nice one to take on, but from end-user point of view it needs 
doing.  One day :)  The lex/yacc parser in sensors is not terribly 
bright, I've forgotten if there is more modern way to build a parser, 
but the core parser doesn't look right, although its been a few years 
since I did one ('97 or '98), I'd have to dig it up and look.

The techniques, ideas I'm exploring don't _have_ to go into the 
drivers, I'm running them either way, direct sysfs access with shell 
script (see below) or in driver, that is not an issue for me.  Though 
I had to ask when I see it so close to being done in driver, but then 
complicated by the restrictions placed on sysfs data transfer and 
naming.  

Okay, I'm dancing all over the drivers at the moment, trying to discover 
boundaries, as many are not documented.  

Once I have an idea of boundaries, document that, look at what is left 
for user-space.  At times I'm being too picky as measurement and control 
design is what I did for a living a long time ago.  Other times I can't 
see wood for trees.  (older I get, better I was :)

Example with: Linux 2.6.12-rc3-mm3b.  (First time I been game to boot -mm)

root@sempro:~# lsmod
Module                  Size  Used by
w83627hf               29480  0
i2c_sensor              2944  1 w83627hf <<= unmodified
i2c_isa                 1856  0
via_agp                 7744  1
agpgart                29256  1 via_agp


Grant's voltage divider value finder,
R1 is from E24 (5%) series, R2 from E24 series

Working on:    12V
~~~~~~~~~~~~~~~~~~
     R1      R2    Error  Series
    ----   -----   ------   ---
    2000    5600   0.088%   E24  <<= match datasheet 10/28 (28 is from E96)
    4300   12000   0.249%   E24

Working on:   -12V
~~~~~~~~~~~~~~~~~~
     R1      R2    Error  Series
    ----   -----   ------   ---
    2400   10000   0.030%   E24  <<= closet to datasheet 56/232 = 0.241
    1800    7500   0.040%   E24
    3600   15000   0.107%   E24
    4300   18000   0.423%   E24

Working on:    -5V
~~~~~~~~~~~~~~~~~~
     R1      R2    Error  Series
    ----   -----   ------   ---
    5600   12000   0.074%   E24  <<= matches datasheet suggested values
    2200    4700   0.212%   E24
    2000    4300   0.490%   E24


   x     raw    BIOS   final   label   R1   R2
   0    1552    1550    1552   Vcore    0    0
   2    3296    3290    3296     3.3    0    0
   3    3040    5130    5107       5   50   34  <<= 50/34 are internal to sensor chip
   4    3152   11970   11977      12   20   56
   5     624  -11780  -11705     -12   56  232
   6     848   -5040   -5049      -5   56  120
   7    3280    5070    4969    5VSB   33   17  <<= 33/17 also internal resistors
   8    3376    3370    3376   Vbatt    0    0

raw is what sysfs gives, BIOS are observed readings, final are readings 
as per label column with R1, R2 as per:

#      -------o--> +5V, +5VSB, +12V   Measuring positive V > 4V
#             |     Vplus
#             -
#            | | R2        ----------------------   Measuring negative V
#            | |          |                      |   ____       ____
#             -           |          3600mV Vref |--|____|--o--|____|--->
#             |      Vin  |                      |    R1    |    R2
#             o-----------| 0..4096mV            |          |        -5V, -12V
#             |           |            0..4096mV |----------          Vminus
#             -           | W83697HF             | Vin
#            | | R1       |                      |
#            | |           ----------------------
#             -
#             |
#      -------o--> 0V

Data structure is simple (for w83697hf):

Vlabel=("Vcore" "-" "  3.3" "    5" "   12" "  -12" "   -5" " 5VSB" "Vbatt")
#                  +5 +12 -12  -5 5VSB
Vsfind=(0   0   0   0   1   2   2   0   0)      # 0 builtin, 1 = pos, 2 = neg
Vscale=(0   0   0   1   1   2   2   1   0)      # 0 noscale, 1 = pos, 2 = neg
R1spec=(0   0   0  50  20  56  56  33   0)      # known and datasheet values
R2spec=(0   0   0  34  56 232 120  17   0)
Vbios=(1550 0 3290 5130 11970 -11780 -5040 5070 3370) # mV reported by BIOS

Summary
````````
I've described a parameter based voltage reporting system that suits 
some chips that describe their scaling in terms of resistor values, 
a method for calibrating sensor readings to match observed BIOS or 
measured readings.  The result of this can be 'normalised' to suit 
current libsensors 'compute' lines or placed in drivers where needed.

A mobo manufacturer is likely to use less expensive E12 or E24 series 
resistor values for external voltage scaling.  My 2 of 2 mobo survey 
confirms this.  One mobo left to try is a the Gigglebyte shambles that 
does not follow manuf. guidelines (it87).

As far as drivers go, the winbond series drivers need fixing to report 
internally scaled voltages, winbond have two standards: an earlier 
5V -> 34/50, 5VSB -> 17/33 (where present), and a later standard where 
both 5V and 5VSB are 34/51.

Query
``````
The query I have is how to tell libsensors to produce a negative voltage 
readings for adm9240, as each depends on two input channel values.

--Grant.
