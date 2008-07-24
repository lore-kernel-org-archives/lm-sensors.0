From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 24 Jul 2008 12:20:07 +0000
Subject: Re: [lm-sensors] [spi-devel-general] [Patch 0/4] IndustrialIO
Message-Id: <48887377.2030905@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com>	<20080723174801.GC11009@khazad-dum.debian.net>	<48884F04.4070403@tremplin-utc.net> <20080724100833.GB8301@fluff.org.uk>
In-Reply-To: <20080724100833.GB8301@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-linux@fluff.org>
Cc: Eric Piel <eric.piel@tremplin-utc.net>, mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, David Brownell <david-b@pacbell.net>, Jonathan Cameron <Jonathan.Cameron@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jean Delvare <khali@linux-fr.org>, spi-devel-general@lists.sourceforge.net, Ben Nizette <bn@niasdigital.com>

Dear Ben,
>> In particular, what I think would be worthy would be:
>> * Up to 3 pre-defined axes (X, Y, Z) - that's provided by your current  
>> version of industrialio
>> * If the accelerometer is soldered on the computer, define once for all  
>> to which _physical_ movement corresponds which axis (eg: a laptop on its  
>> normal position going up has axis Z increasing).
>> * Free fall event. Either it's hardware detected, or the accelerometer  
>> infrastructure will detect it in software.
>> * For each axis, what is the maximum and minimum bound and the unit -  
>> Probably worthy for the whole ADC infrastructure
>> * Joystick emulation (calibrated so that when the computer is not  
>> moving, all the values are at 0). All the current drivers have it.
> 
> I think if we're trying to make something that will cover a number
> of device classes, we need to be more like HID and have a system
> that reports and possibly records the following:
Ok, this is the key disagreement at the moment on the approach to be
taken here.  I'd again argue that the purpose of events in this subsys
are very different from what you describing.  Events tend to indicate
that something has happened (eg. the Free fall even mentioned above),
not that the current value of something is x.  It may be that we
will have devices that do indeed act closer to you conventional
user interface device and provide (x moved to 103 etc).  If we
do then this may all need rethinking.
 
> 1) What data is possible to be returned from each event, with the
>    units, magnitude and any scale applied by the device sending.
> 
> 2) Each event should be able to report a number of items, so that
>    if the sensor reports X/Y/Z in one go, there is just a single
>    event containing those values.
Agreed.
 
> 3) A well defined set of information that can be read (like #1)
>    that can provide details of the device and how it relates to
>    the environment it is in.
Indeed, this is crucial and probably forms the next element of the
code to be written.  At the moment I'm inclined to go with an approach
similar to the input subsystem with it's proc interface that provides
a nice machine readable description of device functionality.

Anyone have any other suggestions on how this can be sensibly achieved?

Thanks,
--
Jonathan Cameron

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
