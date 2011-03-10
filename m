From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Mar 2011 11:53:28 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <20110310115328.GC14075@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 10, 2011 at 06:35:53AM -0500, Guenter Roeck wrote:
> Hi Ian,
> 
> On Thu, Mar 10, 2011 at 12:20:23AM -0500, Ian Dobson wrote:
> > Hi Guenter,
> > 
> > --------------------------------------------------
> > From: "Guenter Roeck" <guenter.roeck@ericsson.com>
> > Sent: Thursday, March 10, 2011 6:06 AM
> > To: "Robert Kaiser" <kairo@kairo.at>
> > Cc: <lm-sensors@lm-sensors.org>
> > Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan 
> > RPMsignal de-bounce
> > 
> > > Hi again,
> > >
> > > On Wed, Mar 09, 2011 at 10:45:30PM -0500, Guenter Roeck wrote:
> > > [ ... ]
> > >> > fan1:                    0 RPM  (min =    0 RPM, div = 64)
> > >> > fan2:                 1110 RPM  (min =    0 RPM, div = 32)  ALARM
> > >> > fan3:                    0 RPM  (min =    0 RPM, div = 64)
> > >> > fan4:                    0 RPM  (div = 64)
> > >> >
> > > [ ... ]
> > >> Looks reasonable. There is one problem which I had wondered about - the 
> > >> ALARM
> > >> which tends to show up for running fans.
> > >>
> > >> I finally tracked that down. Turns out the chip has a "maximum RPM" 
> > >> register.
> > >> Apparently that register is not set, which causes the alarm.
> > >>
> > > Actually, I am not sure if I got that right. Can you set the minimum speed 
> > > of fan2
> > > to something larger than 1110 rpm and check if that causes ALARM to go off 
> > > ?
> > >
> > > I suspect I might have misinterpreted the meaning of "Fan Count Limit". I 
> > > thought
> > > it is the low limit, but it might well be the high limit.
> > >
> > > Thanks,
> > > Guenter
> > >
> > >
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> > 
> > Are you sure, on my nct6776f the fan alarming appears to work correctly:-
> > HD:           532 RPM  (min =  200 RPM)
> > CPU:         1043 RPM  (min =  500 RPM)
> > Case Back:    990 RPM  (min =  500 RPM)
> > Case Front:   765 RPM  (min =  500 RPM)
> > fan5:           0 RPM  (min =    0 RPM)  ALARM
> > 
> > note those are exactly the minimum values I've entered into sensors3.conf 
> > and when the fan speed drops below these values I see an alarm.
> > 
> Obviously not ;). But there must be a reason for those ALARM responses.
> You point me into the direction, though: Robert's output includes div,
> meaning it looks like he does not have an nct6776f after all.
> 
> So first question is what chip he has.
> 
... answer is NCT6775F, from Robert's log. It uses the "old" registers for the min
speed settings, so presumably that should be correct. Yet, there must be a reason
for the alarm. Maybe it is the "maximum RPM" register after all - the NCT6775F
has that set of registers as well.

Robert, can you play with the min speed setting a bit and see if you can get the alarm 
to disappear ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
