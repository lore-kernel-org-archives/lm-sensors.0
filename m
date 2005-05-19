From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] i2c-nforce2.c add support for nForce3 Pro 150 MCP
Message-Id: <hKBrMfMm.1100605629.3776330.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <36129.192.168.0.19.1100598647.squirrel@192.168.0.12>
In-Reply-To: <36129.192.168.0.19.1100598647.squirrel@192.168.0.12>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Thomas,

> This patch adds recognition of the PCI-Id for the nForce3 Pro 150 MCP
> to the i2c-nforce2.c bus driver. I have tested this simple patch on
> ASUS A7N8X-deluxe (nforce2, i386) and ASUS SK8N (nforce3, x86-64).
>
> On the ASUS SK8N the hardware monitoring is done with a IT8712F-A chip
> on the ISA bus, so the only use for accessing the 2 SMBUS interfaces
> in the nForce3 MCP is to read the SPD eeprom in the memory modules.
>
> I don't know if this works for other chips in the nForce3 family.

Patch looks good and simple, I'll apply it this evening.

Would you consider providing a similar patch to Greg for Linux 2.6?

Thanks,
Jean
