From: "Holger Hoffstaette" <holger.hoffstaette@googlemail.com>
Date: Sun, 20 Sep 2009 09:10:22 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <pan.2009.09.20.09.10.22.472125@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org

On Sun, 20 Sep 2009 10:20:57 +0200, wixor wrote:

> Hello,
> with recent upgrade to 2.6.31 I get
> 
> it87: Found IT8712F chip at 0x290, revision 7
> it87: in3 is VCC (+5V)
> it87: in7 is VCCH (+5V Stand-By)
> ACPI: I/O resource it87 [0x295-0x296] conflicts with ACPI region IP__
> [0x295-0x296]
> ACPI: Device needs an ACPI driver
> FATAL: Error inserting it87
> (/lib/modules/2.6.31/kernel/drivers/hwmon/it87.ko): Device or resource
> busy

Not a bug, see http://bugzilla.kernel.org/show_bug.cgi?id967
Add acpi_enforce_resources=lax to your kernel boot options.

-h



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
