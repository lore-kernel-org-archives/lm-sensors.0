From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 13 Aug 2005 08:46:13 +0000
Subject: [lm-sensors] I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050813084616.55e8825b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809231328.0726537b.khali@linux-fr.org>
In-Reply-To: <20050809231328.0726537b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> > 	if ((pci_read_config_word(pdev, id->driver_data, &vt596_smba))
> > 	 || !(vt596_smba & 0x1)) {
> > 		/* try 2nd address and config reg. for 596 */
> > 		if (id->device = PCI_DEVICE_ID_VIA_82C596_3 &&
> > 		    !pci_read_config_word(pdev, SMBBA2, &vt596_smba) &&
> > 		    (vt596_smba & 0x1)) {
> > 			smb_cf_hstcfg = 0x84;
> > 
> > It looks like a hack to me, and I was wondering if we could clean it
> > up (possibly by using pci quirks). I've not studied the problem in
> > details yet, but comments and help would be welcome, and the fact
> > that you do have a chip for testing will help anyway :)
> 
> I'm not sure what you don't like about it.  I can't see what a PCI
> quirk would have to do with it, either.

The base address is read from a given PCI config word, and if it doesn't
*seem* correct, a different config word is used. First of all, only
testing for the evenness of the value doesn't look like a reliable test
to me, I'd expect the last 3 bits to be tested - as this is the address
of a 8-byte I/O range. Even then, I don't see what prevent the location
from not being correct and the value read from it to still pass the
test. So I would really hope that there is a real way to know which is
the correct location even before reading from the first one. Maybe we
can deduce the location from the PCI device revision. I'll study the
datasheet when I get some time, but most likely we will need two
real-world testers, one with each possible configuration, in order to
come up with a solution.

The reason why I am mentioning PCI quirks is this recent post on the
LKML:
  http://lkml.org/lkml/2005/8/8/32

This makes me believe that the config word the i2c-viapro driver reads
from are at non-standard locations. We could use quirks similar to the
patch in that post to copy the config words to standard locations, and
then i2c-viapro could use the standard PCI API functions to get the
values. I have not yet verified what the exact benefits would be, I need
to ask some PCI expert I guess, it's only random thoughts at the moment.

-- 
Jean Delvare
