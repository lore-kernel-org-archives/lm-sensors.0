From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: Fwd: Fwd: [PATCH 2.6] bmcsensors
Message-Id: <Mx7D029e.1112346644.1939470.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705033012523d671b5f@mail.gmail.com>
In-Reply-To: <2538186705033012523d671b5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Yani,

> Was client.id removed just because none of the ported drivers in the
> kernel was using it? A cursory glance at the 2.4 code (which includes
> i2c-ipmi) might have shown this isn't necessarily true for drivers
> that are in the process of being ported. Do any of the other
> sensors/busses yet to be ported to 2.6, or in the process, have a
> reliance on it?

The i2c_client.id was removed because most of the existing drivers in 2.6
were not using it. The few of those which did were using it uniquely
identify the client in log messages, but the various dev_* loggers
already identify the device uniquely so it was redundant.

The reason why removing i2c_client.id was considered is because the i2c
core doesn't use it. This means that, if a driver ever needs to keep a
unique identifier on every client, it has to store it withing the client
private data (i2c_client.data.id or whatever. This doesn't change much
from this driver's point of view, but at least avoids including a
mostly useless id field in all i2c clients in the kernel. The
i2c_client.id removal killed dozens of (useless) lines of code and saved
4 bytes of memory per client. I'd do it again.

The problem you face here is possibly caused by the fact that i2c-ipmi
and bmcsensors are not an i2c adapter driver and an i2c chip driver.
They were hacked into the i2c subsystem because it sounded easy back
then. I am continuously cleaning up the i2c subsystem in 2.6, step by
step, and drivers which do not belong to this subsystem and are using
hacks might break. I am not going to stop the cleanup process for them.
Instead, they will have to be rewritten not to use random hacks.

The first candidate is i2c-isa. It is in no way an i2c adapter. The i2c
core has various hacks to handle it because it is such a special case.
As a result, even people using ISA-only hardware monitoring chips (most
recent Super-I/O chip with integrated sensors fall into this category)
still need to load the whole i2c subsystem. This doesn't make any
sense, and I want to clean this up. This will make the i2c core much
cleaner, will speed up the registration of i2c clients, and will open
the path to even more cleanups and optimizations.

Now I understand that it doesn't exactly help you in your process of
porting bmcsensors to Linux 2.6, and I am sorry about that. I also
understand that you are not the author of the original
i2c-ipmi+bmcsensors design, so I am not blaming you in any way for it.
All I mean is that I want less hacks in the i2c subsystem, not more. I
will work on the i2c-isa case and, if I can solve it, it should also
provide hints on how the bmcsensors case can be solved. I will most
probably need your assistance for this though, as I have next to zero
knowledge on IPMI.

--
Jean Delvare
