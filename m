From: =?utf-8?Q?G=C3=B6ran_Uddeborg?= <goeran@uddeborg.se>
Date: Tue, 21 Aug 2012 12:33:05 +0000
Subject: [lm-sensors] Chassis fan is reported incorrectly with M5A78L motherboard
Message-Id: <20531.32769.603792.771925@freddi.uddeborg>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

In the BIOS, before booting the OS, the speed of the CPU and chassis
fans are reported.  Typically, the CPU fan is around 1700 r/m, while
the chassis fan is roughly half that.

When I run "sensors" on a host with a M5A78L motherboard, it reports a
single value, a speed which seems to be the CPU fan, twice.  Both as
CPU and chassis fan.

When I look at the hardware monitor directly in the BIOS however, I do
get different speeds.  The CPU fan speed is mostly slightly above
2000, while the chassis fan speed is in the order 840-845.

This happens on a Fedora 17 system with the fillowing package versions:
lm_sensors-3.3.2-2.fc17.x86_64
kernel-3.5.1-1.fc17.x86_64

This is a typical output of "sensors":

    atk0110-acpi-0
    Adapter: ACPI interface
    Vcore Voltage:      +1.00 V  (min =3D  +0.85 V, max =3D  +1.60 V)
     +3.3 Voltage:      +3.25 V  (min =3D  +2.97 V, max =3D  +3.63 V)
     +5 Voltage:        +4.98 V  (min =3D  +4.50 V, max =3D  +5.50 V)
     +12 Voltage:      +12.08 V  (min =3D +10.20 V, max =3D +13.80 V)
    CPU FAN Speed:     1748 RPM  (min =3D  600 RPM, max =3D 7200 RPM)
    CHASSIS FAN Speed: 1748 RPM  (min =3D  600 RPM, max =3D 7200 RPM)
    CPU Temperature:    +41.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
    MB Temperature:     +37.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

    fam15h_power-pci-00c4
    Adapter: PCI adapter
    power1:       26.11 W  (crit =3D  95.04 W)

    k10temp-pci-00c3
    Adapter: PCI adapter
    temp1:        +13.2=B0C  (high =3D +70.0=B0C)
			   (crit =3D +83.5=B0C, hyst =3D +80.5=B0C)

    radeon-pci-0100
    Adapter: PCI adapter
    temp1:        +48.5=B0C =20

I reported this first as
https://bugzilla.redhat.com/show_bug.cgi?id=3D848536 but Hans de Goede
suggested this might be a more appropriate place.  He suggested a
couple of things.

I should check if I had the latest BIOS.  And I found there had indeed
been a new BIOS version released earlier this month.  (Built last
month, obviously.)  Updating BIOS always makes me nervous, but I
plucked up my courage and did it.  It doesn't seem to make any
difference.  (The CPU fan might be kept at a slightly higher speed
with the new BIOS.  But the problems I report here remain.)

Hans de Goede also suggested I should do some experiments with
different loads.  I have done that too now, both before the BIOS
upgrade and then repeated afterwards.  First I started four sha1sum:s
keeping the machine's 4 cores busy.  This made the CPU fan increase as
expected, but the chassis fan continued to read exactly the same as
the CPU fan.  It saw a bit above 2700 r/m at most.

Then I lowered to just one sha1sum.  I thought it might give a reading
in-between.  At that load, the fan ran at a bit above 2100 r/m.  And
the chassis fan always exactly the same as the CPU fan.

(If you hurry, you can see the result of my tests at
http://www.uddeborg.se/mrtg/freddi.fan.html  Don't trust anything
before Sunday.  I discovered the SNMP numbers had changed in some
update, so the readings before that didn't pick up the right values.
I fixed that just before midnight Saturday evening.)

(In the Fedora bug report I also mentioned the core voltage, but as
Hans de Goede suspected, that is just because the CPU uses lower
values when unloaded.  Under load, that value increased to what the
BIOS says.)

As a bit of extra data, here are some excerpts from dmidecode:
BIOS Information
        Vendor: American Megatrends Inc.
        Version: 1201  =20
        Release Date: 07/18/2012

Base Board Information
        Manufacturer: ASUSTeK Computer INC.
        Product Name: M5A78L

Processor Information
        Socket Designation: AM3R2
        Version: AMD FX(tm)-4100 Quad-Core Processor                =20
        Voltage: 1.4 V

And from the manual:
Chipset AMD=AE 760G (780L) / SB710

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
