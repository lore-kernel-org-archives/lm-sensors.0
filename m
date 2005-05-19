From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: FW: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <Pine.LNX.4.58.0503091325360.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Yes stupid mail client.
In attachment this time. Need to go to school. See you later.

regards

Rudolf



On Wed, 9 Mar 2005 Huang0@Winbond.com.tw wrote:

> Hi Rudolf
>
> I failed to patch it, Is there any problem when I use your patch?
> Please check it:
>
> [root@ /usr/src/linux-2.6.10]# patch -p1 <patch1
> patching file drivers/pci/quirks.c
> patch: **** malformed patch at line 40: @@ -320,6 +350,15 @@
>
> [root@ /usr/src/linux-2.6.10]# diff drivers/pci/quirks.c drivers/pci/quirks.c.bak
> [root@ /usr/src/linux-2.6.10]#
>
>
> Thanks
> Best Regards
> Chunhao
>
>
> > -----Original Message-----
> > From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> > Sent: 2005??3??9?? 18:44
> > To: PI14 HUANG0
> > Cc: PI10 LHHsu; PI14 DZSHEN; sensors@stimpy.netroedge.com
> > Subject: Re: FW: Ask for some information about motherboard ASUS NCLV-D
> >
> >
> >
> > >    GPIO42 : 0 (Low)
> > >    GPIO43 : 1 (High)
> > >
> > >   For 6300ESB, the access method of these two pins is showed below.
> > > Bit10, bit 11 are for these two pins.
> >
> > Yes thank you.
> >
> > Here is updated patch.
> >
> > Regards
> >
> > Rudolf
> >
> > diff -Naur a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > --- a/drivers/pci/quirks.c	2005-03-02 08:37:31.000000000 +0100
> > +++ b/drivers/pci/quirks.c	2005-03-09 10:56:36.877494936 +0100
> > @@ -306,6 +306,36 @@
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > 	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
> >
> > +/* Not only ASUS hides SMBUS, sometimes hides also devices on it.
> > +It is known that they use GPIO lines from ISA bridge or LPC IO chip
> > +to trigger the multiplexer on SMBUS.
> > +
> > +Information for this particular W83792D case was provided by ASUS R&D on
> > +request from Winbond.
> > +
> > +If we want to access W83792D, we should program these to GPO pins to
> > +   GPIO42 : 0 (Low)
> > +   GPIO43 : 1 (High)
> > +(This should work for 6300ESB based motherboards)
> > +*/
> > +
> > +#define GPIO_OUTPUT2_REG_HIGH 0x39
> > +#define GPIO_IOSIZE_MASK 0x3F
> > +
> > +static int __initdata asus_server_board_hides_smbus_devices = 0;
> > +
> > +static void __init asus_hides_smbus_devices(struct pci_dev *dev) {
> > +	if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_ASUSTEK)) {
> > +			switch(dev->subsystem_device) {
> > +			case 0x8117: /* ASUS server board (NCLV-D) */
> > +				asus_server_board_hides_smbus_devices = 1;
> > +				break;
> > +			}
> > +	}
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_4,
> > 	asus_hides_smbus_devices );
> > +
> > +
> >  /*
> >   * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords
> > at
> >   *	0x40 (128 bytes of ACPI, GPIO & TCO registers)
> > @@ -320,6 +350,15 @@
> >
> >  	pci_read_config_dword(dev, 0x58, &region);
> >  	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1);
> > +
> > +	if (asus_server_board_hides_smbus_devices) {
> > +		unsigned char val;
> > +		val=inb((region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);
> > +		val&=~0x4; /* GPIO42 : 0 (Low) */
> > +		val|=0x8;  /* GPIO43 : 1 (High) */
> > +		outb(val, (region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);
> > +		printk(KERN_INFO "PCI: Canceling ASUS hide and seek played with SMBus
> > monitoring chip\n");
> > +	}
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > PCI_DEVICE_ID_INTEL_82801AA_0,		quirk_ich4_lpc_acpi );
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > PCI_DEVICE_ID_INTEL_82801AB_0,		quirk_ich4_lpc_acpi );
> > @@ -330,6 +369,7 @@
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > PCI_DEVICE_ID_INTEL_82801DB_0,		quirk_ich4_lpc_acpi );
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi );
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi );
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi );
> >
> >  /*
> >   * VIA ACPI: One IO region pointed to by longword at
>
>
> ==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially repea!
>  t the&nbsp; English statement above.???H???????t?????q?l???]???????K?????T, ?????v???o?H?H???w?????H?H???\????. ?????z???D?Q???w?????H?H???]???????]?b???g???v?????????U???????H??, ???z?i?????o?H?H?????Y?N?H???q?q???P???????A???????H????. ?????z???X?@, ?????????P??. ?S??????, ???????g???v?????????????q?l?????K???T???????O?Q?Y???T????. ?H???P?????q?l???~?L???????e,???o?????????q?l?????????N??.
>
>
-------------- next part --------------
diff -Naur a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-03-02 08:37:31.000000000 +0100
+++ b/drivers/pci/quirks.c	2005-03-09 10:56:36.877494936 +0100
@@ -306,6 +306,36 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
 
+/* Not only ASUS hides SMBUS, sometimes hides also devices on it. 
+It is known that they use GPIO lines from ISA bridge or LPC IO chip
+to trigger the multiplexer on SMBUS.
+
+Information for this particular W83792D case was provided by ASUS R&D on
+request from Winbond.
+
+If we want to access W83792D, we should program these to GPO pins to
+   GPIO42 : 0 (Low)
+   GPIO43 : 1 (High)
+(This should work for 6300ESB based motherboards)
+*/
+
+#define GPIO_OUTPUT2_REG_HIGH 0x39
+#define GPIO_IOSIZE_MASK 0x3F
+
+static int __initdata asus_server_board_hides_smbus_devices = 0;
+
+static void __init asus_hides_smbus_devices(struct pci_dev *dev) {
+	if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_ASUSTEK)) {
+			switch(dev->subsystem_device) {
+			case 0x8117: /* ASUS server board (NCLV-D) */
+				asus_server_board_hides_smbus_devices = 1;
+				break;
+			}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_4,	asus_hides_smbus_devices );
+
+
 /*
  * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
  *	0x40 (128 bytes of ACPI, GPIO & TCO registers)
@@ -320,6 +350,15 @@
 
 	pci_read_config_dword(dev, 0x58, &region);
 	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1);
+	
+	if (asus_server_board_hides_smbus_devices) {
+		unsigned char val;
+		val=inb((region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);
+		val&=~0x4; /* GPIO42 : 0 (Low) */
+		val|=0x8;  /* GPIO43 : 1 (High) */		
+		outb(val, (region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);
+		printk(KERN_INFO "PCI: Canceling ASUS hide and seek played with SMBus monitoring chip\n");
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AA_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AB_0,		quirk_ich4_lpc_acpi );
@@ -330,6 +369,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi );
 
 /*
  * VIA ACPI: One IO region pointed to by longword at
