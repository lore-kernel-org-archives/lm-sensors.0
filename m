From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: Intel 82801DA ICH4
Message-Id: <3F48F447.7040404@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
In-Reply-To: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've hopefully fixed the SMP compile problem in CVS if you would like to try it.

Jean Delvare wrote:
>>I finally got it running, but your p4b_smbus.o code is not SMP
>>compliant.
> 
> 
> Bad news. MDS, can you take a look?
> 
> 
>>I compiled it successfully under a single processor kernel.
>>Here comes what the module said, when inserting it under the SMP
>>kernel again:
>>
>># insmod p4b_smbus.o
>>p4b_smbus.o: unresolved symbol pci_insert_device_R3341a12e
>>p4b_smbus.o: unresolved symbol pci_read_config_word_R923654cb
>>p4b_smbus.o: unresolved symbol pci_remove_device_R2d6c74a6
>>p4b_smbus.o: unresolved symbol kmalloc_R93d4cfe6
>>p4b_smbus.o: unresolved symbol pcibios_present_R520a75b9
>>p4b_smbus.o: unresolved symbol pci_find_device_Rc584f4e3
>>p4b_smbus.o: unresolved symbol pci_enable_device_R1bc741d2
>>p4b_smbus.o: unresolved symbol pci_write_config_word_Rf23d8795
>>p4b_smbus.o: unresolved symbol kfree_R037a0cba
>>p4b_smbus.o: unresolved symbol printk_R1b7d4074
>>p4b_smbus.o: unresolved symbol pci_setup_device_R863ed348
> 
> 
> That's no surprise. Modules compiled for one kernel are not supposed to
> be used by another one AFAIK.
> 
> 
>>When activating the SMBus I really didn't know what I was doing. I got
>>the hex value 0049 and then changed it to 0040, like described in the
>>README.p4b.
> 
> 
> No! README.p4b says you have to erase the bits 8 and 3 from the original
> value, not to use 0040, which is just given as an example starting from
> 0148. So, 0049 becomes 0041.
> 
> 
>>The output of pcitweak was as followed:
>>(...)
>>PCI: 00:1f:3: chip 8086,24c3 card 1043,8089 rev 02 class 0c,05,00 hdr
>>00
> 
> 
> OK, the device now shows.
> 
> 
>>I hope you have all information to change the module code. Anyway,
>>sensors works now under the single processor kernel.
> 
> 
> Well, all we need is to make it SMP compliant. I hope MDS will have some
> time to fix this.
> 
> Thank you for reporting.
> 
