From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH] i2c-sis630 for 2.6.0-test11 get rid of pci init
Message-Id: <3FDE55E8.285C38E3@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312160048.17954.amalysh@web.de>
In-Reply-To: <200312160048.17954.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good question.

We have 5 bus drivers in our package where we've commented out
pci_module_init()
because other drivers have claimed the device and prevented ours from
loading.
(i810, savage4, via, viapro, voodoo3)

It appears that we should do the same thing to some other drivers
(amd756 for example?).
It's one thing if we conflict with an ACPI driver that's doing the same
thing.
But some completely unrelated driver, hopefully we can coexist.

This is particularly a problem with video chip drivers where there's
almost always
a conflict.

I tried doing the same thing to voodoo3 in 2.6 as an experiment.
It worked but eventually oopsed. In sysfs, things did appear
under the other PCI device driver. Didn't look into it further at the
time.

I've seen opinions in the past that if a chip needed two drivers, the
chip was
broken, tough. But hopefully that's not the only option.

Greg, can you give us some guidance here? Unless we can bypass
pci_module_init()
in 2.6 a lot of the bus drivers are not going to load.

mds




Alexander Malysh wrote:
> 
> Hello,
> 
> 2.6.0 kernel (with great sysfs) just shown a bug that is present in the
> current i2c-sis630 and was discussed before with Mark M. Hoffman
> (unfortunately w/o any conclusion) that i2c-sis630 is not a pci device driver
> and has no need to claiming any pci device. This patch removes
> pci_[init|remove] stuff because i2c-sis630 just needs a few io ports and
> should not claim pci device.
> 
> any comments?
> 
> --
> Best regards,
> Dipl.-Ing.
> Alexander Malysh
> 
> 
>                        Name: i2c-sis630.patch
>    i2c-sis630.patch    Type: text/x-diff
>                    Encoding: quoted-printable
> 
>    Part 1.2       Type: application/pgp-signature
>            Description: signature
