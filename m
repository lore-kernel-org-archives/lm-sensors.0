From: jeff@kosowsky.org (Jeffrey J. Kosowsky)
Date: Mon, 20 Nov 2006 16:18:25 +0000
Subject: [lm-sensors] sensors-detect: Found unknown chip with ID 0x8708
Message-Id: <17761.54609.951949.352569@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061102183140.595504b5@phearless.godzilla.com>
In-Reply-To: <20061102183140.595504b5@phearless.godzilla.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote at about 22:08:57 +0100 on Sunday, November 19, 2006:
 > Hi Jeffrey,
 > 
 > On Sun, 19 Nov 2006 03:35:15 -0500, Jeffrey J. Kosowsky wrote:
 > > I have been having a similar problem.
 > > I was able to get lm_sensors to work on 2.4 kernels by using the p4b_smbus.o
 > > hotplug module.
 > > 
 > > However, when I upgraded to Fedora 6/Linux 2.6.18, it no longer works.
 > > My understanding is that in Linux 2.6.x, it is no longer necessary to
 > > use the p4b_smbus hotplug module since activation of Asus's "hidden"
 > > SMBus is handled by code in drivers/pci/quirks.c
 > 
 > Correct.
 > 
 > > Now, I learned from the previous post that the SMBus is not enabled if
 > > suspend is used and that I need to shut off the "Sleep States" in the
 > > ACPI menu.
 > > 
 > > Is there any way to do this *without* recompiling the kernel?
 > > i.e., can I pass parameters to the kernel in grup or even after
 > > booting to get rid of the sleep states problem and get SMBus enabled?
 > 
 > Unfortunately not. I agree it would be nice to have a kernel boot
 > parameter for this, but at the moment this is a compilation time
 > decision. If someone provides a patch to make it a boot time decision,
 > I'll take that.
 > 
 > -- 
 > Jean Delvare

Thanks for the clarification.
Definitely seems like it should be a boot mode decision since it is a
harsh either-or choice (either sleep or sensors) that will change
among different users and even for the same user at different times.

Recompiling the kernel takes forever and is a pita if it means that
you can no longer use stock distro kernels.

Unfortunately, I am not at the level of kernel hacker to supply you
with the patch...

Thanks

