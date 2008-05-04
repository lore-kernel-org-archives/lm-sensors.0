From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 May 2008 07:57:43 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080504095743.5041549c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 03 May 2008 23:18:48 +0200, achim wrote:
> > I don't think that this rules out overclocking. The overclocked CPU
> > died, the non-overclocked one froze but is still alive. If nothing
> > else, it suggests that the overclocked CPU was more fragile against
> > whatever happened.
>
> It sorted out the coincidence theory.

I don't think it did. While it is clear that accessing address 0x2e on
the SMBus causes system lockups or reboots (it has been tested
repeatedly by different persons on different motherboards), the fact
that your CPU died is still a single case, and the same experiments
with a different CPU (fortunately) didn't kill it. So it is still
possible that the death of your CPU at this moment was a coincidence
(or put in another way, maybe your CPU would have died the day after
without this, and the 0x2e probing just triggered it earlier.)

>                                        I agree with you that the
> overclocked cpu was more fragile. I spotted a week ago that the cpu was
> not as robust as at the beginning.While inspecting the capabilities of
> the northbridge I ran stability testings for about ~30hrs with
> northbridge voltages at around 1.4V (1.3V is stock). After that the
> system was no longer stable at 2.8GHz with 1.3125V (1.3V stock). Going
> back to 2.7GHz fixed the stability issues. I ran this for at least a
> days without any problems till it froze. It was just a coincidence that
> i used lm-sensors and not typical windows monitoring tools.=20
>=20
> > Looks a lot like that older bug report I mentioned where probing
> > address 0x2e rebooted the machine. Probably designed by the same
> > person, using the same or similar chip.
>
> Exactly in oposite to the user of the DFI Lanparty board with the nvidia
> chipset i get no hangups when i load the it87 module manual without
> parameters excluding 0x2e.

That's because I've since updated the it87 driver to no longer probe
address 0x2e:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=C5e3fbf22ccba0879b174fab7ec0e322b1266c2c
And then I even dropped the SMBus interface support from the it87 driver
completely:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=8E9afcbbdef71aeeb510732f4f8d5ac3de863df0

If you were running an older kernel you'd experience the same problems
the reported had when loading the it87 driver.

> > In general, people using a BIOS which was not meant for their
> > motherboard should know that they are doing something wrong and should
> > be ready to face the consequences. That being said, it would be easy
> > enough to blacklist this other motherboard as well, presumably it has
> > the same problems. Can you provide the dmidecode information for the
> > DFI board / BIOS?
>
> Other already tried to flash the dfi bios on the sapphire board and i
> also used it for weeks because the bios the board was shipped with had
> all type of issues.
> So I switched to the latest stable DFI bios and attached a dmidecode
> dump here.

OK, thanks. Here's an updated patch which also blacklists the DFI
variant.

> I also tried i2cdump at 0x4e and 0x6e.
> Same results as with the sapphire bios. Again the 0x6e dump stopped at
> 0x9e and outputs only XX till i reboot, a reload of the i2c-piix4 module
> does not help here.

I'm not surprised, I don't think it has anything to do with the BIOS,
this is most probably a low-level hardware problem.

* * * * *

We had a report that running sensors-detect on a Sapphire AM2RD790
motherbord killed the CPU. While the exact cause is still unknown,
I'd rather play it safe and prevent any access to the SMBus on that
machine by not letting the i2c-piix4 driver attach to the SMBus host
device on that machine.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/i2c-piix4.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

--- linux-2.6.25.orig/drivers/i2c/busses/i2c-piix4.c	2008-04-19 11:11:56.00=
0000000 +0200
+++ linux-2.6.25/drivers/i2c/busses/i2c-piix4.c	2008-05-04 09:44:42.0000000=
00 +0200
@@ -108,7 +108,25 @@ static unsigned short piix4_smba;
 static struct pci_driver piix4_driver;
 static struct i2c_adapter piix4_adapter;
=20
-static struct dmi_system_id __devinitdata piix4_dmi_table[] =3D {
+static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] =3D {
+	{
+		.ident =3D "Sapphire AM2RD790",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "SAPPHIRE Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "PC-AM2RD790"),
+		},
+		.ident =3D "DFI Lanparty UT 790FX",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "DFI Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "LP UT 790FX"),
+		},
+	},
+	{ }
+};
+
+/* The IBM entry is in a separate table because we only check it
+   on Intel-based systems */
+static struct dmi_system_id __devinitdata piix4_dmi_ibm[] =3D {
 	{
 		.ident =3D "IBM",
 		.matches =3D { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
@@ -123,8 +141,16 @@ static int __devinit piix4_setup(struct=20
=20
 	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
=20
+	/* On some motherboards, it was reported that accessing the SMBus
+	   caused severe hardware problems */
+	if (dmi_check_system(piix4_dmi_blacklist)) {
+		dev_err(&PIIX4_dev->dev,
+			"Accessing the SMBus on this system is unsafe!\n");
+		return -EPERM;
+	}
+
 	/* Don't access SMBus on IBM systems which get corrupted eeproms */
-	if (dmi_check_system(piix4_dmi_table) &&
+	if (dmi_check_system(piix4_dmi_ibm) &&
 			PIIX4_dev->vendor =3D PCI_VENDOR_ID_INTEL) {
 		dev_err(&PIIX4_dev->dev, "IBM system detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
