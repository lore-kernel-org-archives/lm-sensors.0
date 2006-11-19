From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 19 Nov 2006 21:08:57 +0000
Subject: [lm-sensors] sensors-detect: Found unknown chip with ID 0x8708
Message-Id: <20061119220857.48b30d94.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061102183140.595504b5@phearless.godzilla.com>
In-Reply-To: <20061102183140.595504b5@phearless.godzilla.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeffrey,

On Sun, 19 Nov 2006 03:35:15 -0500, Jeffrey J. Kosowsky wrote:
> I have been having a similar problem.
> I was able to get lm_sensors to work on 2.4 kernels by using the p4b_smbus.o
> hotplug module.
> 
> However, when I upgraded to Fedora 6/Linux 2.6.18, it no longer works.
> My understanding is that in Linux 2.6.x, it is no longer necessary to
> use the p4b_smbus hotplug module since activation of Asus's "hidden"
> SMBus is handled by code in drivers/pci/quirks.c

Correct.

> Now, I learned from the previous post that the SMBus is not enabled if
> suspend is used and that I need to shut off the "Sleep States" in the
> ACPI menu.
> 
> Is there any way to do this *without* recompiling the kernel?
> i.e., can I pass parameters to the kernel in grup or even after
> booting to get rid of the sleep states problem and get SMBus enabled?

Unfortunately not. I agree it would be nice to have a kernel boot
parameter for this, but at the moment this is a compilation time
decision. If someone provides a patch to make it a boot time decision,
I'll take that.

-- 
Jean Delvare

