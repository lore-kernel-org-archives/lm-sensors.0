From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: How to activate the SMBus on P4B533E/ICH4?
Message-Id: <20020621092703.H20935@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.31.0206192315370.4147-100000@klaus.dns2go.com>
In-Reply-To: <Pine.LNX.4.31.0206192315370.4147-100000@klaus.dns2go.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The only way I know of to add 'new' PCI devices is to enable them in
the Bios.  (sometimes 'enabling' APCI will make some PCI devices to
show up, for example.)


Phil


On Fri, Jun 21, 2002 at 10:25:42AM +0200, Klaus Woltereck wrote:
> On Thu, 20 Jun 2002, Mark Studebaker wrote:
> 
> > ich4 supported in CVS (assuming it's in lspci and you don't need p4b)
> > bach not supported
> 
> Hi Mark,
> 
> here is the lspci output:
> -------------------------------------------------------------------------
> 00:00.0 Host bridge: Intel Corporation: Unknown device 1a30 (rev 11)
> 00:01.0 PCI bridge: Intel Corporation: Unknown device 1a31 (rev 11)
> 00:1d.0 USB Controller: Intel Corporation: Unknown device 24c2 (rev 01)
> 00:1d.1 USB Controller: Intel Corporation: Unknown device 24c4 (rev 01)
> 00:1d.2 USB Controller: Intel Corporation: Unknown device 24c7 (rev 01)
> 00:1d.7 USB Controller: Intel Corporation: Unknown device 24cd (rev 01)
> 00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI
> (rev 81)
> 00:1f.0 ISA bridge: Intel Corporation: Unknown device 24c0 (rev 01)
> 00:1f.1 IDE interface: Intel Corporation: Unknown device 24cb (rev 01)
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc.: Unknown device
> 2527 (rev 01)
> 02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
> 10)
> 02:04.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00f2 (rev
> 01)
> 02:08.0 Ethernet controller: Intel Corporation: Unknown device 1039 (rev
> 81)
> 02:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
> -------------------------------------------------------------------------
> If I understand i2c-i801.c right, there have be a PCI device ID "24C3".
> 
> So, how do I 'create' an PCI device ID entry in the kernel's PCI device
> list?
> 
> Bye,
> Klaus

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
