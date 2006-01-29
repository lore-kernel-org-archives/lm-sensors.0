From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 29 Jan 2006 21:44:28 +0000
Subject: [lm-sensors] vt1211 questions
Message-Id: <43DD373C.6090105@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
In-Reply-To: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> Hi all,
> 
> 
>>Hello all,
>>
>>Juerg are you still working on the port?
> 
> Yes

Good.

> 
> The datasheet states that temp1 is reserved for the internal
> temperature. That doesn't mean it cant be read. And yes, it's fixed in
> the current CVS version..

Yep.

>>Yes I agree. Why not. We will relase soon new lm-sensors version with old mapping. Maybe
>>if you want to release your driver soon just do as it is now, so people can use this version and > not the CVS one...
> 
> 
> As mentioned earlier, I'll make sure the 2.6 driver has the same
> mapping as the current 2.4 driver.

Good.

> 
> 
>>Please let us know if you already have something for 2.6 Maybe some base patch without PWM > first?
> 
> 
> I do have a working (I believe) 2.6 version that does have PWM
> support. Unfortunately I can't fully test it, because VIA decided to
> *not* use the PWM outputs on the EPIA M10000 board (how stupid is
> that?). The fans are just connected to 12V and are always running full
> speed. I'm thinking of maybe reworking my board... :-)

Heh should not be so difficult.
1) make sure the pin for PWM is not for something else
2) tap/solder the pin on sio
3) put the transitor plus RC filter there
4) plug the fan ;)

maybe #3 is somewhere described is sample schematics.


> I can certainly generate a patch and make it available for people to
> test it. Speaking of making kernel patches: I'm not too familiar with
> that. Am I supposed to generate a patch against the latest (devel)
> kernel or is 2.6.14 good enough?

Well for real inclusion in should be against latestest RC version or git
For some test make sure it works with 2.6.15.

You can read the Documenation/CodingStyle and SubmittingPatches files to get
clue how to do that. Dont worry we will help you ;)

You can send patches in text attachment to this list. (no inline is neccessary)

> I'll try to do that over the next couple of days. I also need to
> supply some basic information on how to use the PWM feature and it
> also requires a new sensors.conf since the 2.6 driver doesn't do weird
> scaling of temperature and voltage numbers anymore. It just returns
> the true register values and any scaling is performed via the compute
> lines in sensors.conf.

We have a interface standard in the kernel Documenation/hwmon directory, just read the sysfs-interface.
If you need further help on that please write here.

> Is it possible to host the patch on the lm-sensors webpage and maybe
> issue a call to VT1211 users? Just like you did it with the VT8231.

Sure. We can do that on lm-sensors website or mine or Jean's ;)

Regards
Rudolf

