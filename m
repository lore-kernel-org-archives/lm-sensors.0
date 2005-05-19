From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Support of AMD-8111 for lm_sensors
Message-Id: <3DCEB4E4.D9E18DA9@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107182005.A830@ucw.cz>
In-Reply-To: <20021107182005.A830@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK.
I did the SMBus 2.0 support in i2c-core and i2c-i801, you're the
first person I know of to use it besides me, I'll look at what you did
and
I welcome any comments. Have you tested the 2.0 support?

Nobody working on 6650 or 1026; if you start, let us know,
and we will update our new drivers page to say that.

Vojtech Pavlik wrote:
> 
> On Thu, Nov 07, 2002 at 05:48:53PM -0500, Mark Studebaker wrote:
> 
> > can you send me the 8111 datasheet please?
> 
> I'm sorry, I can not. I thought it was public, but apparently it is not
> yet. It'll appear on the AMD website sooner or later, though.
> 
> Anyway, the new driver together with the ACPI 2.0 spec should be enough
> self-explaining, and I can tell you that the 8111 spec is mostly a
> cut-and-paste from the ACPI 2.0 spec in the SMBus 2.0 controller
> chapter.
> 
> Another issue - I'll be needing drivers for the max6650 and adm1026
> monitoring chips - are there any plans for supporting those, or do I
> have to write the support myself?
> 
> Vojtech
> 
> > Vojtech Pavlik wrote:
> > >
> > > Hi!
> > >
> > > The AMD-8111 IO-Hub (which you likely haven't seen yet, but definitely
> > > will at some point in time), has two SMBus interfaces, one SMBus 1.0
> > > interface, same as in other AMD chipsets (AMD-756, etc), and one SMBus
> > > 2.0 interface modelled after the ACPI 2.0 SMBus interface specification.
> > >
> > > The attached patches add support for both the interfaces, one by
> > > modifying the i2c-amd756 driver, and the second by creating a new
> > > i2c-amd8111 driver.
> > >
> > > I tried to write the new driver as cleanly as possible, so I hope you'll
> > > be able to include the patches into the next lm_sensors release without
> > > any major problems.
> > >
> > > Thanks,
> > > --
> > > Vojtech Pavlik
> > > SuSE Labs
> > >
> > >   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> > >
> > >    i2c-2.6.5-8111.diffName: i2c-2.6.5-8111.diff
> > >                       Type: Plain Text (text/plain)
> > >
> > >    lm_sensors-2.6.5-8111.diffName: lm_sensors-2.6.5-8111.diff
> > >                              Type: Plain Text (text/plain)
> 
> --
> Vojtech Pavlik
> SuSE Labs
