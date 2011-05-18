From: "Javier S. Pedro" <javier@javispedro.com>
Date: Wed, 18 May 2011 12:32:03 +0000
Subject: Re: [lm-sensors] asus_atk0110 causes mouse and keyboard freeze in
Message-Id: <ir0e83$31j$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CF7B282.10007@verizon.net>
In-Reply-To: <4CF7B282.10007@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Did you get somewhere with this?

I too have a P7P55D. While I do not normally use atk0110, I decided to 
build it (2.6.37), load it on a system that had a few days of uptime and 
bang! keyboard and mouse were locked in 7 seconds.

(Tue, 07 Dec 2010 15:12:40 +0100) Luca Tettamanti:
> Ok, excellent. When the keyboard freezes ssh into the machine and take a
> snapshot of /proc/interrupts, then press a few keys and take another
> snapshot.
> Please also send me the dmesg (after the lock up).

i8042 seems to stop sending interrupts as seen on a /proc/interrupts diff:

7c7
<  16:       3322       3315       3313       3289   IO-APIC-fasteoi   
ehci_hcd:usb1, EMU10K1, nvidia
---
>  16:       3343       3336       3331       3309   IO-APIC-fasteoi   
ehci_hcd:usb1, EMU10K1, nvidia
11,12c11,12
<  40:      25414      25283      25248      25192   PCI-MSI-edge      
ahci
<  41:       3527       3533       3579       3598   PCI-MSI-edge      
eth0
---
>  40:      25440      25310      25278      25221   PCI-MSI-edge      
ahci
>  41:       3533       3538       3584       3603   PCI-MSI-edge      
eth0
15c15
< LOC:     145024     158135     165464      99774   Local timer 
interrupts
---
> LOC:     145282     158207     165545      99944   Local timer 
interrupts

Nothing was on dmesg after lockup, so no idea why this happens.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
