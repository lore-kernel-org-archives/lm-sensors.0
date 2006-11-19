From: lmsensors@kosowsky.org (Jeffrey J. Kosowsky)
Date: Sun, 19 Nov 2006 08:35:15 +0000
Subject: [lm-sensors] [lm-sensors sensors-detect] Found unknown chip with ID
Message-Id: <17760.5955.967305.173844@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have been having a similar problem.
I was able to get lm_sensors to work on 2.4 kernels by using the p4b_smbus.o
hotplug module.

However, when I upgraded to Fedora 6/Linux 2.6.18, it no longer works.
My understanding is that in Linux 2.6.x, it is no longer necessary to
use the p4b_smbus hotplug module since activation of Asus's "hidden"
SMBus is handled by code in drivers/pci/quirks.c

Now, I learned from the previous post that the SMBus is not enabled if
suspend is used and that I need to shut off the "Sleep States" in the
ACPI menu.

Is there any way to do this *without* recompiling the kernel?
i.e., can I pass parameters to the kernel in grup or even after
booting to get rid of the sleep states problem and get SMBus enabled?

Thanks

