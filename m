From: clubsoda_2@hushmail.com
Date: Sat, 27 Mar 2010 20:37:32 +0000
Subject: [lm-sensors] acpi-enforce-resources=lax not working like it used to
Message-Id: <20100327203732.18EE011803D@smtp.hushmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

My sensors were working fine up to and including kernel 2.6.31-5, 
and then for a while worked only with the boot parameter acpi-
enforce-resources=lax. 
Now (2.6.32-17) that boot option seems to be ignored, sensors 
cannot be detected and the familiar message appears in the logs:-

	ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
	PCI: setting IRQ 10 as level-triggered
	i801_smbus 0000:00:1f.3: PCI INT B -> Link[LNKB] -> GSI 10 (level, 
low) -> IRQ 10
	ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts with 
ACPI region SM00 [0xe800-0xe806]
	ACPI: If an ACPI driver is available for this device, you should 
use it instead of the native driver

This is an ASUS P4T with as99127f, previously handled by modules 
i2c-i801 and w83781d. Given that this chip lacks documentation I 
guess there will never be a "proper" driver. I was just wondering 
if someone could confirm that acpi-enforce-resources=lax is no 
longer supported for stability reasons or whether the loss of that 
workaround was perhaps unintentional. (i.e. Kernel bug?)

Regards.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
