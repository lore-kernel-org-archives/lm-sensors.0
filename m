From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 10 Feb 2010 18:01:16 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <20100210180116.GG29604@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 10, 2010 at 05:03:00PM +0200, D. Can Celasun wrote:
> Here's the relevant output:
> 
> Feb 10 17:00:49 dcclinux kernel: ACPI: I/O resource 0000:00:1f.3
> [0x1840-0x185f] conflicts with ACPI region SMBI [0x1840-0x184f]
> Feb 10 17:00:49 dcclinux kernel: ACPI: If an ACPI driver is available for
> this device, you should use it instead of the native driver
> 
> So I guess that's it for the SMBus. I'll be waiting for a coretemp patch for
> the cpu.

You might also try the i2c-scmi driver.... if the BIOS is set up correctly.
I don't remember when it went in the kernel other than it was in the 2.6.32/33
timeframe.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
