From: "David O'Shea" <dcoshea@hotmail.com>
Date: Sun, 01 Mar 2009 07:14:15 +0000
Subject: Re: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <SNT103-W36873498757156B5195F30B8A80@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1041602937676786658=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
In-Reply-To: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============1041602937676786658==
Content-Type: multipart/alternative;
	boundary="_dfec91c8-7d66-47d7-b957-8266c22de38c_"

--_dfec91c8-7d66-47d7-b957-8266c22de38c_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Jean=2C

Apologies for my late reply too :)

> Date: Tue=2C 27 Jan 2009 10:44:00 +0100
[...]
> > The fact that it didn't work with the IDE could just be because I'm so
> > clueless!  Does the fact that the IDE controller has a function number
> > other than 0 affect the way the DECLARE_PCI_FIXUP_HEADER() macro is use=
d
> > or what is passed to the hook function?  Even if not=2C if you think us=
ing
> > the IDE is preferable I can have another try in case it didn't work due
> > to a stupid mistake.
>=20
> Yes=2C I would like you to try again with the IDE device=2C because there=
's
> only one IDE device and 3 USB devices so using the IDE device should be
> more efficient (quirk runs only once.)

That makes sense!  Now that I look more closely=2C I guess the 3 USB device=
s each have their own ID=2C though=2C so it wouldn't be so bad:

00:1d.0 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4=
-L/ICH4-M) USB UHCI Controller #1 [8086:24c2] (rev 01) (prog-if 00 [UHCI])
00:1d.1 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4=
-L/ICH4-M) USB UHCI Controller #2 [8086:24c4] (rev 01) (prog-if 00 [UHCI])
00:1d.7 USB Controller [0c03]: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) =
USB2 EHCI Controller [8086:24cd] (rev 01) (prog-if 20 [EHCI])

i.e. 24c2 would only pick up the first one.

> No=2C the function number shouldn't play any role. I can't see any reason
> why IDE wouldn't work.

I tried again and I guess it is an ordering issue - the special bit has to =
be set in the ISA bridge which is at 00:1f.0 but the IDE controller is at 0=
0:1f.1 so the function that sets 'asus_hides_smbus' is called after the fun=
ction that checks it.  I used '#define DEBUG 1' and 'dmesg' to verify:

>>>
pci 0000:00:1f.0: calling acpi_pm_check_graylist+0x0/0x2d
* The chipset may have PM-Timer Bug. Due to workarounds for a bug=2C
* this clock source is slow. If you are sure your timer does not have
* this bug=2C please use "acpi_pm_good" to disable the workaround
pci 0000:00:1f.0: calling old_ich_force_enable_hpet_user+0x0/0x20
HPET not enabled in BIOS. You might try hpet=3Dforce boot option
pci 0000:00:1f.0: calling asus_hides_smbus_lpc+0x0/0xa6
pci 0000:00:1f.0: calling quirk_ich4_lpc_acpi+0x0/0x65
pci 0000:00:1f.0: quirk: region f800-f87f claimed by ICH4 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region fa00-fa3f claimed by ICH4 GPIO
pci 0000:00:1f.0: calling pci_fixup_transparent_bridge+0x0/0x2b
PCI: 0000:00:1f.1 reg 10 io port: [24b0=2C 24b7]
PCI: 0000:00:1f.1 reg 14 io port: [24c0=2C 24c3]
PCI: 0000:00:1f.1 reg 18 io port: [24b8=2C 24bf]
PCI: 0000:00:1f.1 reg 1c io port: [24c4=2C 24c7]
PCI: 0000:00:1f.1 reg 20 io port: [24a0=2C 24af]
PCI: 0000:00:1f.1 reg 24 32bit mmio: [0=2C 3ff]
pci 0000:00:1f.1: calling asus_hides_smbus_hostbridge+0x0/0x22e
pci 0000:00:1f.1: quirk: FIXME: FOUND IDE=2C THIS IS A COMPAQ EVO=2C SETTIN=
G asus_hides_smbus =3D 1
pci 0000:00:1f.1: calling pci_fixup_transparent_bridge+0x0/0x2b
<<<

asus_hides_smbus_lpc() is of course the function that checks 'asus_hides_sm=
bus' and you can see it is called before we got to the point where it was s=
et.

As you can see from earlier in the mail=2C the USB controllers are at 00:1d=
 so they come before the ISA bridge and I guess that's why using one of the=
m worked for me!  Given that they each have their own ID would it be okay t=
o use them then?

Thanks again for your help!

Regards=2C
David

_________________________________________________________________
Get rid of those unwanted christmas presents! Get what you want at ebay.=20
http://a.ninemsn.com.au/b.aspx?URL=3Dhttp%3A%2F%2Frover%2Eebay%2Ecom%2Frove=
r%2F1%2F705%2D10129%2D5668%2D323%2F4%3Fid%3D10&_t=3D763807330&_r=3DhotmailT=
AGLINES&_m=3DEXT=

--_dfec91c8-7d66-47d7-b957-8266c22de38c_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Hi Jean=2C<br><br>Apologies for my late reply too :)<br><br>&gt=3B Date: Tu=
e=2C 27 Jan 2009 10:44:00 +0100<br>[...]<br>&gt=3B &gt=3B The fact that it =
didn't work with the IDE could just be because I'm so<br>&gt=3B &gt=3B clue=
less!  Does the fact that the IDE controller has a function number<br>&gt=
=3B &gt=3B other than 0 affect the way the DECLARE_PCI_FIXUP_HEADER() macro=
 is used<br>&gt=3B &gt=3B or what is passed to the hook function?  Even if =
not=2C if you think using<br>&gt=3B &gt=3B the IDE is preferable I can have=
 another try in case it didn't work due<br>&gt=3B &gt=3B to a stupid mistak=
e.<br>&gt=3B <br>&gt=3B Yes=2C I would like you to try again with the IDE d=
evice=2C because there's<br>&gt=3B only one IDE device and 3 USB devices so=
 using the IDE device should be<br>&gt=3B more efficient (quirk runs only o=
nce.)<br><br>That makes sense!&nbsp=3B Now that I look more closely=2C I gu=
ess the 3 USB devices each have their own ID=2C though=2C so it wouldn't be=
 so bad:<br><br>00:1d.0 USB Controller [0c03]: Intel Corporation 82801DB/DB=
L/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 [8086:24c2] (rev 01) (pro=
g-if 00 [UHCI])<br>00:1d.1 USB Controller [0c03]: Intel Corporation 82801DB=
/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 [8086:24c4] (rev 01) (=
prog-if 00 [UHCI])<br>00:1d.7 USB Controller [0c03]: Intel Corporation 8280=
1DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller [8086:24cd] (rev 01) (prog-if 20=
 [EHCI])<br><br>i.e. 24c2 would only pick up the first one.<br><br>&gt=3B N=
o=2C the function number shouldn't play any role. I can't see any reason<br=
>&gt=3B why IDE wouldn't work.<br><br>I tried again and I guess it is an or=
dering issue - the special bit has to be set in the ISA bridge which is at =
00:1f.0 but the IDE controller is at 00:1f.1 so the function that sets 'asu=
s_hides_smbus' is called after the function that checks it.&nbsp=3B I used =
'#define DEBUG 1' and 'dmesg' to verify:<br><br>&gt=3B&gt=3B&gt=3B<br>pci 0=
000:00:1f.0: calling acpi_pm_check_graylist+0x0/0x2d<br>* The chipset may h=
ave PM-Timer Bug. Due to workarounds for a bug=2C<br>* this clock source is=
 slow. If you are sure your timer does not have<br>* this bug=2C please use=
 "acpi_pm_good" to disable the workaround<br>pci 0000:00:1f.0: calling old_=
ich_force_enable_hpet_user+0x0/0x20<br>HPET not enabled in BIOS. You might =
try hpet=3Dforce boot option<br>pci 0000:00:1f.0: calling asus_hides_smbus_=
lpc+0x0/0xa6<br>pci 0000:00:1f.0: calling quirk_ich4_lpc_acpi+0x0/0x65<br>p=
ci 0000:00:1f.0: quirk: region f800-f87f claimed by ICH4 ACPI/GPIO/TCO<br>p=
ci 0000:00:1f.0: quirk: region fa00-fa3f claimed by ICH4 GPIO<br>pci 0000:0=
0:1f.0: calling pci_fixup_transparent_bridge+0x0/0x2b<br>PCI: 0000:00:1f.1 =
reg 10 io port: [24b0=2C 24b7]<br>PCI: 0000:00:1f.1 reg 14 io port: [24c0=
=2C 24c3]<br>PCI: 0000:00:1f.1 reg 18 io port: [24b8=2C 24bf]<br>PCI: 0000:=
00:1f.1 reg 1c io port: [24c4=2C 24c7]<br>PCI: 0000:00:1f.1 reg 20 io port:=
 [24a0=2C 24af]<br>PCI: 0000:00:1f.1 reg 24 32bit mmio: [0=2C 3ff]<br>pci 0=
000:00:1f.1: calling asus_hides_smbus_hostbridge+0x0/0x22e<br>pci 0000:00:1=
f.1: quirk: FIXME: FOUND IDE=2C THIS IS A COMPAQ EVO=2C SETTING asus_hides_=
smbus =3D 1<br>pci 0000:00:1f.1: calling pci_fixup_transparent_bridge+0x0/0=
x2b<br>&lt=3B&lt=3B&lt=3B<br><br>asus_hides_smbus_lpc() is of course the fu=
nction that checks 'asus_hides_smbus' and you can see it is called before w=
e got to the point where it was set.<br><br>As you can see from earlier in =
the mail=2C the USB controllers are at 00:1d so they come before the ISA br=
idge and I guess that's why using one of them worked for me!&nbsp=3B Given =
that they each have their own ID would it be okay to use them then?<br><br>=
Thanks again for your help!<br><br>Regards=2C<br>David<br><br /><hr />Get w=
hat you want at ebay. <a href=3D'http://a.ninemsn.com.au/b.aspx?URL=3Dhttp%=
3A%2F%2Frover%2Eebay%2Ecom%2Frover%2F1%2F705%2D10129%2D5668%2D323%2F4%3Fid%=
3D10&_t=3D763807330&_r=3DhotmailTAGLINES&_m=3DEXT' target=3D'_new'>Get rid =
of those unwanted christmas presents!</a></body>
</html>=

--_dfec91c8-7d66-47d7-b957-8266c22de38c_--


--===============1041602937676786658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1041602937676786658==--
