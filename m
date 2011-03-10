From: "I.dobson" <i.dobson@planet-ian.com>
Date: Thu, 10 Mar 2011 13:10:30 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <8c338fbf2b17f31ba2ed4d39ca9f185f@213.188.236.119>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Guenter,

--------- Original Message --------
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Ian Dobson <i.dobson@planet-ian.com>
Cc: lm-sensors@lm-sensors.org, Robert Kaiser <kairo@kairo.at>
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
RPMsignal de-bounce
Date: 03/10/11 12:53

> 
> On Thu, Mar 10, 2011 at 06:35:53AM -0500, Guenter Roeck wrote:
> &gt; Hi Ian,
> &gt; 
> &gt; On Thu, Mar 10, 2011 at 12:20:23AM -0500, Ian Dobson wrote:
> &gt; &gt; Hi Guenter,
> &gt; &gt; 
> &gt; &gt; --------------------------------------------------
> &gt; &gt; From: &quot;Guenter Roeck&quot;
&lt;guenter.roeck@ericsson.com&gt;
> &gt; &gt; Sent: Thursday, March 10, 2011 6:06 AM
> &gt; &gt; To: &quot;Robert Kaiser&quot; &lt;kairo@kairo.at&gt;
> &gt; &gt; Cc: &lt;lm-sensors@lm-sensors.org&gt;
> &gt; &gt; Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf
and fan 
> &gt; &gt; RPMsignal de-bounce
> &gt; &gt; 
> &gt; &gt; &gt; Hi again,
> &gt; &gt; &gt;
> &gt; &gt; &gt; On Wed, Mar 09, 2011 at 10:45:30PM -0500, Guenter Roeck
wrote:
> &gt; &gt; &gt; [ ... ]
> &gt; &gt; &gt;&gt; &gt; fan1:                    0 RPM  (min =    0 RPM,
div = 64)
> &gt; &gt; &gt;&gt; &gt; fan2:                 1110 RPM  (min =    0 RPM,
div = 32)  ALARM
> &gt; &gt; &gt;&gt; &gt; fan3:                    0 RPM  (min =    0 RPM,
div = 64)
> &gt; &gt; &gt;&gt; &gt; fan4:                    0 RPM  (div = 64)
> &gt; &gt; &gt;&gt; &gt;
> &gt; &gt; &gt; [ ... ]
> &gt; &gt; &gt;&gt; Looks reasonable. There is one problem which I had
wondered about - the 
> &gt; &gt; &gt;&gt; ALARM
> &gt; &gt; &gt;&gt; which tends to show up for running fans.
> &gt; &gt; &gt;&gt;
> &gt; &gt; &gt;&gt; I finally tracked that down. Turns out the chip has a
&quot;maximum RPM&quot; 
> &gt; &gt; &gt;&gt; register.
> &gt; &gt; &gt;&gt; Apparently that register is not set, which causes the
alarm.
> &gt; &gt; &gt;&gt;
> &gt; &gt; &gt; Actually, I am not sure if I got that right. Can you set
the minimum speed 
> &gt; &gt; &gt; of fan2
> &gt; &gt; &gt; to something larger than 1110 rpm and check if that causes
ALARM to go off 
> &gt; &gt; &gt; ?
> &gt; &gt; &gt;
> &gt; &gt; &gt; I suspect I might have misinterpreted the meaning of
&quot;Fan Count Limit&quot;. I 
> &gt; &gt; &gt; thought
> &gt; &gt; &gt; it is the low limit, but it might well be the high limit.
> &gt; &gt; &gt;
> &gt; &gt; &gt; Thanks,
> &gt; &gt; &gt; Guenter
> &gt; &gt; &gt;
> &gt; &gt; &gt;
> &gt; &gt; &gt; _______________________________________________
> &gt; &gt; &gt; lm-sensors mailing list
> &gt; &gt; &gt; lm-sensors@lm-sensors.org
> &gt; &gt; &gt; http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> &gt; &gt; 
> &gt; &gt; Are you sure, on my nct6776f the fan alarming appears to work
correctly:-
> &gt; &gt; HD:           532 RPM  (min =  200 RPM)
> &gt; &gt; CPU:         1043 RPM  (min =  500 RPM)
> &gt; &gt; Case Back:    990 RPM  (min =  500 RPM)
> &gt; &gt; Case Front:   765 RPM  (min =  500 RPM)
> &gt; &gt; fan5:           0 RPM  (min =    0 RPM)  ALARM
> &gt; &gt; 
> &gt; &gt; note those are exactly the minimum values I've entered into
sensors3.conf 
> &gt; &gt; and when the fan speed drops below these values I see an alarm.
> &gt; &gt; 
> &gt; Obviously not ;). But there must be a reason for those ALARM
responses.
> &gt; You point me into the direction, though: Robert's output includes
div,
> &gt; meaning it looks like he does not have an nct6776f after all.
> &gt; 
> &gt; So first question is what chip he has.
> &gt; 
> .... answer is NCT6775F, from Robert's log. It uses the &quot;old&quot;
registers for the min
> speed settings, so presumably that should be correct. Yet, there must be a
reason
> for the alarm. Maybe it is the &quot;maximum RPM&quot; register after all
- the NCT6775F
> has that set of registers as well.
> 
> Robert, can you play with the min speed setting a bit and see if you can
get the alarm 
> to disappear ?
> 
> Thanks,
> Guenter
> 
> 
> 
> 
Looking in the specification for the 6775 that I have I see:-
SYSFANIN. A one indicates the fan count limit of SYSFANIN has been exceeded.
and
SYSFANIN Fan Count Limit
Note: It is the number of counts of the internal clock for the Limit of the
fan
speed.

So that count is the number of timer ticks per pulse from the fan (slower
fan -> higher count)
and the alarm is generated when the count exceeds the limit defined, ie when
the fan is running too slowly. Therefore if I understood the text the way it
was meant to be understood, the alarm is a minimum RPM alarm.

Regards
Ian Dobson

________________________________________________________________
Message sent using Telaen Webmail 1.2.1



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
