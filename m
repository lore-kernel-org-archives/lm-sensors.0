From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: 24rf08 update
Message-Id: <3D75680B.12A81B39@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D717733.227ED638@paradyne.com>
In-Reply-To: <3D717733.227ED638@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

in-line

phil@netroedge.com wrote:
> 
> Good work guys!  Nice to have narrowed it down to a broken I2C
> implementation on a particular chip.  Detection has always been
> difficult task to make absolutely safe.
> 
> It also seems to match what Joe from Australia described, and what we
> were suspecting.
> 
> So to recap (from my understanding of where we stand), is this true?
> 
> - The only corruption that happens with this chip is in
>   sensors-detect?
> 
true on my system.

> - If sensors-detect is run to avoid 0x54-0x58, the problem is avoided?
> 
0x54-57.

> - We have a working patch for sensors-detect which works identically
>   as before, but avoids the corruption (and detects the chip
>   as eeproms)?
> 
true. But (of course) on an IBM system, sensors-detect won't get that
far
because of the DMI detection.

> - The regular eeprom.o driver does not corrupt the chip, and works
>   as expected?
> 
true, with one exception.
The eeprom driver doesn't work perfectly because the chip treats
00-7f as one 'bank' and 80-ff as a second bank. When you don't
reset the address, reads wrap at the end of a bank. So
eeprom shows the 00-7f contents at both 00-7f and 80-ff.
i2cdump works correctly because it sends the address for each read.
This had me going for a while...


> - There are no complications with the 'protection' address of the chip
>   and probing?
> 
true. I don't know if that's because the 0x5c address location works,
or because its memory only goes from 00 - 1f, and the corruption would
happen at b8 (= 5c << 1)

> Phil
> 
> On Sun, Sep 01, 2002 at 10:12:26PM -0400, Mark D. Studebaker wrote:
> > yes. I get it, makes sense now.
> >
> > Ky?sti M?lkki wrote:
> > >
> > > On Sun, 1 Sep 2002, Mark D. Studebaker wrote:
> > >
> > > > Ky?sti M?lkki wrote:
> > > >
> > > > > Two successive Write Quick "0" become Write Byte, only changing the
> > > > > reference for Read Byte transactions. This is i2cdetect operation and
> > > > > causes no corruption.
> > > > >
> > > > > S 0x54 Wr [A] <P><S> 0x55 Wr [A] P
> > > > >
> > > > > If this is the case, latter of the two Write Quick commands is always
> > > > > acknowledged by 24rf08, and does not reflect a client at that address.
> > > > >
> > > > If this were the case I would not get a detection at 0x54 and I would
> > > > get a detection at 0x58. But I correctly get a detection at 0x54-0x57.
> > > > This is true whether I use Write Quick "0" or Write Quick "1".
> > >
> > > You would get a detection at 0x54, since at that point 24rf08
> > > acknowledges its address. You would not get a detection at 0x58, since
> > > there was an even number of Write Quicks.
> > >
> > > Scan range 0x57 to 0x58.
> > >
> > > --
> > >   Ky?sti M?lkki
> > >   kmalkki@cc.hut.fi
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
