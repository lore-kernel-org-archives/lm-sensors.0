From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 24 Jul 2008 12:45:31 +0000
Subject: Re: [lm-sensors] [spi-devel-general] [Patch 0/4] IndustrialIO
Message-Id: <4888796B.9070003@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com>	<20080723174801.GC11009@khazad-dum.debian.net> <48884F04.4070403@tremplin-utc.net> <48887201.8090300@cam.ac.uk> <48887783.5000002@tremplin-utc.net>
In-Reply-To: <48887783.5000002@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Piel <eric.piel@tremplin-utc.net>
Cc: Jonathan Cameron <Jonathan.Cameron@gmail.com>, mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, David Brownell <david-b@pacbell.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jean Delvare <khali@linux-fr.org>, spi-devel-general@lists.sourceforge.net, Ben Nizette <bn@niasdigital.com>

hat done for the next
>> version (maybe driver specific for now).
> Yes, on a second though, this is a low priority point. If userspace is
> able to know if the hardware has or not freefall detection, it should be
> possible to just implement the software detection in the userspace
> daemon. People might come up with lots of "clever" algorithms for that,
> so it might be better to not do too much in the kernel ;-)
Good point; will leave that one for now.
 
> 
>>
>> At the moment the big missing element of the subsystem is an easy way of
>> querying what is there. (proc interface similar to that for the input
>> subsystem)
> You mean /sys/class/input/, right? Indeed, something inspired by the
> input subsystem should work well.
No, I meant /proc/bus/input/devices which gives machine readable description
of all devices registered with the input subsystem and their capabilities.

Makes it easier to make userspace code reasonably generic.

--
Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
