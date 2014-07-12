From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 12 Jul 2014 23:06:41 +0000
Subject: Re: [lm-sensors] lm-sensors: which temperature sensor is lying ?
Message-Id: <53C1BF81.7040303@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
In-Reply-To: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 07/12/2014 03:30 PM, Toerless Eckert wrote:
> On Sat, Jul 12, 2014 at 11:43:15AM -0700, Guenter Roeck wrote:
>>> As i said, Core2Duo 6400, see cpuinfo at the end.
>>
>> I thought you saw the problem with the quad core CPU. Am I missing somet=
hing ?
>> The 6400 is not a quad core CPU.
>
> The differences between Core 0/1 sensors and term2 sensors are the same
> whether i use my good old proven 6400 or the new quad-core. So right
> now i want to stick to my old CPU and figure out that i understand whats
> going wrong with the sensors and ultimately know what my old 6400 tempera=
ture
> is. ... And then i can go back to the quad-core.
>
>>> So PECI are pins on the CPU into a temperature sensor on the CPU ?
>> Yes.
>>
>>> But why do you say that is not connected or incorrectly configured ?
>>>
>> If it was configured correctly it should show exactly the same temperatu=
res
>> as coretemp.
>
> Ok, so how do i then know whether the Core0/1 readings or the temp2 readi=
ng
> is misconfigured...
>


[1] suggests that tjmax for E600 series should be either 70 or 80 degrees C.
Other links [2] suggest that it might be 85 degrees C or 100 degrees C,
though that link is older. This suggests that the 100 you have configured
may be wrong, and that the real temperature may be 20 or even 30 degrees
lower. This in turn would suggest that the temp2 reading might be the
correct (or better) one.

You can set tjmax with the tjmax module parameter. For example,
'modprobe coretemp tjmax=80' would set tjmax to 80 degrees C.

Ultimately that doesn't matter much, though, since only the difference
between tjmax (shown as critical temperature) and the current temperature
is relevant, and your system is well below the critical temperature,
at least with the dual core CPU.

>>> I just tested on the dual-core CPU, stopping the CPU fan manually.
>>> The CPU started to emit mcelog throttle messages when  the Core 0
>>> sensor reached 100C - which took a few minutes, at that time temp2 sens=
or was
>>> at 68C.
>>>
>> That is what I would expect to see.
>
> Right. So thats why i am not worrying about the fan right now ;-)
>
>>> How much of this error generation is really hard-coded by the CPU
>>> vs. potentially wrong linux driver/config ? If it is known that
>>> this has nothing to do with anyhing linux could do wrong, but its purel=
y the
>>> CPU and its known to have 100 degree trippoint when it throttles ... th=
at
>>> would make me start beliving those high Cpu 0 readings, but otherwise
>>> i rather doubt them.
>>>
>> MCE errors are created by the CPU. Linux only reacts to it.
>
> Ok, but in the MCE error it does not say the trip temperature, so
> i wonder if one can validate that the trip temperature is really
> 100C for the 6400 CPU. Because if it is, then i would trust the Core 0/1
> sensor readings more and conclude the temp2 is wrong... and wonder if/how
> i can fixup some lm_sensors config to fix it up.
>
If you can, I don't know how.

>>> Alas, i only have another linux with quad-core AMD, and that shows nice=
ly idling
>>> at 32C and full load not above 42 and the CPU and temp sensors look
>>> comparable.
>>>
>> That is an apples-to-oranges comparison, though. With the same logic
>> I could argue that all six servers I have online right now are fine,
>> therefore you don't have a problem.
>
> I just brought it up for two reasons:
> - My other linux does have consistent info across different sensors
> - If AMD is really runing cooler, maybe my next mobo should be AMD again =
;-)
>    (but the idea of course here is to keep this running as long as possib=
le).
>
Your call, really, which CPU to use.

>> Automatic fan control is what I meant. Guess if the chip is configured
>> to run fans at full speed if the temperature shows 50 degrees C you
>> might be ok. Question though is if temp2 gets there with the quad
>> core CPU. It might be that the quad core CPU needs a lower limit
>> to start running fans at full speed. Just guessing, though.
>
> Yeah, but as stated up front. Lets forget the quad core CPU:
>
> temp2 shows me temperatures between 30C and 60C, and when i stop the
> fan and restart, i see the mobo fan control change speed at 50C on temp2,
> which is also what is configured in the BIOS. If i go after restart into
> the BIOS i see a temperate between 30C and 40C which makes me think
> that the BIOS does rely on the temp2 sensor and that the BIOS thinks
> the CPU has temperatures between 30C and 60C.  Which is inconsistent
> with the higher temp readings on the Core sensors: - 50C..100C
>
But you don't have a problem with the dual core CPU, or do you ?
I think you are chasing the wrong problem. You insist in seeing the correct
and same temperature on both coretemp and temp2, but that doesn't really ma=
tter.
Again, the only thing that matters is how close the reported temperature ge=
ts
to the critical temperature.

In other words, even if you get both coretemp and temp2 output to agree,
you'll still see the problem with the quad core CPU.

>>> Yeah, its a 2008 board, but runs latest BIOS.
>>>
>> Is the new CPU listed as supported ? Also, again, can you give me the mo=
del
>> of the quad core CPU ?
>
> Again, lets forget the quad core right now. these are all right now numbe=
rs
> with the proven old dual core.
>
Do you see any errors with the old CPU ? I thought you didn't.

At this point I would suggest to play with the tjmax parameter until you get
all the temperatures to agree. I would suggest to do some more research
to ensure that you select the correct tjmax for your CPU. Then repeat the
same with the quad core CPU. My suspicion is that the BIOS may not set the
limits for the quad core CPU correctly, which may cause it to run hot.

Guenter

---
[1] http://www.tomshardware.co.uk/intel-dts-specs,news-29460.html
[2] http://www.tomshardware.com/forum/245128-29-e6300-6400-stepping-computr=
onix


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
