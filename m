From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Need assistance with enabling the SMBus on an Intel 855PM 82801DB
Message-Id: <425ED847.7080402@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <e294b46e05041407152efe4f8b@mail.gmail.com>
In-Reply-To: <e294b46e05041407152efe4f8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

There is only a little chance that some known chip is there. You can try on your risk to enable it.
You need simply to edit drivers/pci/quirks.c
Notably the static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)

If you dont know how to do it just provide

lspci -v
lspci

Or boot 2.4 kernel and try the p4b_smbus.c

I can try to help you with that.

On the other hand if you have ACPI working you can try acpi -V command and if you have thermal zone module loaded
you will get temp information. If you do not have acpi working you can try to fix it on your own.

http://forums.gentoo.org/viewtopic.php?t2145

I hope this helps.

Regards

Rudolf

Bradley Chapman wrote:
> I've been trying to figure out how to enable the SMBus on my Sager
> NP3760 (aka a Clevo M375E), and after doing some research I have found
> that the Intel 82801DB chip does have an SMBus, but that my laptop
> BIOS has most likely disabled it.
> 
> I found the p4b_smbus.c module after reading
> http://archives.andrew.net.au/lm-sensors/msg26375.html and the
> remainder of said thread, but I haven't been able to make p4b_smbus.c
> compile on a 2.6.10 kernel.
> 
> Relevant bits of lspci:
> 
> 0000:00:00.0 0600: 8086:3340 (rev 21)
> 0000:00:01.0 0604: 8086:3341 (rev 21)
> 0000:00:1d.0 0c03: 8086:24c2 (rev 03)
> 0000:00:1d.1 0c03: 8086:24c4 (rev 03)
> 0000:00:1d.2 0c03: 8086:24c7 (rev 03)
> 0000:00:1d.7 0c03: 8086:24cd (rev 03)
> 0000:00:1e.0 0604: 8086:2448 (rev 83)
> 0000:00:1f.0 0601: 8086:24cc (rev 03)
> 0000:00:1f.1 0101: 8086:24ca (rev 03)
> 0000:00:1f.5 0401: 8086:24c5 (rev 03)
> 0000:00:1f.6 0703: 8086:24c6 (rev 03)
> 0000:01:00.0 0300: 1002:4e50
> 0000:02:00.0 0200: 10ec:8169 (rev 10)
> 0000:02:02.0 0c00: 104c:8026
> 0000:02:03.0 0280: 8086:4220 (rev 05)
> 0000:02:09.0 0607: 104c:ac54 (rev 01)
> 0000:02:09.1 0607: 104c:ac54 (rev 01)
> 0000:02:09.2 0880: 104c:8201 (rev 01)
> 
> 0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
> Controller (rev 21)
> 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP
> Controller (rev 21)
> 0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
> 0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
> 0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
> 0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB
> 2.0 EHCI Controller (rev 03)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
> 0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
> Storage Controller (rev 03)
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
> 0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> AC'97 Modem Controller (rev 03)
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350
> [Mobility Radeon 9600 M10]
> 0000:02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8169 Gigabit Ethernet (rev 10)
> 0000:02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
> IEEE-1394a-2000 Controller (PHY/Link)
> 0000:02:03.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
> 0000:02:09.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
> 0000:02:09.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
> 0000:02:09.2 System peripheral: Texas Instruments: Unknown device 8201 (rev 01)
> 
> Does anyone else with a Clevo M375E know if I will find any
> interesting chips on the 82801DB's SMBus if I ever manage to enable
> it?
> 
> TIA,
> 
> Brad
