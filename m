From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Fri, 17 Dec 2010 18:52:51 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <2054.75.142.173.238.1292611971.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> On Sun, 12 Dec 2010 22:18:44 -0600 (CST), Jeff Rickman wrote:
>> I rechecked my "/etc/sensors.d/local.conf" file. There are no labels,
>> compute lines, or set lines applied to "in7" for this chip. After a
>> system
>> reboot, then issuing a "sensors -s" and waiting a while, no ALARM flag
>> is
>> seen for "in7". My "sensors3.conf" file does not have any changes or
>> even
>> references to "in7" in the "dme1737", "sch311x-", and "sch5027-*"
>> sections. Just trying to be thorough in checking.... Successive readings
>> of "sensors" shows the "max" value for "in7" changing from 1.50V to
>> 0.25V;
>> the "min" value never changes from 1.99V.
>>
>> Now I add "set" lines for "in7":
>>   set in7_min 1.5 * 0.90
>>   set in7_max 1.5 * 1.10
>>
>> After a "sensors -s", "sensors" very briefly reports "min" and "max"
>> values set to 1.35 and 1.65 respectively. Then I repeat "sensors" a few
>> more times to see these values change back to 1.99 and anything from 0.0
>> to 1.0 respectively. Very odd indeed.
>
> Hmm. So the limit registers aren't behaving as they should. This
> suggests that Juerg's patch is not correct. Juerg, can you please
> double-check what the datasheet says for registers 0x9f and 0xa0? Could
> these be read-only in certain conditions, maybe? And are they really
> in7 limits to start with? The value of 0xa0 changing on its own doesn't
> make it look so.
>
> Anyway, the value of 0.72 V doesn't make much sense if the line is
> supposed to monitor +1.5, as it could do so without scaling. Seeing how
> odd the whole system seems to be, I would no longer be surprised if
> they really connected +1.5V to in4...
>
> And I take not to avoid Acer hardware. Jeff, I am afraid that we won't
> be able to go much farther with this. The only way to get proper
> voltage handling would be to ask Acer for the pin wiring of the voltage
> monitoring inputs together with the resistor values they used for
> scaling. Without that we can only try and guess things, and get them
> wrong.
>

I truly appreciate the effort and support from everyone involved.

The expected voltages on the expected pins seem reasonable. The temps and
fans readings seem correct compared to the BIOS. Even the PWM fan function
works! I would call that a respectable achievement.

I would say the effort to get SCH5127 code working in LM_Sensors was very
good, especially since Juerg did not have access to this specific hardware
platform for testing. Should someone else encounter the SCH5127 chip in
the future, this effort will benefit them.

> --
> Jean Delvare
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
