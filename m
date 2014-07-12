From: Toerless Eckert <tte@cs.fau.de>
Date: Sat, 12 Jul 2014 22:30:55 +0000
Subject: Re: [lm-sensors] lm-sensors: which temperature sensor is lying ?
Message-Id: <20140712223055.GA24282@faui40p.informatik.uni-erlangen.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
In-Reply-To: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jul 12, 2014 at 11:43:15AM -0700, Guenter Roeck wrote:
> >As i said, Core2Duo 6400, see cpuinfo at the end.
> 
> I thought you saw the problem with the quad core CPU. Am I missing something ?
> The 6400 is not a quad core CPU.

The differences between Core 0/1 sensors and term2 sensors are the same
whether i use my good old proven 6400 or the new quad-core. So right
now i want to stick to my old CPU and figure out that i understand whats
going wrong with the sensors and ultimately know what my old 6400 temperature
is. ... And then i can go back to the quad-core. 

> >So PECI are pins on the CPU into a temperature sensor on the CPU ?
> Yes.
> 
> >But why do you say that is not connected or incorrectly configured ?
> >
> If it was configured correctly it should show exactly the same temperatures
> as coretemp.

Ok, so how do i then know whether the Core0/1 readings or the temp2 reading
is misconfigured...

> >I just tested on the dual-core CPU, stopping the CPU fan manually.
> >The CPU started to emit mcelog throttle messages when  the Core 0
> >sensor reached 100C - which took a few minutes, at that time temp2 sensor was
> >at 68C.
> >
> That is what I would expect to see.

Right. So thats why i am not worrying about the fan right now ;-)

> >How much of this error generation is really hard-coded by the CPU
> >vs. potentially wrong linux driver/config ? If it is known that
> >this has nothing to do with anyhing linux could do wrong, but its purely the
> >CPU and its known to have 100 degree trippoint when it throttles ... that
> >would make me start beliving those high Cpu 0 readings, but otherwise
> >i rather doubt them.
> >
> MCE errors are created by the CPU. Linux only reacts to it.

Ok, but in the MCE error it does not say the trip temperature, so
i wonder if one can validate that the trip temperature is really
100C for the 6400 CPU. Because if it is, then i would trust the Core 0/1
sensor readings more and conclude the temp2 is wrong... and wonder if/how
i can fixup some lm_sensors config to fix it up.

> >Alas, i only have another linux with quad-core AMD, and that shows nicely idling
> >at 32C and full load not above 42 and the CPU and temp sensors look
> >comparable.
> >
> That is an apples-to-oranges comparison, though. With the same logic
> I could argue that all six servers I have online right now are fine,
> therefore you don't have a problem.

I just brought it up for two reasons:
- My other linux does have consistent info across different sensors
- If AMD is really runing cooler, maybe my next mobo should be AMD again ;-)
  (but the idea of course here is to keep this running as long as possible).

> Automatic fan control is what I meant. Guess if the chip is configured
> to run fans at full speed if the temperature shows 50 degrees C you
> might be ok. Question though is if temp2 gets there with the quad
> core CPU. It might be that the quad core CPU needs a lower limit
> to start running fans at full speed. Just guessing, though.

Yeah, but as stated up front. Lets forget the quad core CPU:

temp2 shows me temperatures between 30C and 60C, and when i stop the
fan and restart, i see the mobo fan control change speed at 50C on temp2,
which is also what is configured in the BIOS. If i go after restart into
the BIOS i see a temperate between 30C and 40C which makes me think
that the BIOS does rely on the temp2 sensor and that the BIOS thinks
the CPU has temperatures between 30C and 60C.  Which is inconsistent
with the higher temp readings on the Core sensors: - 50C..100C

> >Yeah, its a 2008 board, but runs latest BIOS.
> >
> Is the new CPU listed as supported ? Also, again, can you give me the model
> of the quad core CPU ?

Again, lets forget the quad core right now. these are all right now numbers
with the proven old dual core.

Cheers
    Toerless

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
