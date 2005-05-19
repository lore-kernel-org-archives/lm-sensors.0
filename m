From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2 (including the max6
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B5A7@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Marc Rieffel [mailto:marc@paracel.com]
> Sent: Tuesday, October 21, 2003 2:36 PM
> To: Morris, John; Mark Studebaker
> Cc: sensors@stimpy.netroedge.com; Bob Y. Hsin
> Subject: RE: Issues with lm_sensors on Intel SE7501cw2 (including the
> max6651)

Thanks for changing the subject!

> I'm using an Intel SE7501cw2 motherboard.  It's not an exotic 
> or unusual motherboard, though I agree that the way that its 
> fans are wired is weird.

Oh, but everything is exotic if you've never used it :)
 
> My interpretation of the 6651 data sheet is that you can 
> either set the voltage (open loop) or the fan speed (closed 
> loop). 

That's right, as well as "full on" and "full off".

> Given the way my board is wired, I don't expect 
> closed loop to work.  Open loop seems to work, though the 
> "speed" register is misleading.  

That's what it is called - actually "fan speed" - in the datasheet.
Argue with Maxim if you want the name changed :-) Having said that, 
if some other name is preferred for the /proc entry, that's fine: 
I could not find anything relevant in the sensors project standards 
at the time the driver was written, so just echoed the datasheet.

> Would it make sense to have more explicit support for open 
> loop mode?  Maybe offer a "pwm" interface similar to what 
> they have on the Winbond w83627hf?  Then the "pwmconfig" 
> program could use it.  And any use of the pwm setting would 
> ensure selection of open loop mode, just like use of the 
> "speed" setting ensures closed loop mode.  Just blue-skying 
> here.  I probably wouldn't use this feature if it were implemented.

The 6650/1 doesn't do PWM, and I'd be reluctant to use a 
name that indicates that it does. In open loop mode the DC drive 
level to the fan is set by the DAC register, which the driver 
does not currently handle.

Although not mentioned in the datasheet, when set in closed 
loop mode the chip itself adjusts the value in the DAC register,
in effect turning it into a read-only register (actually, you
can write it, but the value quickly gets over-written as
the chip does its feedback loop.)

So yes, a "dac" read/write entry, which sets open loop mode
when written to, would be sensible: open loop is, so far as 
I can see, the only time that writing to DAC is meaningful. 
(I'd want to check the actual name against the project standards).
However, you say you probably won't use it, and I'm not going 
to use it, and nobody else has asked, so that's very low 
priority on my personal to-do list. 

> What about at least putting a note in the documentation to 
> explain the multiple modes,

That would really duplicate information in the datasheet,
which is referenced in the documentation (the URL there is still
good.) My assumption was that the documentation should be about
the driver not the chip, and that anyone wanting to know more
about the chip per-se would read the datasheet, which is the 
ultimate authority.

The only bit about the chip that I wrote was a little commentary
at the start distinguishing the two functions of the chip, since
that confused me when I first started working with it.

> the fact that the driver doesn't 
> change modes, and what the speed setting does in each?

The speed setting is described in the documentation. 

> What are your thoughts about the assumption of two pulses per 
> rotation?  The doc mentions that the Max datasheet makes this 
> assumption, but other chips and drivers don't make this 
> assumption, and I for one have some fans that seem to only 
> give one pulse per revolution.  What is the best way to 
> report the actual fan speed for a one-pulse fan?

I haven't given this any thought. I don't have access to any
1 pulse per rotation equipped systems with 6650/1, so any
code changes I did would be pure untested guesswork, and 
I try not to do that. Obviously a factor of two somewhere,
but I'd probably divide instead of multiplying, or vice-versa.

J.


