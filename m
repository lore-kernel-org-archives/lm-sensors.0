From: David Kremer <david.kremer.dk@gmail.com>
Date: Wed, 14 Mar 2012 15:36:24 +0000
Subject: Re: [lm-sensors] ERROR: could not insert 'w83627ehf': Device or resource busy
Message-Id: <4F60BAF8.40308@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F60A0AA.2050107@gmail.com>
In-Reply-To: <4F60A0AA.2050107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I forgot to mention that your diagnostic is excellent.

The three last lines from dmesg are here :

[30023.283848] w83627ehf: Found NCT6776F chip at 0x290
[30023.283867] ACPI: resource w83627ehf [io  0x0295-0x0296] conflicts 
with ACPI region HWRE [io 0x290-0x299]
[30023.283869] ACPI: If an ACPI driver is available for this device, you 
should use it instead of the native driver


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
