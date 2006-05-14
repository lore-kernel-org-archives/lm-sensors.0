From: catalin.arseni@gmail.com (Catalin Arseni)
Date: Sun, 14 May 2006 18:34:18 +0000
Subject: [lm-sensors] compaq evo w6000
Message-Id: <79f711370605141134o79425f10oc23aa1a3bd50a779@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4464301C.9030003@tu-bs.de>
In-Reply-To: <4464301C.9030003@tu-bs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 Hi,

I have a Compaq Evo W6000 with dual Xeon 1.7Ghz

My problem is somehow related to ticket 913.
Sensors-detect doesn't find any smbus-pci-device
and of course lspci the same.It looks  hidden.

lspci output:

0000:00:00.0 Host bridge: Intel Corp. 82860 860 (Wombat) Chipset Host Bridge
(MCH) (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge
(rev 04)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 04)
0000:00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
0000:00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04)
0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04)
0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV10GL [Quadro]
(rev 10)
0000:02:06.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
09)
0000:02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet
Controller (rev 03)
0000:02:0d.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)

Regarding to ticket913 I cannot use p4b_smbus module to activate  the smbus
because my kernel version is  2.6.15.4. Ok, I found out that I have  to
find  a patch for this kernel for  /drivers/pci/quirks.c to activate the
smbus.
I didn't find it, and it is also not very easy for me to write it.
I could find thou in  quirks.c suport for some Compaqs and I know that
I only have to change some parameters to match my computer.
For example:

}
        } else if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_COMPAQ))
{
                if (dev->device = PCI_DEVICE_ID_INTEL_82855PM_HB)
                        switch(dev->subsystem_device) {
                        case 0x0058: /* Compaq Evo N620c */
                                asus_hides_smbus = 1;
                        }

I need (i supose :)) 3 values - PCI_DEVICE_ID_INTEL_????? (the chipset is
i860, but I don't know if this
                                                   is the right value that I
have to add after INTEL_....

                                                - case 0x?????
                                                - and probably the name
between /*???????*/

Also the last kernel 2.6.16.16 didn't add any configuration in the
quirks.cfor compaq evo w6000.

Can anybody help me to solve this problem? Maybe some unix commands that can
give me the right
values?

Best Regards

Catalin
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060514/0c35f54e/attachment.html
