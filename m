From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Not Support Chip
Message-Id: <3DE660A2.FAACEB13@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021128092949.GA4637@bbnslab>
In-Reply-To: <20021128092949.GA4637@bbnslab>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you need the 24c3 device enabled. If you can't turn ACPI or similar
function
on in the BIOS, see prog/hotplug/README.p4b for how to fix.
good luck
mds

Yun-Ta Tsai wrote:
> 
> Here it is :-)
> lspci -n----
> 00:00.0 Class 0600: 8086:1a30 (rev 11)
> 00:01.0 Class 0604: 8086:1a31 (rev 11)
> 00:1d.0 Class 0c03: 8086:24c2 (rev 01)
> 00:1d.1 Class 0c03: 8086:24c4 (rev 01)
> 00:1d.2 Class 0c03: 8086:24c7 (rev 01)
> 00:1d.7 Class 0c03: 8086:24cd (rev 01)
> 00:1e.0 Class 0604: 8086:244e (rev 81)
> 00:1f.0 Class 0601: 8086:24c0 (rev 01)
> 00:1f.1 Class 0101: 8086:24cb (rev 01)
> 01:00.0 Class 0300: 10de:0251 (rev a2)
> 02:03.0 Class 0401: 13f6:0111 (rev 10)
> 02:04.0 Class 0c00: 1033:00f2 (rev 01)
> 02:08.0 Class 0200: 8086:103a (rev 81)
> ----
> lspci---
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
> Bridge (rev
> 11)
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
> (rev 11
> )
> 00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
> 00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
> 00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
> 00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81)
> 00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
> 00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
> 01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4
> Ti4400] (re
> v a2)
> 02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
> 10)
> 02:04.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00f2 (rev
> 01)
> 02:08.0 Ethernet controller: Intel Corp.: Unknown device 103a (rev 81)
> ---
> 
> On Thu, Nov 28, 2002 at 12:20:41PM -0500, Mark D. Studebaker wrote:
> > please send us the output of 'lspci -n'
> >
> > Yun-Ta Tsai wrote:
> > >
> > > sensor-detect output---
> > > BIOS vendor (ACPI): ASUS
> > > System vendor (DMI): System Manufacturer
> > > BIOS version (DMI): ASUS P4B533-E ACPI BIOS Revision 1004
> > > We can start with probing for (PCI) I2C or SMBus adapters.
> > > You do not need any special privileges for this.
> > > Do you want to probe now? (YES/no):
> > > Probing for PCI bus adapters...
> > > Sorry, no PCI bus adapters found.
> > >
> > > We will now try to load each adapter module in turn.
> > > end of output---
> > >
> > > Chipset(from motherboard manual):
> > >         Intel 82845E MCH
> > >         Intel 82801 DB ICH4
> > >
> > > Thanks
> > >
> > > Best Regards
> > >
> > > Tim
> > >
> > >
> > >                      Name: default.txt
> > >    default.txt       Type: Plain Text (text/plain)
> > >                  Encoding: quoted-printable
> > >               Description: PGP =?big5?B?xl+wzSAweDM4REQ3OUVDoUM=?> 
> 
>                   Type: application/pgp-keys
>    Part 1.2   Encoding: quoted-printable
>            Description: PGP =?big5?B?xl+wzSAweDM4REQ3OUVDoUM=?
