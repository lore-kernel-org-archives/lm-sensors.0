From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 29 Jan 2007 08:32:20 +0000
Subject: [lm-sensors] [PATCH] Add Micro-Star as a PCI VENDOR
Message-Id: <20070129093220.30efba22.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <c1cd85210701241715p29fb437dy9400e74afaf8bbf7@mail.gmail.com>
In-Reply-To: <c1cd85210701241715p29fb437dy9400e74afaf8bbf7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gordon,

On Mon, 29 Jan 2007 16:52:34 +1100, Gordon Stanton wrote:
> Hi Jean,
> Firstly, sorry for the personal reply. I thought it might be better though.

For what reason? First you send your message to 6 mailing lists, then
replies go to just one person? I'm adding the relevant lists and
persons to Cc again.

> On 1/25/07, Jean Delvare <khali at linux-fr.org> wrote:
> > Posting to 6 mailing-lists at once, are you mad?
> > I kept only the relevant ones.
> 
> SMBus on PCI with ACPI crosses many areas.

I fail to see how it is related to ACPI at all.

> I'ts fixes a PCI quirk.(linux-pci)
> The fix will unhide the SMBus like ASUS needs.(acpi4asus)

Irrelevant. Asus were the first ones to do it, but half a dozen vendors
do it by now. And the Asus system users certainly couldn't care less
that yet another system needs it.

> Hopefully enabling some more sensors (like fans) to be
> seen.(linux-acpi,lm-sensors)

"Hopefully?" You'd better make sure first. We're not going to add an
unhiding quirk if there's nothing useful on the SMBus in question.

> > I would suggest PCI_VENDOR_ID_MSI, that's how people know them.
> 
> I thought of that but MSI in relation to PCI means "Message Signaled
> Interrupt" so I would rather go with PCI_VENDOR_MICRO_STAR which also

Come on, the symbol is named PCI_VENDOR_ID_<something>, it's pretty
clear what it stands for. If someone really thinks that
PCI_VENDOR_ID_MSI could be related to message-signaled interrupts, that
person better doesn't touch the kernel code at all.

We already have 62 two- or three-letter PCI vendor ID symbols in
pci_ids.h, one more really isn't a problem.

> tabs in the source code nicely. Although in truth it probably should

"Tabs in the source code nicely"? What do you mean?

> be PCI_VENDOR_MICRO_STAR_INTL but that is just getting too long.

That I couldn't agree more.

-- 
Jean Delvare

