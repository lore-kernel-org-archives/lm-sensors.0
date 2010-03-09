From: Phillip Pi <ant@zimage.com>
Date: Tue, 09 Mar 2010 22:50:05 +0000
Subject: Re: [lm-sensors]
Message-Id: <20100309225005.GA29595@alpha.zimage.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> > On Tue, Mar 09, 2010 at 07:11:47PM +0200, Zeev Tarantov wrote:
> > > =A0[ =A0 11.329457] w83627ehf: Found W83627EHG chip at 0x290
> > > =A0[ =A0 11.329585] ACPI: I/O resource w83627ehf [0x295-0x296] confli=
cts with ACPI region SEN1 [0x295-0x296]
> > >
> > > =A0[ =A0 11.329659] ACPI: If an ACPI driver is available for this dev=
ice, you should use it instead of the native driver
> > >
> > > =A0Does "acpi_enforce_resources=3Dlax" fix this for you?
> >
> > I believe so, but I was told that this isn't a good idea?
>=20
> If your BIOS uses NMI to access the monitoring chip, because there is
> no locking and access to the chip is uncoordinated between the BIOS
> and the OS driver, the chip can receive strange commands, enter
> invalid states, change configuration dangerously, etc.
> The bad scenario I can come up with is that the BIOS has a feature to
> automatically control the speed of fans and the voltage of
> circuits/chips based on temperature sensors. Because the chip is
> accessed simultaneously by BIOS and OS, it returns something strange
> as a temperature reading. The BIOS then sets some bad value as voltage
> or fan speed, which might result in a crash or even physical damage to
> hardware (over-voltage, overheating, etc.).
> Another problem is the system might just spontaneously shutdown to
> protect the hardware from overheating, despite the temperatures being
> all normal, because of a strange temp reading due to simultaneous
> access to the chip.
> In laptops, power management features are more advanced and more
> necessary than in desktops. Sometimes they can't be disabled because
> the manufacturer doesn't want customers returning melted computers
> after foolishly disabling overheating protection both in the BIOS and
> in the OS.
> If the computer is a desktop, I'd consider disabling those features in
> the BIOS and relying solely on the OS and userspace tools.
> If you use the computer as is for a long time with the OS driver
> enabled and it doesn't crash and you don't see weird readings in the
> monitoring system, then I'd consider it safe; meaning your BIOS isn't
> touching anything. The computer I'm typing on has been used for two
> years that way without any issues.

Thanks. The only thing my friend and I noticed was the voltage values=20
weren't correct. Everything else looked OK. It's hard to compare to=20
BIOS' readings due to reboots. ;)

I do not use any automatic fan control (always at max with the third
party CPU fan, Thermaltake Silent Boost K8 A1838 model). I did use AMD's
Cool'n'Quiet and PowerNow-K8, but someone said this is OK to use with
lm_sensors.

Unless I missed options in my CMOS to disable features and to let=20
lm_sensors/drivers/modules do the readings? FYI,=20
http://www.msi.com/index.php?func=3Ddownloadfile&dnoA17&type=3Dmanual for=20
the PDF manual copies for my old MSI K8N Neo4-F motherboard/mobo.
--=20
Quote of the Week: "This isn't a war. It never was a war, any more than
there's war between man and ants." --artilleryman from H.G. Wells' The
War of the Worlds
  /\___/\
 / /\ /\ \         Phil./Ant @ http://antfarm.ma.cx (Personal Web Site)
| |o   o| |                Ant's Quality Foraged Links: http://aqfl.net
   \ _ /                 E-mail: philpi@earthlink.net or ant@zimage.com
    ( )

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
