From: hfvogt@gmx.net (Hans-Frieder Vogt)
Date: Mon, 08 Aug 2005 00:13:01 +0000
Subject: [lm-sensors] [CALL FOR TESTERS] i2c-nforce2 support for MCP04 and
Message-Id: <200508080012.20254.hfvogt@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E24D97.3080104@gmx.net>
In-Reply-To: <42E24D97.3080104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

thank you very much for your comments.
> Hi Hans,
>
> > is there anybody on the list who has an nForce4 SLI intel edition or a
> > prototype of the mainboard with the upcoming nVidia CK8-04u/MCP51
> > chipset?
>
> I do not, sorry.

nForce4 Professional users are also welcome!

>
> > Can you please apply the attached patch and check whether
> > i2c-nforce2 finds the 2 SMBusses. The output of i2cdetect would be
> > appreciated as an indication that the module not only finds the
> > busses, but also has the minimum functionality. The patch is against
> > 2.6.13-rc3-mm1 with the cleanup patch included that I have sent to the
> > list today. It also applies to vanilla 2.6.13-rc3-mm1, but with some
> > offset.
>
> But I'd have a comment about the patch:
> > +/* temporarily needed! */
> > +#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS
> > +#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS 0x0034
> > +#endif
> > +#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS
> > +#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SMBUS 0x0264
> > +#endif
>
> Such constructs are dangerous and should be avoided. These definitions
> belong to include/linux/pci_ids.h, please add them there.
>
Agreed. But before I prepare a patch for pci_ids.h, I want to be sure that
a) the PCI-IDs are really correct (the PCI-IDs are from 
pciids.sourceforge.net, which should be OK)
b) those variants of the nForce? chipsets support smbusses that are compatible 
with the already supported nForce2/3/4 smbusses.

> Thanks,
Thanks as well.

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt <at> arcor .dot. de
                                          hfvogt <at> gmx .dot. net
