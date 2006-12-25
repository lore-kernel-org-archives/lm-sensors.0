From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 25 Dec 2006 09:39:23 +0000
Subject: [lm-sensors] w83793G for 2.6.9-42.0.3ELsmp kernel
Message-Id: <20061225103923.502b2aa7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <MAILnzVzNOGe4V7vjLC00001c19@mail.atipa.com>
In-Reply-To: <MAILnzVzNOGe4V7vjLC00001c19@mail.atipa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brady,

On Thu, 14 Dec 2006 18:41:14 -0600, Brady Chang wrote:
> any chance of getting this winbond chip working on 2.6.9-42.0.3.ELsmp
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-w83793-new-driver.patch

The w83793 driver was just merged into the kernel, so the first kernel
to support the Winbond W83793G/R will be 2.6.20. There were so many
core changes done during the 2.6 kernel lifetime that this driver won't
work with a 2.6.9 kernel right away. A lot of work would be needed to
backport the driver, and we (the lm_sensors group) just don't have the
time. We already hardly have the time to review the drivers and get
them merged upstream.

So your options are:
1* Switch to a more recent Linux distribution. Of course, none of them
will support the W83793G/R at the moment as kernel 2.6.20 isn't even
released, but backporting to a more recent kernel will be less
difficult.
2* Backport the driver yourself.
3* Ask your distribution vendor for help. If many of their customers
are interested, they might consider backporting the driver.
4* Ask Winbond, they may be able to help with the backport.

> 00:00.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)
> 00:01.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a3)
> 00:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev a3)
> 00:01.2 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a3)
> 00:02.0 USB Controller: nVidia Corporation MCP55 USB Controller (rev a1)
> 00:02.1 USB Controller: nVidia Corporation MCP55 USB Controller (rev a2)
> 00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)
> 00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
> 00:05.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
> 00:05.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
> 00:06.0 PCI bridge: nVidia Corporation MCP55 PCI bridge (rev a2)
> 00:08.0 Ethernet controller: nVidia Corporation MCP55 Ethernet (rev a3)
> 00:09.0 Ethernet controller: nVidia Corporation MCP55 Ethernet (rev a3)
> 00:0a.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
> 00:0b.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
> 00:0c.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
> 00:0d.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
> 00:0e.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
> 00:0f.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
> Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
> 00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
> Controller
> 00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
> 01:05.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
> 02:00.0 PCI bridge: NEC Corporation uPD720400 PCI Express - PCI/PCI-X Bridge
> (rev 07)
> 02:00.1 PCI bridge: NEC Corporation uPD720400 PCI Express - PCI/PCI-X Bridge
> (rev 07)

Which motherboard is this? Winbond is looking for a cheap motherboard
with W83793G/R to donate to our project.

-- 
Jean Delvare

