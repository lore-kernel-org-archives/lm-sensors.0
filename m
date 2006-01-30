From: juergh@gmail.com (Juerg Haefliger)
Date: Mon, 30 Jan 2006 02:28:03 +0000
Subject: [lm-sensors] vt1211 questions
Message-Id: <191fb4ca0601291828s4d4db8ccle5411811e9c91141@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
In-Reply-To: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for the reply.

>> I can certainly generate a patch and make it available for people to
>> test it. Speaking of making kernel patches: I'm not too familiar with
>> that. Am I supposed to generate a patch against the latest (devel)
>> kernel or is 2.6.14 good enough?
>
> I can only accept patches against a recent tree. Ideally, the latest
> -mm tree. At the very least, Linus' latest (-git).

OK, will do that.

>
>> I'll try to do that over the next couple of days. I also need to
>> supply some basic information on how to use the PWM feature and it
>> also requires a new sensors.conf since the 2.6 driver doesn't do weird
>> scaling of temperature and voltage numbers anymore. It just returns
>> the true register values and any scaling is performed via the compute
>> lines in sensors.conf.
>
> This might not be acceptable with regards to the standard interface as
> defined in Documentation/hwmon/sysfs-interface. As much as possible,
> the values you pass through sysfs must make some physical sense, even
> if they are not direct readings. See how we did for the VT8231, it has
> many common points with the VT1211 so you should be able to do the same.

I did look at the documentation and it states that the return values
are supposed to be in millivolts or millicelcius. But since the
conversion from register values to physically meaningful values is
highly dependent on the board implementation I believe the whole
conversion needs to happen in userspace. I also looked at the vt8231
and the driver doesn't scale the voltage register values at all but
scales the temperature readings. It multiplies 8bit register values by
10 and 10bit register values by 2.5. I don't understand why there is
prescaling in the driver. Can't that all be done by libsensors (except
for the truncation to 8bits)?
>
>> Is it possible to host the patch on the lm-sensors webpage and maybe
>> issue a call to VT1211 users? Just like you did it with the VT8231.
>
> We can't really host temporary files on the lm-sensors webpage, but we
> can make annoucements and point to any external URI you'd have set up.
> If you can't host the patch yourself, just send it to me and I'll make
> it available on my server (if so, I'll also update it after that as
> needed.)

OK great, thanks!
...juerg


> Thanks,
> --
> Jean Delvare
>

