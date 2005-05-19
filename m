From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: 24rf08 update
Message-Id: <3D72C90A.5FFB0D57@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D717733.227ED638@paradyne.com>
In-Reply-To: <3D717733.227ED638@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

yes. I get it, makes sense now.

Ky?sti M?lkki wrote:
> 
> On Sun, 1 Sep 2002, Mark D. Studebaker wrote:
> 
> > Ky?sti M?lkki wrote:
> >
> > > Two successive Write Quick "0" become Write Byte, only changing the
> > > reference for Read Byte transactions. This is i2cdetect operation and
> > > causes no corruption.
> > >
> > > S 0x54 Wr [A] <P><S> 0x55 Wr [A] P
> > >
> > > If this is the case, latter of the two Write Quick commands is always
> > > acknowledged by 24rf08, and does not reflect a client at that address.
> > >
> > If this were the case I would not get a detection at 0x54 and I would
> > get a detection at 0x58. But I correctly get a detection at 0x54-0x57.
> > This is true whether I use Write Quick "0" or Write Quick "1".
> 
> You would get a detection at 0x54, since at that point 24rf08
> acknowledges its address. You would not get a detection at 0x58, since
> there was an even number of Write Quicks.
> 
> Scan range 0x57 to 0x58.
> 
> --
>   Ky?sti M?lkki
>   kmalkki@cc.hut.fi
