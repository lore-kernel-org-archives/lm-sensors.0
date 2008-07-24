From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 24 Jul 2008 13:39:07 +0000
Subject: Re: [lm-sensors] [spi-devel-general] [Patch 0/4] IndustrialIO
Message-Id: <488885FB.5070500@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com> <20080723174801.GC11009@khazad-dum.debian.net> <48884F04.4070403@tremplin-utc.net> <48887201.8090300@cam.ac.uk> <48887783.5000002@tremplin-utc.net> <4888796B.9070003@cam.ac.uk> <20080724092445.ZZRA012@mailhub.coreip.homeip.net>
In-Reply-To: <20080724092445.ZZRA012@mailhub.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Piel <eric.piel@tremplin-utc.net>, Jonathan Cameron <Jonathan.Cameron@gmail.com>, mgross@linux.intel.com, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, David Brownell <david-b@pacbell.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jean Delvare <khali@linux-fr.org>, spi-devel-general@lists.sourceforge.net, Ben Nizette <bn@niasdigital.com>

Dmitry Torokhov wrote:
> On Thu, Jul 24, 2008 at 01:45:31PM +0100, Jonathan Cameron wrote:
>>>> At the moment the big missing element of the subsystem is an easy way of
>>>> querying what is there. (proc interface similar to that for the input
>>>> subsystem)
>>> You mean /sys/class/input/, right? Indeed, something inspired by the
>>> input subsystem should work well.
>> No, I meant /proc/bus/input/devices which gives machine readable description
>> of all devices registered with the input subsystem and their capabilities.
>>
> 
> /proc/bus/input is a legacy interface (pre-sysfs). Newer subsystems
> should try to stay in /sys/.
Ah, I'd assumed it was there to provide a centralized way of discovering
what was there.  I guess it's just a matter of scanning your way through
the contents of /sys/class/input (and equivalent iio) then to find out
what is present and what is supported by each device.

Messier in a sense but guess it will work.

Ah well,

Jonathan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
