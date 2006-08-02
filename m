From: drasko.draskovic@gmail.com (Drasko Draskovic)
Date: Wed, 02 Aug 2006 08:30:34 +0000
Subject: [lm-sensors] I2C for uCLinux on ARM926EJ (with AMBA bus)
Message-Id: <5ec3d7930608020130l40ef55fdv5475834cc1c1c334@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5ec3d7930608010704g39ff5710u35686e708c152a7d@mail.gmail.com>
In-Reply-To: <5ec3d7930608010704g39ff5710u35686e708c152a7d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/1/06, Mark M. Hoffman <mhoffman at lightlink.com> wrote:
>
> Hi:
>
> (Again... moving to i2c list)
>
> * Drasko Draskovic <drasko.draskovic at gmail.com> [2006-08-01 17:35:11
> +0200]:
> > On 8/1/06, Drasko Draskovic <drasko.draskovic at gmail.com> wrote:
> > >
> > >
> > >Hi. I am working on a custom design that is based on ARM926EJ and AMBA
> > >bus. OS of choice is uCLinux, patched with RTAI for RT performance. I
> > >have to implement now I2C support, but looking at the existing driver
> > >things seem a bit unclear for me.
> > >
> > >Here is what I unserstood:
> > >i2c-core.c is independent of the bus and is kernel module. This should
> > >be working. But  what about AMBA bus? Is it supported? Is this file for
> > >support of AMBA located in 'busses' directory? What are algos files? As
> > >I undersand, these are bus dependent. Is AMBA supported by these?
> > >
> > >If there are not, does anyone have idea how these can be written?
> > >
> > >How can a proper working of I2C be tested? Can some dummy I2C
> > >peripheral be created in Linux?
> > >
> > >Any information will be more than helpful.
> > >
> > >
> > I also want to ask following things:
> > ARM has Amba Peripheral I2C Bus Controller (ApI2c), which I guess is a
> > bridge between Amba and I2C (which comes out of the chip on two pins).
>
> Ah, OK.  That's the thing for which you want to write an "adapter" driver.
>
> > So, can you tell me:
> > 1) what abot 'buses' part? It has to be dependeant on Amba?
>
> You will need a driver in drivers/i2c/busses that supports the API2C.
>
> > 2) what about 'chips part? Does it have to depend on ApI2c?
>
> You may (or may not) need a driver in driver/i2c/chips to support whatever
> it is that you plan to connect to your I2C bus.  Drivers in this directory
> are independent of the I2C bus/adapter drivers.
>
> Or, you could drive your I2C slave devices completely from userspace using
> the i2c-dev mechanism.
>
> > 3) Do I have to write only adapter part -- is this the peice of code
> > that is ApI2c dependant, and not 'chips' part?
>
> I don't know what you "have" to do.  In your first message you mention
> "implement now I2C support".  This probably means (at least) writing an
> API2C bus/adapter driver.
>
> > I am still not clear which part of driver ('algos', 'busses', and
> > 'chips') depends on what... And waht of existing I can use from existing
> and
> > what I
> > have to write by myself.
>
> Read Documentation/i2c/* please.
>
> Regards,
>
> --
> Mark M. Hoffman
> mhoffman at lightlink.com
>
>
Hi,
thank you all very much for your time, especially Mark.

So, it looks like I'll have to investigate bus/adapter for ApI2c. As I
understand, since AMBA is supported in kernel, if adapter part of i2c driver
code is writen for ApI2c, than I2C on this architecture would be functional
(if I for example use eeprom as a pripheral, which is already supposrtd chip
by lm code). Is this right?

Also, I wanted to ask the question what about algos? Do I have to worry
about that? I mean - is just writing adapter part enogh, so I can transmit
and receive messages?

I am wondering -- how come that so popular architecture as ARM (adn AMBA
ApI2c interface) is not already supported by lm code...

Cheers,
-- 
Drasko DRASKOVIC

Software Developer
Elsys-DESIGN
Belgrade, Serbia
Tel. +381.11.311.5252
Fax. +381.11.311.5251
www.elsys-design.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060802/88c387b3/attachment-0001.html 
