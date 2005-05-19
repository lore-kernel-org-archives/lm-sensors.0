From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: i2c-sis630 bus driver (was Re: last call for 2.6.5)
Message-Id: <20020918111425.W20006@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020917150545.S20006@Stimpy.netroedge.com>
In-Reply-To: <20020917150545.S20006@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Wed, Sep 18, 2002 at 12:39:50PM +0200, Alexander Malysh wrote:
> Hi Phil,All:
> 
> Am Mittwoch, 18. September 2002 00:05 schrieb phil@netroedge.com:
> > BTW- My workstation at work has an integrated sis630.  It comes up
> > like this:
> >
> > [root@drtheopolis lm_sensors2]# lspci -v -d 1039:6300
> > 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
> > SiS630 GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
> > 	Subsystem: Asustek Computer, Inc.: Unknown device 8032
> > 	Flags: 66Mhz, medium devsel, IRQ 11
> > 	BIST result: 00
> > 	Memory at f0000000 (32-bit, prefetchable) [size8M]
> > 	Memory at ea000000 (32-bit, non-prefetchable) [size8K]
> > 	I/O ports at c800 [size8]
> > 	Capabilities: [40] Power Management version 1
> > 	Capabilities: [50] AGP version 2.0
> >
> [snip]
> I have this one too ... It's only VGA-Card. Can you please provide full 
> lspci -vvv from this board ?

Sure, here it is:

[root@drtheopolis phil]# lspci -d 1039:6300 -vvv
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
SiS630 GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 8032
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size8M]
	Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size8K]
	Region 2: I/O ports at c800 [size8]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

> >
> > As a test, I substituted PCI_DEVICE_ID_SI_630 with 0x6300:
> 
> no needed anymore , the driver have force option for this :)

Can we have the driver detect it instead of requiring the users to 
force it?  I mean, the driver is for the SiS630, and this PCI device 
is a SiS630.  It wouldn't be obvious to a user that they not only use 
the driver, but must force it to use it.

> 
> >
> >         /* Look for the SIS630 */
> >         if (!(sis630_dev = pci_find_device(PCI_VENDOR_ID_SI,
> >                                             PCI_DEVICE_ID_SI_503,
> >                                             sis630_dev))) {
> >                 printk(KERN_ERR "i2c-sis630.o: Error: Can't detect
> > SIS630!\n"); return -ENODEV;
> >         }
> >         tmp > > pci_find_device(PCI_VENDOR_ID_SI,/*PCI_DEVICE_ID_SI_630*/0x6300,NULL); if
> > (tmp = NULL && force = 0) {
> >                 printk(KERN_ERR "i2c-sis630.o: Error: Can't detect
> > SIS630!\n"); return -ENODEV;
> >         }
> >
> > And, things seems to be working thus far (but perhaps a bit slow):
> 
> yes it's slow, because I have disabled change of the Host Master Clock  (it's 
> hang  my Laptop) ... You can try to change i2c-sis630.c at line 194
> from: sis630_write(SMB_CNT, 0x00);
> to: sis630_write(SMB_CNT, 0x20);

With just some brief testing, it seems to work.  Doesn't seem much 
faster, but it works.

> In this case Host Master Clock will be changed to 56KHz and should be a bit 
> faster :) Tell me please if it works for you ...

I'm OK with it being slow for the sake of added stability/reliability.  


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
