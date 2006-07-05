From: hancockr@shaw.ca (Robert Hancock)
Date: Wed, 05 Jul 2006 23:59:29 +0000
Subject: [lm-sensors] Generic interface for accelerometers (AMS, HDAPS,
Message-Id: <44AC5261.9050708@shaw.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.GOQkHC8inXir2wbg4bZayOWXzAY@ifi.uio.no>
 <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no>
In-Reply-To: <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>

Henrique de Moraes Holschuh wrote:
> HDAPS talks to the embedded controller using IO over the LPC bus, and not to
> the accelerometer chip or to a simple A/D i2c chip which is used excusively
> for accelerometer access.  The EC interface for HDAPS data retrieval is
> not friendly to any errors, and hardlocks the machine somehow if any
> firmware bugs hit or if we violate any of the rules (that are not written
> anywhere) about how to access the EC without geting the SMBIOS unhappy.
> 
> So, turning off HDAPS polling while it is not necessary really looks like a
> good idea overall.
> 
> We are investigating the ACPI global lock as a way to at least get the
> SMBIOS to stay away from the EC while we talk to it, but we don't know if
> the entire SMBIOS firmware respects that lock.

It had better, that is exactly what the ACPI Global Lock is supposed to 
prevent (concurrent access to non-sharable resources between the OS and 
SMI code). The ACPI DSDT contains information on whether or not the 
machine requires the Global Lock in order to access the EC or whether it 
is safe to access without locking.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr at nospamshaw.ca
Home Page: http://www.roberthancock.com/


