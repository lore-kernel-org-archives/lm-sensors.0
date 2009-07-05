From: Christopher Hogan <chris.c.hogan@gmail.com>
Date: Sun, 05 Jul 2009 15:40:01 +0000
Subject: [lm-sensors] w83627hf Device needs an ACPI driver
Message-Id: <6977f2fc0907050840g7b70bdb8jf8a9a85f2be730a4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Loading w83627hf produces the following error:
w83627hf: Found W83627HF chip at 0x290
ACPI: I/O resource w83627hf [0x295-0x296] conflicts with ACPI region
IP__ [0x295-0x296]
ACPI: Device needs an ACPI driver

I have ACPI compiled into kernel 2.6.29-gentoo-r3.

I googled a bit and found kernel bug:
http://bugzilla.kernel.org/show_bug.cgi?id508

Am I correct that an ACPI compatible driver for this chip doesn't
exist and that I should disable part/all of ACPI in order to have full
access to my sensors?

Thanks,

Christopher Hogan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
