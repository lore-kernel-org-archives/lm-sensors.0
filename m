From: Eric Piel <eric.piel@tremplin-utc.net>
Date: Thu, 24 Jul 2008 12:37:23 +0000
Subject: Re: [lm-sensors] [spi-devel-general] [Patch 0/4] IndustrialIO
Message-Id: <48887783.5000002@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com>	<20080723174801.GC11009@khazad-dum.debian.net> <48884F04.4070403@tremplin-utc.net> <48887201.8090300@cam.ac.uk>
In-Reply-To: <48887201.8090300@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jonathan Cameron <Jonathan.Cameron@gmail.com>, mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, David Brownell <david-b@pacbell.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jean Delvare <khali@linux-fr.org>, spi-devel-general@lists.sourceforge.net, Ben Nizette <bn@niasdigital.com>

Jonathan Cameron schreef:
:
>> * If the accelerometer is soldered on the computer, define once for all 
>> to which _physical_ movement corresponds which axis (eg: a laptop on its 
>> normal position going up has axis Z increasing).
> Agreed, though this is more documentation (and strict enforcement on drivers)
Indeed, it's more about defining conventions. A one page document saying 
to userspace developers how they can expect any accelerometer driver 
will behave is desperately needed. The more conventions, the more all 
the drivers will behave similarly, and the easier it will be for 
userspace programs to be written :-)

>> * Free fall event. Either it's hardware detected, or the accelerometer 
>> infrastructure will detect it in software.
> Hadn't thought of doing that in software - should be relatively straight
> forward, though would involve a fairly large overhead if the intention
> is to detect it fast enough to park hardware etc. (similar to that for
> the ring buffer I guess).  I'll look into getting that done for the next
> version (maybe driver specific for now).
Yes, on a second though, this is a low priority point. If userspace is 
able to know if the hardware has or not freefall detection, it should be 
possible to just implement the software detection in the userspace 
daemon. People might come up with lots of "clever" algorithms for that, 
so it might be better to not do too much in the kernel ;-)


> 
> At the moment the big missing element of the subsystem is an easy way of
> querying what is there. (proc interface similar to that for the input subsystem)
You mean /sys/class/input/, right? Indeed, something inspired by the 
input subsystem should work well.

See you,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
