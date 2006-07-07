From: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 07 Jul 2006 09:31:38 +0000
Subject: [lm-sensors] Generic interface for accelerometers (AMS, HDAPS,
Message-Id: <20060707093138.GD11026@suse.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.GOQkHC8inXir2wbg4bZayOWXzAY@ifi.uio.no> <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no> <44AC5261.9050708@shaw.ca> <20060706061930.GA6033@suse.cz> <20060707024603.GC22666@khazad-dum.debian.net>
In-Reply-To: <20060707024603.GC22666@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Pavel Machek <pavel@suse.cz>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>

On Thu, Jul 06, 2006 at 11:46:04PM -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 06 Jul 2006, Vojtech Pavlik wrote:
> > > >We are investigating the ACPI global lock as a way to at least get the
> > > >SMBIOS to stay away from the EC while we talk to it, but we don't know if
> > > >the entire SMBIOS firmware respects that lock.
> > > 
> > > It had better, that is exactly what the ACPI Global Lock is supposed to 
> > > prevent (concurrent access to non-sharable resources between the OS and 
> > > SMI code). The ACPI DSDT contains information on whether or not the 
> > > machine requires the Global Lock in order to access the EC or whether it 
> > > is safe to access without locking.
> >  
> > Isn't that vaild only if you actully use ACPI to access the EC? (AFAIK
> > the HDAPS driver does direct port access.)
> 
> It better be valid for any OS-side access to the EC, otherwise the ACPI
> global lock would be utterly useless.  The system vendor would have done its
> own "global-lock-like" functionality without the need for an ACPI global
> lock specification.

That's what I fear does happen on many systems.

> What is not clear to me is whether an ACPI DSDT method is on the "OS side"
> or on the "SMM side" of the ACPI global lock.

No idea, sorry.

-- 
Vojtech Pavlik
Director SuSE Labs

