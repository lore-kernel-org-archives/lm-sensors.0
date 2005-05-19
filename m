From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: 24rf08 update
Message-Id: <Pine.OSF.4.44.0209031620270.31430-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D717733.227ED638@paradyne.com>
In-Reply-To: <3D717733.227ED638@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 1 Sep 2002, Mark D. Studebaker wrote:
> Ky?sti M?lkki wrote:
>
> > Two successive Write Quick "0" become Write Byte, only changing the
> > reference for Read Byte transactions. This is i2cdetect operation and
> > causes no corruption.
>
> > It also means 2 x Write Quick would reset the state machine and prevent
> > corruption...
>
> So if we add a second Write Quick "0" - only in the range 54-57 is
> necessary - that sounds like a good fix. Agreed?

That's good first aid.

To be Really Safe (TM), one must not release adapter lock in between.
EEPs could still corrupt if you have a sensor module loaded and you run
i2cdetect.

Also sensor clients' attach_adapter uses Write Quick, often followed by
Read Byte Data. Currently only eeprom.o is left in the mentioned
range.  So maybe i2c-core deserves an option of doubling, preventing
or faking Write Quick's in the range.

I don't know about SMBus, but i2c defines multi-master topology.
Unless we can force SCL low between the two Quicks, some embedded
controller can still screw things up for us.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi

