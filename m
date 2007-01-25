From: greg@kroah.com (Greg KH)
Date: Thu, 25 Jan 2007 01:26:44 +0000
Subject: [lm-sensors] [PATCH] Add Micro-Star as a PCI VENDOR
Message-Id: <20070125012644.GA6172@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c1cd85210701241715p29fb437dy9400e74afaf8bbf7@mail.gmail.com>
In-Reply-To: <c1cd85210701241715p29fb437dy9400e74afaf8bbf7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gordon Stanton <fixacpi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, lm-sensors@lm-sensors.org, s270-linux@mail.0pointer.de, linux-pci@atrey.karlin.mff.cuni.cz

On Thu, Jan 25, 2007 at 12:15:51PM +1100, Gordon Stanton wrote:
> Hi,
> I noticed that a common motherboard manufacturer Micro-Star was
> missing it's PCI_VENDOR_ID and so I have sent this patch in.
> Later on I will send a patch to pci/quirks.c to unhide the SMBus on
> the M510C laptop once I have investigated it a bit more. It hides the
> SMBus the same as ASUS (and a couple of others) laptops.
> This is definately the correct ID, see
> http://www.pcidatabase.com/vendor_details.php?idp5
> 
> I would also be happy with PCI_VENDOR_ID_MICRO_STAR instead, what do you 
> think?

I suggest sending this patch in when you need to use it, i.e. at the
same time you send the quirk patch in.

thanks,

greg k-h

