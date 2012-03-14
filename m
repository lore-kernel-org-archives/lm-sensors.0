From: David Kremer <david@david-kremer.fr>
Date: Wed, 14 Mar 2012 19:01:05 +0000
Subject: Re: [lm-sensors] ERROR: could not insert 'w83627ehf': Device or resource busy
Message-Id: <4F60EAF1.7060700@david-kremer.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F60A0AA.2050107@gmail.com>
In-Reply-To: <4F60A0AA.2050107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter, I tested your module with the makefile I sent you.

Here is the result. I can't still load your module into my kernel.

  [42029.144832] nct6775: Found NCT6776F chip at 0x290
  [42029.144852] ACPI: resource nct6775 [io 0x0295-0x0296] conflicts 
with ACPI region HWRE [io 0x290-0x299]
  [42029.144853] ACPI: If an ACPI driver is available for this device, 
you should use it instead of the native driver

Tell me if you see something else than to force ACPI.

Do you suggest to try with a newer version of the kernel ? Mine is 
3.0.23-1-lts.
<http://www.federationyoga.qc.ca/page-respiration.html>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
