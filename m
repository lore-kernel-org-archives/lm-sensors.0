From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <41B79FCE.4070501@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is true for "regular" PCI bus writes (which can be "posted") but not for
accesses to config space, which are never posted. 
The dummy reads are not necessary after config space writes.
mds

Greg KH wrote:
> On Wed, Dec 08, 2004 at 09:07:43PM +0100, Jean Delvare wrote:
> 
>>>	/* default: SMBus, no SMI#, enable host controller */
>>>	pci_write_config_byte(pcidev, I801_PCI_HOSTC, 0x01);
>>>	pci_read_config_byte(pcidev, I801_PCI_HOSTC, &temp);
>>
>>And after that you don't use temp... Am I missing something?
> 
> 
> This is commonly done to ensure that the write actually hits the bus
> before the code continues.  Otherwise, the write could happen at some
> later point in time.  The read after a write ensures that everything is
> synced up properly.
> 
> 
>>You might want to only write the bits that you know about, in case
>>future chips would have more. Also you could use the constants you
>>defined earlier. What about:
>>
>>
>>>	/* default: SMBus, no SMI#, enable host controller */
>>>	pci_read_config_byte(pcidev, I801_PCI_HOSTC, &temp);
>>>	pci_write_config_byte(pcidev, I801_PCI_HOSTC,
>>>			      (temp & 0xF8) | I801_PCI_HOSTC_HST_EN);
> 
> 
> And then put a read after it too :)
> 
> thanks,
> 
> greg k-h
> 
> 
