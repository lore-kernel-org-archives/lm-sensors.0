From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: CHIPSET: INTEL E7501(PLUMAS 533)/ICH3-S
Message-Id: <20030730144653.00f7f0ce.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710134458.541c3b53.zdavatz@ywesee.com>
In-Reply-To: <20030710134458.541c3b53.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Jul 2003 20:43:17 -0400
"Mark D. Studebaker " <mds@paradyne.com> wrote:

> you don't have the 2483 PCI device present.
> If you can't activate it in the BIOS 
If I go into my BIOS I get all the values (fan speed, cpu speed, voltage, etc) perfectly fine. Why do you believe it is not activated in my BIOS?

you'll need to modify the
> p4b_smbus program in prog/hotplug to add support for the ICH3
> so it will activate the device.
Can you be a bit more specific?

Thanks for your feedback.

Zeno
> 
> Zeno R.R. Davatz wrote:
> > Hi
> > 
> > Thanks to Jean Delvare I managed to install the CVS version of i2c and lm-sensors.
> > 
> > When I do sensors-detect I find no senors.
> > 
> > My chipset is:
> > CHIPSET: INTEL E7501(PLUMAS 533)/ICH3-S CHIPSET
> > 
> > of ASUS PU-DLS/533 ACPI BIOS Revision 1003
> > 
> > Any idea what drivers I need to load or if this chipset is supported?
> > 
> > lspci gives me:
> > lspci
> > 00:00.0 Host bridge: Intel Corp.: Unknown device 254c (rev 01)
> > 00:02.0 PCI bridge: Intel Corp.: Unknown device 2543 (rev 01)
> > 00:1d.0 USB Controller: Intel Corp.: Unknown device 2482 (rev 02)
> > 00:1d.1 USB Controller: Intel Corp.: Unknown device 2484 (rev 02)
> > 00:1d.2 USB Controller: Intel Corp.: Unknown device 2487 (rev 02)
> > 00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 42)
> > 00:1f.0 ISA bridge: Intel Corp.: Unknown device 2480 (rev 02)
> > 00:1f.1 IDE interface: Intel Corp.: Unknown device 248b (rev 02)
> > 01:1c.0 PIC: Intel Corp.: Unknown device 1461 (rev 04)
> > 01:1d.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 04)
> > 01:1e.0 PIC: Intel Corp.: Unknown device 1461 (rev 04)
> > 01:1f.0 PCI bridge: Intel Corp.: Unknown device 1460 (rev 04)
> > 02:05.0 SCSI storage controller: Adaptec: Unknown device 801f (rev 03)
> > 02:05.1 SCSI storage controller: Adaptec: Unknown device 801f (rev 03)
> > 03:03.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller (rev 02)
> > 04:01.0 Ethernet controller: Intel Corp.: Unknown device 100e (rev 02)
> > 04:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> > 
> > Thanks for Feedback.
> > 
> > Zeno
> > 
> 
> 


-- 
Mit freundlichen Gruessen / Best regards

Zeno Davatz
Strategie und Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.generika.cc
