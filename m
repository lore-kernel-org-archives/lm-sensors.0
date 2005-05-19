From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Random libsensors redesign toughts
Message-Id: <3EE25772.9010305@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As a follow up to my previous e-mail I thouht I would document some other 
thoughts I had recently about the interface between the new sysfs based 
drivers and libsensors and user-space applications.

Not that any of these are particularly good ideas, I just wanted to get them 
out there...

1. If the library is to be able to deal with any value in a consistent way, it 
needs to know if that value is in milli-degC, mVolts or whole counts.  While 
saying that all temperatures would now *have* to be reported in milli-degC 
makes all temperatures consistent, there is still the problem that all values 
are not scaled identically (fan's are in whole RPM's).  If each reading came 
with a scaling factor (1 to 1000 or more) it would be possible to have a 
generic routine for converting a driver integer to a user-space floating point 
value.

I see two possibilities...

Include the scaling in the same file with the reading:

     # cat in0
     3433 1000
     # cat fan0
     2323 1

Or have the scaling in a different file associated with the reading:

     # grep '.' in0*
     in0: 3433
     in0_scale: 1000
     in0_min: 3300
     in0_max: 3500
     in0_alarm: ALARM

2. I think we should strive to make it easier to add drivers and change the 
output text of a driver.  The "relation" and mapping information in the table 
that is currently compiled into libsensors could be moved to a config file.

3. sensors and sensord should be one program.  I view sensord as an example of 
how libsensors has not lived up to it's mission to provide an interface to 
lm_sensors for user programs.  You have to duplicate too much code from 
sensors into sensord when adding a new driver.  A framework for formatting and 
printing temperaturs and voltages is needed.  With this, then either sensord 
becomes a simple program to log readings without needing to know the specifics 
of chips, or else the RRD code is integrated into sensors.

4. An API that allows a user space program to request a list of all 
temperatures (regardless of which chip is measuring them) or voltages, or fans 
would be nice.  Many of the motherboards I'm working with have multiple 
monitoring chips and if I were writing a GUI interface, I'd like to be able to 
get all the values of a similar type organized together.  This would be the 
same interface that sensord needs.

5. We'll probably need to define some data types.  Some ideas:

    temp_min_max
    temp_over_hyst
    voltage_min_max
    fan_min
    pwm
    voltage

These can then be associated with user-specifiable output format strings. 
Then if a user want's the output of sensors in French or German, they can just 
change the sensors.conf file.

Just some random thoughts...

:v)
