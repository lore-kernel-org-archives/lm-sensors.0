From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 14 Jun 2005 10:20:24 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <V39aOfsf.1118736491.7657320.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Yani,

> Ok, here it is after a cold reboot, looks a bit different:

Looks very similar to me, except that the W83627HF ISA detection fails,
right? Not really surprising, as part of this detection is experimental
and known to be broken for recent Super-I/O chips.

> > 2.6 kernel with CONFIG_PNPACPI? Check /proc/ioports, see if there's
> > something conflicting at 0x290-0x297.
> Running 2.6.11.12 with CONFIG_PNPACPI=y and in /proc/ioports:
> -----------------------------------
> ...
> 0295-0296 : pnp 00:07
> ..
> -----------------------------------

Known problem then. The ISA interface of the W83627HF won't work until
you disable PNPACPI.
  http://bugzilla.kernel.org/show_bug.cgi?id@14

I think that it means that your ACPI tables are broken and Tyan should
fix them (they advertise 0x295-0x296 as the W83627HF hardware monitoring
address range, instead of 0x290-0x297).

> modprobe w83781d force_subclients=1,0x28,0x4a,0x4b seems to fail with
> the same message again even though the w83627hf driver hasn't been
> loaded.

I took a look at the w83781d driver and it doesn't play nicely when
subclients are disabled. However, using force_subclients should not only
change the addresses but also reenable the subclients, so I'm surprised
it didn't work.

Could you please provide a dump of your chip? The register I am
interested in is 0x4A. You may try to write 0x01 to it and see if the
subclients show and it it helps the w83781d driver loading.

Thanks,
--
Jean Delvare
