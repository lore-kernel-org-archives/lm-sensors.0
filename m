From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: Fwd: Fwd: [PATCH 2.6] bmcsensors
Message-Id: <25381867050403153326afa292@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705033012523d671b5f@mail.gmail.com>
In-Reply-To: <2538186705033012523d671b5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for your reply. I agree that changes need to be made - i2c-ipmi
and i2c-isa *should not exist*. However the problem isn't that the
original authors of i2c-isa and i2c-ipmi wrote bad code or had the
wrong idea, the problem is that the lm_sensors driver model for
hardware sensors was created on the assumption that all hardware
drivers would be i2c driven, and has not changed despite the
introduction of all sorts of non-i2c based hardware sensors over the
years including isa and ipmi based, of which i2c-ipmi and i2c-isa try
to address.

If you really want to do the right thing (c) what needs to change
first and foremost is the lm_sensors hardware sensor model, the sensor
access method has to be abstracted away from i2c into something more
general, and other i2c-only legacies must also be abstracted if
lm_sensors is going to be the centralized sensor framework in Linux
(which I believe it should be).

I am perfectly willing to help in this effort and to re-write parts or
all of the driver in the aim of doing the right thing, however we
cannot just blindside all those people out there who want to access
their ipmi based sensors now (likewise we can't just get rid of the
isa based sensor functionality that many are using). The time to ditch
i2c-ipmi/i2c-isa is the time we have a functional (and stable)
alternative.

Similarly I am working on dynamic callbacks (which would seem at first
glance to be an extremely simple patch to device.h), but as MDS
suggested instead of waiting for this patch to be accepted (or not)
and modify bmcsensors to work with it, why not submit what I have that
people are using, is stable and works now.

The bmcsensors/i2c-ipmi 2.6 port is functional, stable and has been
out and used by people for more than a year (and its 2.4 equivalent
much longer), I have submitted it now due to the demand from the
people who use it to have it included along with the rest of
lm_sensors.

Quite simply people who have switched to 2.6 from 2.4 don't want to
loose the ability to access their sensors waiting for us to
re-implement the ipmi and isa functionality in a better way, and I
don't think we should just abandon them in such a way.

Yani

On Apr 1, 2005 5:10 AM, Jean Delvare <khali@linux-fr.org> wrote:
> 
> Hi Yani,
> 
> > Was client.id removed just because none of the ported drivers in the
> > kernel was using it? A cursory glance at the 2.4 code (which includes
> > i2c-ipmi) might have shown this isn't necessarily true for drivers
> > that are in the process of being ported. Do any of the other
> > sensors/busses yet to be ported to 2.6, or in the process, have a
> > reliance on it?
> 
> The i2c_client.id was removed because most of the existing drivers in 2.6
> were not using it. The few of those which did were using it uniquely
> identify the client in log messages, but the various dev_* loggers
> already identify the device uniquely so it was redundant.
> 
> The reason why removing i2c_client.id was considered is because the i2c
> core doesn't use it. This means that, if a driver ever needs to keep a
> unique identifier on every client, it has to store it withing the client
> private data (i2c_client.data.id or whatever. This doesn't change much
> from this driver's point of view, but at least avoids including a
> mostly useless id field in all i2c clients in the kernel. The
> i2c_client.id removal killed dozens of (useless) lines of code and saved
> 4 bytes of memory per client. I'd do it again.
> 
> The problem you face here is possibly caused by the fact that i2c-ipmi
> and bmcsensors are not an i2c adapter driver and an i2c chip driver.
> They were hacked into the i2c subsystem because it sounded easy back
> then. I am continuously cleaning up the i2c subsystem in 2.6, step by
> step, and drivers which do not belong to this subsystem and are using
> hacks might break. I am not going to stop the cleanup process for them.
> Instead, they will have to be rewritten not to use random hacks.
> 
> The first candidate is i2c-isa. It is in no way an i2c adapter. The i2c
> core has various hacks to handle it because it is such a special case.
> As a result, even people using ISA-only hardware monitoring chips (most
> recent Super-I/O chip with integrated sensors fall into this category)
> still need to load the whole i2c subsystem. This doesn't make any
> sense, and I want to clean this up. This will make the i2c core much
> cleaner, will speed up the registration of i2c clients, and will open
> the path to even more cleanups and optimizations.
> 
> Now I understand that it doesn't exactly help you in your process of
> porting bmcsensors to Linux 2.6, and I am sorry about that. I also
> understand that you are not the author of the original
> i2c-ipmi+bmcsensors design, so I am not blaming you in any way for it.
> All I mean is that I want less hacks in the i2c subsystem, not more. I
> will work on the i2c-isa case and, if I can solve it, it should also
> provide hints on how the bmcsensors case can be solved. I will most
> probably need your assistance for this though, as I have next to zero
> knowledge on IPMI.
> 
> --
> Jean Delvare
>
