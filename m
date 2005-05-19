From: tomhol@gmail.com (Tomas Holmqvist)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: I'd like to join the mailling list/New driver for smsc47m15x
Message-Id: <1c9de3e4050307013772dd4f96@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1c9de3e4050306120552945ab@mail.gmail.com>
In-Reply-To: <1c9de3e4050306120552945ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In the functional diagram of the chip there's no connections between
the SuperIO parts and the HMB, There's no mention of any registers in
the LPC interface holding voltage/temp values and there's even the
sentences:

"It should be noted that there are two main interfaces used to access
the components of this chip. The LPC interface is used to access the
Super I/O registers and the SMBus is used to access the Hardware
Monitoring registers." -
http://www.smsc.com/main/tools/discontinued/47m15x.pdf page 26.

So, a multi interface driver or separate drivers for the separate
functions, is needed.
As there's already a driver for the fans on the LPC interface, i've
implemented my driver separate from the fan one.

On Sun, 06 Mar 2005 15:20:20 -0500, Mark Studebaker <mds@mds.gotdns.com> wrote:
> Tomas Holmqvist wrote:
> > Hi everybody.
> >
> > I've written a driver for the Hardware Monitoring Block (HMB) of the smsc47m15x.
> > That is the part of this chip that sits on the I2C bus. The other
> > functions of this Super IO are controlled via ISA. The HMB is just a
> > voltage/temp sensor quite similar to the lm78.
> >
> > There are still some small bugs to resolve, I only just found out how
> > to compile it in the kernel tree.
> >
> > I'm using the I2C_DRIVERID_EXP0 id, but when loading it my other
> > drivers are not found when using the sensors tool.
> >
> > Should I post the code here or keep it for my self until it works
> > without obvious bugs?
> >
> > The driver is written with the 2.6.11rc3 kernel, whatever state of
> > lm_sensors that mean. 2.9.0 I think.
> >
> > /Tomas
> >
> 
> Isn't the HMB also accessible via superio/ISA, but in a separate "device" than the fan block?
> If so ISA is much preferred over a split ISA/i2c driver.
> 
>
