From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: lm85 driver and a standardized pwm fancontrol interface
Message-Id: <20040623221136.GE27870@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm working on adding the automated fancontrol features back into the 2.6.X
kernel lm85 driver.  So far I've been working from the 2.4.X driver and the
respective chip spec sheets, using the 2.6.X kernel adm1030/1031 driver 
and mailing list discussion as a guideline to structure and interface.

The model proposed looks something like:



       Off     Min          Max     Crit
________|_______|____________|________|_______

                 Temperature -->

Where Off, Min, Max, and Critical temperatures are set independently, 
except for assuming that:

Off <= Min <= Max <= Crit


The lm85 and compatible chips use a model like:


 
               Min                  Crit
________________|_____________________|_______
        |       |____________|
        |_______|      |
            |        Range
        Hysteresis



                 Temperature -->


Where the Min and Crit temperatures are set indpendently, except that 

Min <= Crit

And 

Hystersis is a negative offset from Min,

While

Range is a positive offset from Min.


Now the obvious translation between the 2 models is:


Off = Min - Hysteresis
Max = Min + Range
Min = Min
Crit = Crit

but there are a couple of snags.

(1) Hystersis and Range only have 4 bits of resolution.
    - the 4 bits of range cover an enumerated set of possible degree ranges:

    2, 2.5, 3.3, 4, 5, 6.6, 8, 10, 13.3, 16, 20, 26.6, 32, 40, 53.3, 80

    - the 4 bits of hysteresis covers the range of 0-15 degrees.

Both of these are ok in actual use, AFAIK.  But they set limits on the
relationships of Off, Min, and Max temperatures defining the behavior of
the automated fan control.  The nature of these limits are not entirely
transparent in the new model, and may lead to different behavior of the 
driver than a casual user expects.

Unless the user knows the actual set of allowed values for the range, it
is likely he will see a different value for Max than he sets in the 
sensors.conf file or via the sysfs interface.  This will undoubtedly cause
a fair amount of confusion for new users.  Moreover, the code now MUST
keep track of the last value requested for Max, in addition to the value
actually set, because every time the value of Min is changed, Max and range
must be recalculated.  If the actual requested value is not preserved and
used for these calculations, it is possible for the value of Max to "drift".
As an example, consider:

------------------------
Min:               :  40
desired Max        :  51

Resultant Range    :  13.3
Resultant Max      :  53.3

Now let

Min => 42

If we now use 53.3 as the desired Max, then we have

Max - Min = 11.3

The 2 closest elements in the allowable Range values table are 10 and 13.3.

10 < 11.3 < 13.3  --> Range => 13.3.

And so Max => 55.3.

But if we had kept track of desired Max and used that value:

desired Max - Min = 9

Again using the 2 closest elements from the allowable Range values table.

8 < 9 < 10  --> range => 10

and so Max => 52

an entirely different number.

-----------------------------

A similar situation exists with Off, should 

Min - desired Off

vary from < 15 to > 15,

the value for Off will by necessity rise, since  

0 <= Range <= 15,

and therefore

Min - Off <

Which again means that the driver needs to keep track of the desired value
for Off as well as the actual value.

This makes me somewhat unhappy about forcing the lm85 fancontrol interface to
fit the Off->Min->Max->Critical model.  I have made the 2 models fit as
best I see able, but it still feels like a kludge.

I would appreciate any suggestions people have for resolving these issues.

Thanks,

Justin Thiessen
-----------------
jthiessen@penguincompuging.com
http://www.penguincomputing.com


