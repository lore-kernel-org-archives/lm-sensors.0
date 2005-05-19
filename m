From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: Backport i2c-ali1563.c from linux-2.6 to linux-2.4
Message-Id: <faxLAJ1u.1112088328.7489650.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE2E5499@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE2E5499@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> And I have one question about this driver for linux-2.4:
> In the i2c-ali1563 driver for linux-2.4, it need "PCI_DEVICE_ID_AL_M1563"
> in the following codes:
> static struct pci_device_id ali1563_ids[] __devinitdata = {
>        {
>        .vendor =       PCI_VENDOR_ID_AL,
>        .device =       PCI_DEVICE_ID_AL_M1563,
>        .subvendor =    PCI_ANY_ID,
>        .subdevice =    PCI_ANY_ID,
>        },
>        { 0, }
> };
>
> So I have to insert:
> #define PCI_DEVICE_ID_AL_M1563          0x1563
> into /usr/src/linux-2.4.22/include/linux/pci_ids.h
> manually by myself, otherwise the compile will failed.
>
> But I know that the file /usr/src/linux-2.4.22/include/linux/pci_ids.h
> Should NOT be modified by me, who are in charge of this modification?

This file is part of the Linux kernel, not the lm_sensors project. We do
not modify it. The correct thing to do is to define the value in the
driver file itself, near the top. If you look at other drivers such as
i2c-i801, that's what they do.

So you'd simply add something like:

#ifndef PCI_DEVICE_ID_AL_M1563
#define PCI_DEVICE_ID_AL_M1563      0x1563
#endif

near the top of i2c-ali1563.c, and leave pci_ids.h unchanged.

Thanks,
--
Jean Delvare
