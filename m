From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Jul 2010 15:49:55 +0000
Subject: Re: [lm-sensors] LM_Sensors Config for Supermicro X7SLA-L / X7SLA-H
Message-Id: <20100707174955.5b3384e9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1238.66.169.177.147.1278221517.squirrel@webmail.myamigos.us>
In-Reply-To: <1238.66.169.177.147.1278221517.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Sun, 4 Jul 2010 00:31:57 -0500 (CDT), Jeff Rickman wrote:
> This configuration has been tested on a Supermicro X7SLA-H motherboard
> (...)
> Any suggestions on getting the "set in3_min" and "set in3_max" values set
> correctly for +/- 10 percent limits?
> 
> I determined through experimentation that the "AVCC" value from the
> "w83627dhg-*" section of "sensors3.conf" with label "in2" is a "+3.3
> Voltage" input. Changing values related to "in2" affected the "+3.3V
> Voltage" line in Supermicro's "sdt" command. Thus I figured that "in3" is

This is right, AVCC stands for "Analog VCC" and is the +3.3V rail for
the analog side of the W83627DHG.

> the line used for "+12V Voltage" in "sdt". The compute line seems accurate
> and the formula was based on info found on the LM_Sensors Wiki for another
> chip.

This is wrong. in3 is the +3.3V rail for the digital part of the
W83627DHG. This is an internal voltage measurement channel, thus it can
_not_ be anything else.

> It appears there are 2 separate inputs, "in1" and "in4", for measuring
> DIMM Voltage. The motherboard has 2 DIMM sockets. Removing a DIM from
> "DIMM_B" did not affect the voltage read by either "in1" or "in4"
> suggesting that either input could be safely ignored.

More likely, one of these is _not_ the DIMM voltage. Could be +12V
instead, see below.

> I ignore Temp3 since it displays negative temperatures even though it is
> located in a room with an ambient temperature of 78 degrees Fahrenheit.

The very nice thing about SuperMicro's monitoring software is that it
comes with a readable configuration file which instructs the tool in
which register it should read each value. See file AllSuperD.ini. It has
this to say about your board's voltages (edited for brevity):

[Item]
Item_Name=CPU Core Voltage
Offset 

[Item]
Item_Name=+1.5V Voltage
Offset&

[Item]
Item_Name=+12V Voltage
Offset!

[Item]
Item_Name=+3.3V Voltage
Offset"

[Item]
Item_Name=DIMM Voltage
Offset$

[Item]
Item_Name=+5V Voltage
Offset%

[Item]
Item_Name=+3.3Vsb Voltage
Slave=5
OffsetP

[Item]
Item_Name=VBAT Voltage
Slave=5
OffsetQ

"Slave" and "Offset" refer to register addresses. As registers 0x20 to
0x26 correspond to in0 to in6, and 0x550 to 0x551 correspond to in7 and
in8, respectively, we have the following mappings:

label in0 "Vcore"
label in1 "+12V"
label in2 "+3.3V"
label in4 "Vdimm"
label in5 "+5V"
label in6 "+1.5V"
label in7 "3VSB"
label in8 "Vbat"

They did not label in3, but it's simply another +3.3V per chip design::

label in3 "+3.3V"

Now you get to figure out the scaling factor for +12V.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
