From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Jul 2012 13:26:42 +0000
Subject: Re: [lm-sensors] GA-Z77X-UD3H with ITE IT8728F, modprobe it87 freezes system
Message-Id: <20120711152642.59944368@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJiZuY3QBnkcAsisvbg9pEzMt044aVBF+vwzrCHsGTS_N9ez1A@mail.gmail.com>
In-Reply-To: <CAJiZuY3QBnkcAsisvbg9pEzMt044aVBF+vwzrCHsGTS_N9ez1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stevie,

On Tue, 10 Jul 2012 16:24:55 +0200, Stevie Trujillo wrote:
> I have a Gigabyte GA-Z77X-UD3H motherboard with a 3570k CPU and 32GiB ram.
>   * ISA bus, address 0xa30
>     Chip `ITE IT8728F Super IO Sensors' (confidence: 9)
> 
> I run Gentoo with linux-3.4.4, if I do "modprobe it87" the system freezes.
> I was told GA-Z77X-D3H (not UD3H) works in Debian Squeeze with 3.2
> kernel from Debian backports.
> I installed Squeeze, for me it freezes there too:
> 
> # modprobe it87
> it87: Found IT8728F chip at 0xa30, revision 1
> it87: Beeping is supported
> * here it froze*

Very odd. I think this is the first report of that kind. You are not
booting with acpi_enforce_resources=lax or =no, are you?

> How can I fix/debug this?

I have no immediate idea. Please check in /proc/ioports if you see
anything suspicious at address 0xa30. 

I have added a module parameter to the it87 driver. The updated driver
is here:
  http://khali.linux-fr.org/devel/misc/it87/
Build instructions are at:
  http://khali.linux-fr.org/devel/misc/INSTALL

You can load this it87 driver with write=0 to disable all register
writes. This will tell us if at least the driver works when not writing
to registers (I expect so.)

If that works, then please unload the driver and reload with write=2.
This will log every register write right before it happens. So the last
message logged is likely to point to a register write which is
inappropriate for your device/board.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
