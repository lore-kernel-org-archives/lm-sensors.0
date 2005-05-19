From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC Voltage calibration in user space
Message-Id: <sp9t61h8bcg2m949ckkca69edddtpdgbk5@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Summary
````````
Describing a method to calibrate voltage readout with use of BIOS 
voltage readings and some practical electronics knowledge.

I was pleasantly surprised to see how few valid R1/R2 combinations 
match measured vs observed voltage, suggesting this is a viable 
technique to improve end-user calibration of sensor chips.

To me this is a natural follow-on from providing the auto fan clock 
divider to reduce and/or improve user-space settings for sensors 
operation.

Background
``````````
One of the aspects of lm_sensors that surprised me is the requirement 
to enter reciprocal conversion formulas for each voltage reading, that, 
plus the thing displaying a rotating fan as zero stopped me using 
lm_sensors.  So here I am, trying to suggest some improvements.

The answer to this from the 'group' seemed to be "how else would you 
do it?".  I have an answer.

The technically correct method to scale voltages is to recognise 
this: resistors are made in a discrete value series.

Three main series: E12, E24 and E96 (10%, 5% and 1%).  In working 
on adm9240 driver I had the problem of discovering which VccpX input 
was being used for -5 and -12 volt readings, the resistor selection 
method left no doubt at all which was which, using the E12 series.

The second chip, w83697hf, was more difficult, as two of three 
datasheet pairs used E96 values.  Since I doubt mainboard 
manufacturers care enough to put 1% resistors down I updated my 
script to use E24 series.  This provided 'close enough' answers, 
error is less than 0.5%.  

My new MSI main used Winbond values.  An older Gigabyte mainboard 
does not use IT8712F suggested values, or connections, so that is 
my next target.

One challenge is to perform the math in integer space without 
underflowing values, this issue I nailed yesterday.

I'm working in shell script, mainly because I'm even more rusty 
with perl...  And it has been years since I wrote C++ user-space 
tools...

How it works
`````````````
Inputs:
User writes down voltage readings from BIOS, if BIOS doesn't display 
voltages then user needs to measure voltages at the mainboard power 
connector.

Chip knowledge:
Main one is how negative voltages are measured, plus Vref:

adm9240:
#    -------o----------------o------> + 5V
#           |                |
#           -                |
#          | | R1        ---------------
#          | |          |   5V_Vref
#           -           |
#           |     Vread |
#           o-----------| Vccp1 0..3600mV
#           |           |
#           -           |      ADM9240
#          | | R2       |
#          | |           ---------------
#           -
#           |
#    -------0---> Vminus
Vr1 = (5V_Vref - Vread)  Cancel 5V variation affecting Vminus reading


w82697hf:
#      -------o--> +12V
#             |    Vplus
#             -
#            | | R2        ----------------------
#            | |          |                      |   ____       ____
#             -           |          3600mV Vref |--|____|--o--|____|--->
#             |     Vread |                      |    R1    |    R2
#             o-----------| 0..4096mV            |          |   -5V, -12V
#             |           |            0..4096mV |----------     Vminus
#             -           | W83697HF             | Vread
#            | | R1       |                      |
#            | |
#             -
#             |
#     --------o--> 0V
Vr1 = Vread

The calibrator script tries possible resistor combinations and presents 
resistor pair values with the lowest error, useful combinations produce 
errors well below one percent.

Formulas used are basic Ohms Law (ignoring chip input sense current):

Find R2:

For this we need the BIOS or measured reading of the measured 
voltage to discover R2:

# R2 = voltage across R2 / current through R1

Measure Vplus or Vminus:

Once we have R1 and R2 values, the voltage is easy to transform:

# Vplus = current through R1 * (R1 + R2)
# Vminus = (current through R1 * (R1 + R2)) + Vref

Because the sensor calibration is based on component parameters, 
the user no longer needs to enter reciprocal formulas.  The user-
space program can do that.  Limits entry uses the same parameters 
as voltage display.


So what's it all about?
````````````````````````
* The current sensors expects end-user to enter formulas, when all 
they need do is provide a pair of parameters for positive voltages, 
Vref is known by chip type for negative, plus observed readings from 
BIOS or meter measurement.

* Correct operation provides traceability back to standard resistor 
values and the sensor chip's internal reference.  Anything else is 
simply an unjustified 'fudge factor' which is okay for positive, 
but definitely more dangerous for negative voltage transforms.

* user-space may be simplified by providing a tool that asks for 
BIOS readings and selects the best resistor pair values.  This gets 
rid of the reciprocal formula entry 'mess' that really is difficult 
to understand, like, what does '@' mean?

* Limits can mostly be set to known specs: eg. Intel ATX 2.0X defines 
positive voltages at 5% and negative at 10%.  pII AGTL+ is 9%, CPU 
usually 5%  -- so why not punt on 5% and 10% for negatives?  ON the 
same point, just have the user enter percentage, what expect them 
to enter upper and lower bounds (X x .95, X x 1.05) when all that is 
needed is a 5% entry?

what next?
```````````
I've floated an idea, shoot it down, or encourage me to make this 
into a user-space tool :)

Thanks,
--Grant.
