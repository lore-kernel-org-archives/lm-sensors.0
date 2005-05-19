From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: [Fwd: Re: join i2c ml + question]
Message-Id: <3E2D8966.6000908@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message ------
Date: Tue, 21 Jan 2003 09:35:15 +0100
From: Markus Schorer <ms@plain.de>
Organization: plain electronic publishing
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Edelbrock <phil@Ren.netroedge.com>
Subject: Re: join i2c ml + question



hi,

maybe i have an answer for you:
i do the servicing in a tasklet. this does work quite well for me,
although the code is rather clumsy. it even seems to be the right 
way for the furture.
so if anybody has any questions reagrding interrupts and i2c 
(i'm also using i2c-elektor WITH interrupt),
it seems that i am the man. ;-)

regards,

Philip Edelbrock wrote:
> 
> I'll add you to the list, Markus.
> 
> BTW- Interrupts in I2C is an topic which has come up in the past.  I'm not
> sure if a good solution has come from it yet.
> 
> Phil
> 
> On Mon, 20 Jan 2003, Mark Studebaker wrote:
> 
> > the i2c mailing list is dead
> > for the sensors mailing list contact phil@netroedge.com
> >
> > I don't think any of the sensors drivers use irq's.
> > There are a couple in the i2c package (grep irq kernel/*.c).
> > I don't know if any of them are anything good enough to use
> > for an example...
> > we are working on bringing our drivers in line with 2.4/2.5
> > standards, I'm not sure which of those is the closest
> > to your "elegant" standard...
> >
> > mds
> >
> >
> > Markus Schorer wrote:
> > > hi,
> > >
> > > i would like to join the linux-i2c ml.
> > >
> > > and my question is: ;-)
> > >
> > > i have a i2c controlled chip, that has a "data available" signal.
> > > i've connected it to an interrupt.
> > > how do i service the chip, eg read the data, in/from an interrupt?
> > >
> > > is this a case for a bottom half? what options do i have?
> > > what is elegant?
> > >
> > > regards,
> > >
> >

-- 
_ plain GmbH_______________________________________________________
  markus schorer              fon 089.540.149.0
  daiserstrasse 15 RGB        fax 089.540.149.44
  81371 m?nchen               http://www.plain.de


