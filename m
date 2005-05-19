From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <FJY2q3Wz.1114501331.6179700.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg, Yani, all,

> Care to show how a driver would use this change?

I would like to see this too. I have thought about it, and just cannot
see how a pointer will be convenient to use.

Yani said earlier that a pointer would be fine for bmcsensors. However,
the device files are defined at driver level, not device level (at least
for all other hardware monitoring drivers). This means that the pointer
would need to be pointing at something driver-specific, which doesn't
make much sense as far as I can see. This is the reason why having the
additional parameter be an offset makes more sense to me. The callback
function already receives a device-specific pointer (dev * itself), and
the offset can be used to point to any part of the private data, at the
driver's option.

One possibility would be to start allocating the device files dynamically
instead of having them static as we do now. They would no more be shared
between devices. That way, the additional parameter could actually be
device-specific, and then I agree that a pointer can make sense
(although it still doesn't look optimum in the sensors case). But that
would be an even bigger change (and possibly not an enjoyable one
performance-wise).

> And the void * shouldn't be called ptr, use what other structures call
> their void pointers, "data", "private", etc.

What are these other structures, BTW? I'd like to take a look at them,
maybe it would enlighten my views.

Thanks,
--
Jean Delvare
