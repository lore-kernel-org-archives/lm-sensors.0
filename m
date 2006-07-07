From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Fri, 07 Jul 2006 02:46:04 +0000
Subject: [lm-sensors] Generic interface for accelerometers (AMS, HDAPS,
Message-Id: <20060707024603.GC22666@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.GOQkHC8inXir2wbg4bZayOWXzAY@ifi.uio.no> <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no> <44AC5261.9050708@shaw.ca> <20060706061930.GA6033@suse.cz>
In-Reply-To: <20060706061930.GA6033@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Robert Hancock <hancockr@shaw.ca>, Pavel Machek <pavel@suse.cz>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>

On Thu, 06 Jul 2006, Vojtech Pavlik wrote:
> > >We are investigating the ACPI global lock as a way to at least get the
> > >SMBIOS to stay away from the EC while we talk to it, but we don't know if
> > >the entire SMBIOS firmware respects that lock.
> > 
> > It had better, that is exactly what the ACPI Global Lock is supposed to 
> > prevent (concurrent access to non-sharable resources between the OS and 
> > SMI code). The ACPI DSDT contains information on whether or not the 
> > machine requires the Global Lock in order to access the EC or whether it 
> > is safe to access without locking.
>  
> Isn't that vaild only if you actully use ACPI to access the EC? (AFAIK
> the HDAPS driver does direct port access.)

It better be valid for any OS-side access to the EC, otherwise the ACPI
global lock would be utterly useless.  The system vendor would have done its
own "global-lock-like" functionality without the need for an ACPI global
lock specification.

What is not clear to me is whether an ACPI DSDT method is on the "OS side"
or on the "SMM side" of the ACPI global lock.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

