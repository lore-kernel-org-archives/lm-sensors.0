From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 25 Jan 2007 08:07:00 +0000
Subject: [lm-sensors] [PATCH] Add Micro-Star as a PCI VENDOR
Message-Id: <20070125090700.3d4b14f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <c1cd85210701241715p29fb437dy9400e74afaf8bbf7@mail.gmail.com>
In-Reply-To: <c1cd85210701241715p29fb437dy9400e74afaf8bbf7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gordon,

Posting to 6 mailing-lists at once, are you mad?
I kept only the relevant ones.

On Wed, 24 Jan 2007 17:26:44 -0800, Greg KH wrote:
> On Thu, Jan 25, 2007 at 12:15:51PM +1100, Gordon Stanton wrote:
> > Hi,
> > I noticed that a common motherboard manufacturer Micro-Star was
> > missing it's PCI_VENDOR_ID and so I have sent this patch in.
> > Later on I will send a patch to pci/quirks.c to unhide the SMBus on
> > the M510C laptop once I have investigated it a bit more. It hides the
> > SMBus the same as ASUS (and a couple of others) laptops.
> > This is definately the correct ID, see
> > http://www.pcidatabase.com/vendor_details.php?idp5
> > 
> > I would also be happy with PCI_VENDOR_ID_MICRO_STAR instead, what do you 
> > think?

I would suggest PCI_VENDOR_ID_MSI, that's how people know them.

> I suggest sending this patch in when you need to use it, i.e. at the
> same time you send the quirk patch in.

I second this suggestion.

Thanks,
-- 
Jean Delvare

