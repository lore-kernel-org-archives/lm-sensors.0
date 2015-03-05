From: Jon Torrey <jonutorrey@gmail.com>
Date: Thu, 05 Mar 2015 18:52:18 +0000
Subject: Re: [lm-sensors] W83627DHG unable to load driver
Message-Id: <CAP1ifEKbuwsrkTOr1WwerQDo-WV77S8zw9nvmVEW=jjtb8KZLg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP1ifE+haCeVp12UPK9kzMeoEV93PgVnFbjoLED2hePgtfg6gg@mail.gmail.com>
In-Reply-To: <CAP1ifE+haCeVp12UPK9kzMeoEV93PgVnFbjoLED2hePgtfg6gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you much for the valuable information Guenter.

Regards,
JT

On Thu, Mar 5, 2015 at 1:42 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Mar 05, 2015 at 12:55:50PM -0500, Jon Torrey wrote:
> > >
> > > The hardware monitoring function in the chip was not activated
> > > by the BIOS.
> >
> >
> > All I can see under Super IO Configuration ( inside the BIOS ) is Serial
> > Port configuration along with a Parallel Port configuration.
> > Would this have anything to do with ACPI?  I do see something ISA related
> > when invoking lspci if that makes any difference?
> >
> No, this is a chip configuration problem.
>
> > I have seen this on some Supermicro server boards, where
> > > hardware monitoring is handled by an IPMI chip.
> >
> >
> > I have an American Megatrends BIOS for an i7 processor on an embedded
> > board.  I do not believe it has an IPMI chip.
> >
> >
> > > Enabling the chip manually from user space is technically possible,
> >
> > but I would not recommend it
> >
> >
> > How would I go about doing this?  I ran superiotool and got the following
> > in return:
> >
> >  superiotool r6637
> >
> > Found Winbond W83627HF/F/HG/G (id=0x52, rev=0x41) at 0x2e
> >
> Yes, but its hardware monitoring functionality is still disabled.
>
> Many possibilities: It may be a BIOS configuration bug, it might be
> on purpose and there is nothing connected to the SuperIO chip's hardware
> monitoring pins, or the vendor doesn't want customers to access the chip.
> You might want to get in touch with the board vendor and ask.
>
> Thanks,
> Guenter
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
