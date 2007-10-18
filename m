From: Riku Voipio <riku.voipio@movial.fi>
Date: Thu, 18 Oct 2007 08:56:04 +0000
Subject: Re: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <47171FA4.7080602@movial.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071016100857.GA25544@kos.to>
In-Reply-To: <20071016100857.GA25544@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Lennert Buytenhek wrote:
>>> While I would agree that fixing this in the bootloader is the cleanest
>>> approach, I'm pretty sure that even if we do manage to build a new
>>> version of the bootloader (I'm not even sure whether we have the source
>>> for it),
>>>       
>> Can't you contact whoever sells this system? If the "BIOS" is broken,
>> that's really up to them to fix it.
>>     
>
>
> I'm not sure whether the bootloader explicitly disables the fans or
> whether they just don't kick in because the temperature isn't high
> enough.
>
>   
Redboot does not touch the fans. The problem is that the fanspeed
reading isn't reliable. The "speed" mode tries to adjust pwm to get
the fanspeed to match whatever is requested in "expect" registers,
but never to enough to get the fans to run.

..
>> I'm not aware of such workarounds to prevent machines from frying. For
>> such critical cases, system vendors typically bother releasing a BIOS
>> update.
>>     
As Lennert mentioned, Software provided by Thecus
does set the fans running by default (by combination of
a kernel driver and userland scripts). It's not sold as a
general purpose PC.

In my experience the risk of literal "frying" is very very low,
but even with just one one disk inside and finnish cool weather,
smartmontools have reported the hard drive going over the
operating temperature limit (60c).

With, say, 2x10 rpm disks inside the case, I'd say the risk of
disks breaking down prematurely is very real. And I do not
want to take the responsibility of people reporting that "installing
Debian caused my hardware to break down"


> As I said above, I am not entirely sure what Redboot does.  Riku, do
> you have the source code for the Redboot used in the n2100?
>   
We have some redboot code from Thecus. But I'm so not going
to touch it, since currently we have no  way to recover the
bootloader in case it goes bust.

Also, "fixing" in this case is more likely to mean "add support
for the fintek chip" rather than "rather"

>> Can I see a dump of the chip before the Linux driver is loaded?
>>     
>
> Riku?
>
>   
I'll grab it, but see the first paragraph I wrote.

>> How can this be? Is this hardware
>> supposed to be used with another OS, and that other OS does kick the
>> fans in as you suggest Linux should do? Please clarify the situation.
>>     
>
> I don't think other OSes run on this machine.
>
> Well, maybe one of the BSDs do -- but I'm not sure how they handle
> the fans.
>   
The one being OpenBSD. They send fans to full speed in
fintek driver with driver paramater. I guess the parameter
gets compiled in the kernel when compiling a n2100 kernel.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
