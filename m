From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 20 Jan 2006 19:48:43 +0000
Subject: [lm-sensors] Super-IO locking
Message-Id: <20060120204843.6ae574c2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43CAF458.8080707@gmail.com>
In-Reply-To: <43CAF458.8080707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> SuperIO devices typically hide many functional units behind 2 io-bus 
> addresses.  These various units/devices will obviously have separate
> drivers to control them, leading to the potential that 2 drivers
> will clash over the 'port'.

This is true. There have been a proposal from Evgeniy Poliakov in year
2004 for a new superio subsystem which would have addressed the issue.
Back then, it looked awfully complex to me. It seems to have vanished
since, so the problem is still there.

> As I see it, we need a place to put a lock for the sio port, ideally
> without creating a dependency of one driver on another. That said,
> it seems a bit like overkill to create a 3rd module which merely
> holds the lock that both drivers use, and therefore depend upon.
> IOW, this replaces one dependency for another.

Direct dependencies aren't realistic, as you may have more than two
drivers interested in one given Super-I/O device. Also, two devices
from the same family may require a different set of drivers to cover
all the functions, so you may end up with a complex network of
dependencies. The only realistic solution is a centralized one, where
one dedicated piece of code controls the access to the I/O ports, and
other drivers kindly ask for the permission when they need to access it.

> OTOH, an sio-lock manager which provides a lock for any sio port user
> (that uses the helper) could be justified.  There are a bunch of SuperIO
> units in the hwmon/* world, so this seems like the right place to find
> potential module clients.
>
> Any comments ?

So far, we have been limiting the possible problems for hardware
monitoring drivers by only accessing the Super-I/O ports during module
initialization. This has some limitations (like VID pins being read
only once, or some runtime configuration changes being impossible) but
is sufficient in most cases.

Implementing a centralized superio controller is not trivial. There are
decisions to be made. Do we want a complete subsystem, or a simple
helper? Do we want to provide a complete API to the specific LPC
registers (logical device selection, activation register, I/O base
registers, interrupt configuration, etc)? Or do we simply want a
generic I/O ports multiplexer, with a very simple interface? Or both?
Most Super-I/O chips follow the Intel LPC standard, living at 0x2e or
0x4e, but I think some live at strange addresses, and/or do not follow
the regular register mapping. How do we handle these?

The detection part won't be easy either. While answering the question
"is this Super-I/O device present at address X" is pretty simple
(that's what individual drivers do at the moment), pre-detecting
Super-I/O devices promises to be a difficult task. What ports do we
want to probe? Given that probing these ports means writing to them, we
better be careful. Also, each Super-I/O chip may have a different
"access key", so we'd need to try all known keys. Once we're in, the
different chips use different registers for identification. Register
0x20 is the most commonly used, but some chips use other registers in
the 0x21-0x2f range for a complete identification.

Now, if anyone wants to take his/her chance with an experimental
implementation, I'll be happy to review it. I'm fine with a simple
implementation local to hardware monitoring drivers to start with.

Thanks,


-- 
Jean Delvare

