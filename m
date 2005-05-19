From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Hidden and disabled SMBus SiS0016, please enable
Message-Id: <20031221032830.GB31965@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FE4DB3C.8050504@baldauf.org>
In-Reply-To: <3FE4DB3C.8050504@baldauf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Xuan Baldauf <xuan--sensors--2003.12.20@baldauf.org> [2003-12-21 00:29:00 +0100]:
> Hello Alex and Mark,
> 
> I'm referring to your discussions at 
> http://archives.andrew.net.au/lm-sensors/msg01299.html
> 
> I have got a new notebook "Mitac 8640m". (The same as in 
> http://archives.andrew.net.au/lm-sensors/msg03881.html ) It is based on 

I re-read that thread and laughed: is your machine really labelled
"Packard Bell"?  I can't remember the last time I saw that name on
a computer in the US - at least not since 1995.  They had an *awful*
reputation.

> Unfortunately, the I/O-ports will not be enabled,
> 
>    * neither under Windows using MBM 5.3.5.0
>    * nor under Linux 2.6 using i2c-sis96x (Linux 2.6.0)
>    * nor under Linux 2.4 using i2c-sis645 (lm-sensors 2.8.2).
> 
> I can verify this by looking at the PCI config space word at byte offset 
> 0x04 ("PCI_COMMAND", see 
> http://lxr.linux.no/source/include/linux/pci.h?v=2.6.0#L28 ).  For I/O 
> ports being enabled bit 0 (PCI_COMMAND_IO) has to be set. This is not 
> the case:
> 
> <MBM PCI Dump>
> Bus :00 Device :02 Func :01 Vendor :1039 Device ID :0016
> 
>  $0000:  39 10 16 00 00 00 80 02 00 00 05 0C 00 00 00 00
> </MBM PCI Dump>
> 
> Under Linux 2.4 and Linux 2.6, I can try to manually set 
> PCI_COMMAND=0x01. This works, so that then modules "i2c-sis96x" and 
> "i2c-sis645" respectively can be loaded.

When you say "manually", where and how did you do this?  If you put it
in the driver(s), would you like to send a patch? ;)  I suspect it
wouldn't help in your case though...

>    * But under Linux 2.6, "i2cdetect 0" returns only "XX" results and
>      is pretty slow. I enabled the "#define DEBUG" in the sourcecode if
>      "i2c-sis96x" and saw that every request to the SMBus times out.
>    * Under Linux 2.4, "i2cdetect 0" or "sensors" crashes with a
>      (recoverable) kernel oops

The result under 2.6 says that your SMBus is not connected to anything
at all - sorry.  I don't think it's unusual for a notebook to just
leave it disconnected.

But, what about this kernel oops under 2.4?  Whatever the state of the
hardware, this shouldn't happen.  Could you give more details about that?
I2C and lm_sensors versions, how you built them, anything else special...
And of course a copy of the oops message itself.

> So I'm asking you (Alex and Mark) wether it is possible to enable the 
> device not just by unhiding it, but also by enabling I/O-ports and other 
> stuff I'm not familiar with so that the SMBus device will get usable.

You've really searched through the mailing lists, and I appreciate that.
Unfortunately, it also means I have nothing more to add... as you've
already tried what I would have recommended.  Without sensors on the
SMBus or ISA bus, the only other possibility is ACPI - and for that
you'll need to ask elsewhere.

> I'm willing to run tests, alpha versions and the like.

Sure, I would appreciate if you could help me to debug that 2.4 kernel
oops.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
