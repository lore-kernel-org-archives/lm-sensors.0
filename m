From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 15 May 2006 21:52:10 +0000
Subject: [lm-sensors] compaq evo w6000
Message-Id: <4468F80A.1000804@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4464301C.9030003@tu-bs.de>
In-Reply-To: <4464301C.9030003@tu-bs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> 
> 0000:00:00.0 Host bridge: Intel Corp. 82860 860 (Wombat) Chipset Host 
> Bridge (MCH) (rev 04)
> 0000:00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP 
> Bridge (rev 04)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 04)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
> 0000:00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04)
> 0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04)
> 0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04)
> 0000:01:00.0 VGA compatible controller: nVidia Corporation NV10GL 
> [Quadro] (rev 10)
> 0000:02:06.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] 
> (rev 09)
> 0000:02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM 
> Ethernet Controller (rev 03)
> 0000:02:0d.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
> 


> Can anybody help me to solve this problem? Maybe some unix commands that 
> can give me the right
> values?

Quick howto:
1) lspci -n will tell you the IDs, you will need: pci Id of 0000:00:1f.0

first part is 8086: which is intel, second part is the requested ID

2) quick hack the quirks.c

change this:
static int __initdata asus_hides_smbus = 0;
to
static int __initdata asus_hides_smbus = 1;

Then recompile and run. you should now see the smbus. If not then take the pci 
ID from step 1 and change following line:
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_0, 
asus_hides_smbus_lpc );

into
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   0xNNNN,  asus_hides_smbus_lpc );

where NNNN is you ID number.

If you are able to see the smbus device run sensors-detect and please report if 
you found some useful devices. If so, proper quirk needs to be developed. You 
should provide:
lspci
lspci -n
lspci -v -v -v
lspci -v -v -v -n

Hope it helps.

Good night,
Rudolf

