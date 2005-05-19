From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: question (IBM i2c-piix4)
Message-Id: <20050408231129.0771a59d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000101c53bd2$a7dbfbb0$e500a8c0@KRTEK>
In-Reply-To: <000101c53bd2$a7dbfbb0$e500a8c0@KRTEK>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tomas,

> Here is my "vpddecode" output:
> 
> # vpddecode 2.6
> BIOS Build ID: NVKT39AGR
> Product Name: PC 300PL
> Box Serial Number: 5575C0D
> Motherboard Serial Number: D7G5UCE0BDE
> Machine Type/Model: 6862270

This one DOES have the faulty EEPROM IIRC, and an LM80 hardware
monitoring driver.

> Thanks for your advice how to hack the i2c-piix4 driver.

First of all, you MUST NOT load the eeprom driver on your system. NEVER.
Make sure you don't even compile it.

Now if you really want to bypass the security check, edit
drivers/i2c/busses/i2c-piix4.c. In function piix4_setup, you'lle find:

	/* Don't access SMBus on IBM systems which get corrupted eeproms */
	if (dmi_check_system(piix4_dmi_table) &&
			PIIX4_dev->vendor = PCI_VENDOR_ID_INTEL) {
		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
			"may corrupt your serial eeprom! Refusing to load "
			"module!\n");
		return -EPERM;
	}

Rip the whole block, recompile and you're done.

(And if you break your system we are not reponsible, of course.)

-- 
Jean Delvare
