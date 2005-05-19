From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <425C4393.60907@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,
> Do you mean to look for the message "PCI: Canceling ASUS hide and seek
> played with SMBus monitoring chip\n" from drivers/pci/quirks.c in
> /var/log/message?

Yes exactly. (Or syslog but I think dmesg should work too)

> 
> I do NOT find any message from the patch when I load the i2c-i801/w83792d/
> eeprom without isaset. Is it because I'm using "ssh" to the Linux?

No, this should be activated when you rebuild whole kernel and reboot the machine.
So you must check via dmesg comamnd or /var/log/something if you can see that line.
If you just patched and do not build the kernel (make bzImage) than it cant work :)

> Where should I put these "printks"? You'd better give me more information
> about it.

Like in that two routines:
+static void __init asus_hides_smbus_devices(struct pci_dev *dev) {
+       if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_ASUSTEK)) {
+                       switch(dev->subsystem_device) {
+                       case 0x8117: /* ASUS server board (NCLV-D) */
+                               asus_server_board_hides_smbus_devices = 1;
+                      asus_server_board_hides_smbus_devices         break;
+                       }
+       }

printk("Value of asus_server_board_devices: %d \n",asus_server_board_hides_smbus_devices);

}


And here:
	printk("In INTEL IO REGION QUIRK\n");
         pci_read_config_dword(dev, 0x58, &region);
         quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1);


And maybe  here:


+               val=inb((region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);

printk("oldval: %x\n",val);
+               val&=~0x4; /* GPIO42 : 0 (Low) */
+               val|=0x8;  /* GPIO43 : 1 (High) */
printk("newval: %x\n",val);

Now I think you will get it. We must find out if our new code is activated, and if not what part failed.



> Yes, you are right, I find that the eeprom module works well if I do NOT
> do the "isaset" trick. But at this time, the 792 module does NOT work!

Yes because it simply switches the bus to some other place. Just imagine the bus as railroad
and the multiplexer like a "railswitch". So when switched your train will visit different stations,
but some can remain the same :)


> [root@CFLi ~]# modprobe i2c-i801
> [root@CFLi ~]# modprobe eeprom
> [root@CFLi ~]# sensors
> eeprom-i2c-0-55
> Adapter: SMBus I801 adapter at 0400
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       256
> 
> eeprom-i2c-0-51
> Adapter: SMBus I801 adapter at 0400
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       256
> 

Yes that it expected to work :)

  > (3) i2cdetect 0
> [root@CFLi ~]# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> 50: XX 51 XX XX XX 55 XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX

The numbers say what device responded to I2C_WRITEQUCIK (the detect stuff)

> 
> (4) isaset .... (put here the trick line)
>     i2cdetect 0
> [root@CFLi ~]# isaset -y -f 0x04b9 0x08
> [root@CFLi ~]# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2f
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX XX XX XX 4b XX XX XX 4f
> 50: XX XX XX XX 54 55 XX XX XX XX XX XX XX XX XX XX
> 60: XX 61 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX 71 XX XX XX XX XX XX

You see one eeprom dissapeared, your device appeared but 0x55 remained for some reason.
But in fact nothing left there. Without information from ASUS I cant tell you what happened there.

> (5) i2cdump 0 0x55
> [root@CFLi ~]# i2cdump 0 0x55
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x55, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................


> (7) modprobe eeprom
>     sensors
> [root@CFLi ~]# modprobe eeprom
> [root@CFLi ~]# sensors
> eeprom-i2c-0-55
> Adapter: SMBus I801 adapter at 0400
> Unknown EEPROM type (255).
> 
> eeprom-i2c-0-54
> Adapter: SMBus I801 adapter at 0400
> Unknown EEPROM type (255).

I expected this to show up. Again I cant tell what happened in bus because I dont know
what the multiplexer really did with the bus.

> 
> (8) modprobe your792driver
>     sensors

> (10)
> [root@CFLi ~]# rmmod w83792d
> [root@CFLi ~]# rmmod eeprom
> [root@CFLi ~]# rmmod i2c-i801
> [root@CFLi ~]# isaset -y -f 0x04b9 0x00 <---here is 0x00 instead of 0x08 !!
> [root@CFLi ~]# isadump -f 0x04b9
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address range 0x400 to 0x4ff.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 40 00 04 00 ab ff 00 00 00 44 00 00 00 00 07 07
> 10: 00 00 00 00 10 00 5c 00 00 00 00 00 00 00 00 00
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: c0 31 a4 1b ff ff 00 01 00 00 00 00 00 00 00 03
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 c0 31 00 00
> b0: 00 0c 00 03 00 00 00 00 00 00 00 00 00 00 00 00
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: a0 0a ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [root@CFLi ~]# modprobe i2c-i801
> [root@CFLi ~]# modprobe eeprom
> [root@CFLi ~]# modprobe w83792d
> [root@CFLi ~]# sensors  <--- the eeprom can work but 792 NOT!
> eeprom-i2c-0-55
> Adapter: SMBus I801 adapter at 0400
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       256
> 
> eeprom-i2c-0-51
> Adapter: SMBus I801 adapter at 0400
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       256
> 
> Then do you know how to solve this problem? So that both the eeprom and
> 792 modules can work at the same time.

No I cant Asus did not told us whole true. He messed with more devices on the bus except the monitoring chip.
When we will have our "quirk" working we can try to experiment or ask Asus again what to do...

You know our opinion about the obstacle :)

regards

Rudolf
