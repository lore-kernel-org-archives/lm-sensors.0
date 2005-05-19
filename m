From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: Fwd: Fwd: [PATCH 2.6] bmcsensors
Message-Id: <6hVLEnKE.1112614375.4189620.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705033012523d671b5f@mail.gmail.com>
In-Reply-To: <2538186705033012523d671b5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Yani,

> Thanks for your reply. I agree that changes need to be made - i2c-ipmi
> and i2c-isa *should not exist*. However the problem isn't that the
> original authors of i2c-isa and i2c-ipmi wrote bad code or had the
> wrong idea, the problem is that the lm_sensors driver model for
> hardware sensors was created on the assumption that all hardware
> drivers would be i2c driven, and has not changed despite the
> introduction of all sorts of non-i2c based hardware sensors over the
> years including isa and ipmi based, of which i2c-ipmi and i2c-isa try
> to address.

I fully agree.

> If you really want to do the right thing (c) what needs to change
> first and foremost is the lm_sensors hardware sensor model, the sensor
> access method has to be abstracted away from i2c into something more
> general, and other i2c-only legacies must also be abstracted if
> lm_sensors is going to be the centralized sensor framework in Linux
> (which I believe it should be).

In a way, the abstraction layer already exists, it's the sysfs interface
drivers export. Nothing prevents a non-i2c drivers from creating the
same sysfs files with the same conventions. The only drawback is that
userspace tools (libsensors in particular) look for chips only in
/sys/bus/i2c at the moment, so we will need to extend these tools to
look in different places. We will also need to find a way for libsensors
to find out which drivers are hardware monitoring drivers. I think that
there's something named classes in the sysfs model, maybe that's what
we need? A new "hwmon" class of drivers?

Then we'll have to move a very little part of common
hardware-monitoring-specific code away from i2c (i2c-sensor-vid.c and
i2c-sensor.h). This ain't hard, we just need to find a new home.
drivers/hwmon maybe? And rename the files, as they are not specific to
i2c at all.

Then we'll have to attach non-i2c hardware monitoring drivers to where
they belong. I am not sure I know where this is for the various isa
drivers, and even less for bmcsensors. What "bus" would you attach it
to? If there something like an IPMI bus?

> I am perfectly willing to help in this effort and to re-write parts or
> all of the driver in the aim of doing the right thing, however we
> cannot just blindside all those people out there who want to access
> their ipmi based sensors now (likewise we can't just get rid of the
> isa based sensor functionality that many are using). The time to ditch
> i2c-ipmi/i2c-isa is the time we have a functional (and stable)
> alternative.

I am not going to break the existing i2c-isa drivers (but I AM going to
transform it radically, because that's needed). As for
i2c-ipmi/bmcsensors, it's not yet in the kernel, and you provide
patches for people who want them, so there's no need to worry. By
delaying the integration of your patch into the kernel until some things
have been cleaned up, we are not preventing anyone from using your
patches.

Since I am currently trying to separate the i2c-isa specific code from
the i2c core, I know what must not be done for i2c-ipmi/bmcsensors.
i2c-ipmi must NOT register itself with i2c-core, neither must
bmcsensors. Only i2c clients can be registered with the i2c core,
because in a way clients are the abtraction layer you were talking
about. I will have a very hard time extracting all the i2c-isa stuff
from the i2c core just because i2c-isa was considered an almost normal
i2c adapter, and was registered with the core. Let's not do the same
error again.

> Similarly I am working on dynamic callbacks (which would seem at first
> glance to be an extremely simple patch to device.h), but as MDS
> suggested instead of waiting for this patch to be accepted (or not)
> and modify bmcsensors to work with it, why not submit what I have that
> people are using, is stable and works now.

Could you please post your proposed change to device.h? I'd sure like to
take a look.

You are correct, let's not add dependencies where they do not exist.

(I would however create less nodes by default than you do. 100 is really
much.)

Note however that the fact that your code "is stable and works"
doesn't mean it'll get accepted. To be accepted, the code must work
AND be technically correct. That's where the problem is, obviously.

> The bmcsensors/i2c-ipmi 2.6 port is functional, stable and has been
> out and used by people for more than a year (and its 2.4 equivalent
> much longer), I have submitted it now due to the demand from the
> people who use it to have it included along with the rest of
> lm_sensors.

As a side note, the 2.4 version is not exactly well maintained. i2c-ipmi
has lots of warnings, and lm_sensors 2.9.0 was released with a
bmcsensors driver which wouldn't even compile. Thus I seriously
question the large userbase you are invoking.

Now I don't deny the fact that people asked you for the driver to be
pushed in mainstream. But again this doesn't fly if the code is not
something we can accept from a technical point of view.

> Quite simply people who have switched to 2.6 from 2.4 don't want to
> loose the ability to access their sensors waiting for us to
> re-implement the ipmi and isa functionality in a better way, and I
> don't think we should just abandon them in such a way.

Again they have your patches if they want, and this works just fine as
you said. So let's not rush.

I have started working on the i2c-isa issue, and think I have a first
working step in converting i2c-isa from a bus driver (dumb i2c_adapter)
to an i2c-core-like thing for isa hardware monitoring drivers. This
duplicates some code of course, and requires minor changes to 9 (isa)
chip drivers, but this opens the door to a whole lot cleanups all around
the place, both in the i2c core and in the isa-only drivers (6 of them).
I'll work as fast as possible (partly depends on how much attention
Greg can pay to this) and I hope to have a big series of patches ready
by the end of the week. Once this is done, I think that things will be
much more clear (well, less obscure at least), and the next steps to
really make the isa drivers independant from the i2c core will be easier
to find.

If you want to take a look, my preliminary patch is here (I improved it
since, will update this evening):
http://jdelvare.net1.nerim.net/sensors/linux-2.6.12-rc1-bk5-i2c-isa-separated.diff

Some stats and a partial plan are here (needs update too):
http://jdelvare.net1.nerim.net/sensors/notes.txt

Once i2c-isa is done (even partly) we'll have a better idea of what can
(and should) be done for i2c-ipmi/bmcsensors.

Thanks,
--
Jean Delvare
