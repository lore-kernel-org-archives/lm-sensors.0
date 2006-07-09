From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 09 Jul 2006 20:32:45 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44B167ED.1000608@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> it is AN8-SLI with BIOS 19.
Hmm, the uguru on that should have firmware version 2.3.x.x I wouldn't
expect much trouble with that, maybe my timeouts are just a bit too
close to the critical limit.

> I have recompiled the module and haven't seen
> the behaviour so far. I will post once I see the timeout messages and
> failure during boot again.
> 

I don't expect a recompile to fix it, but if it does thats great. what
you could try if it comes back is raising (try doubling for starters)
the following defines:
First the most likely candidate:
#define ABIT_UGURU_WAIT_TIMEOUT 250
No once all the "timeout exceeded waiting for xxxx state" messages are
gone I would expect the other one: "CMD reg does not hold 0xAC after
ready command" to also be gone, if its not try raisjng this define:
#define ABIT_UGURU_READY_TIMEOUT 50

Thanks & Regards,

Hans


