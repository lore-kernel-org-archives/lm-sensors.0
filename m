From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 17:39:11 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic card temperature
Message-Id: <20051218183911.5c3b99a4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399BE92.9020705@mathematica.scientia.net>
In-Reply-To: <4399BE92.9020705@mathematica.scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Volker,

> Thanks, that makes sense. Loading nvidiafb gives in syslog
> 
> kernel: nvidiafb: module not supported by Novell, setting U taint flag.
> kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 58
> kernel: PCI: Unable to reserve mem region #2:10000000 at e0000000 for device 0000:05:00.0
> kernel: nvidiafb: cannot request PCI regions
> kernel: ACPI: PCI interrupt for device 0000:05:00.0 disabled
> kernel: klogd 1.4.1, ---------- state change ----------
> 
> Which doesn't look too good to me, and sensors-detect doesn't find
> anything more. From lspci
> 
> 05:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2)

Look for a conflicting device in /proc/iomem.

-- 
Jean Delvare

