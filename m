From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: i2c-piix4 problem
Message-Id: <200408170112.13966.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408041637.21472.lists@localguru.de>
In-Reply-To: <200408041637.21472.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 06 August 2004 15:56, Jean Delvare wrote:
> >> A.k.a. no sensors found, unless a problem occured. If you're certain
> >> that there is a hardware monitoring chip on that board and
> >> sensors-detect missed it, please give us:
> >> 1* The brand and name of the motherboard.
> >> 2* The full output of sensors-detect.
> >> 3* The brand and name of the monitoring chipset we are after.
> >
> >I have physical access to the machine tomorrow or is there a way to check
> >that remote. Here is the sensors-detect output:
>
> Precisely, sensors-detect is the only remote way I know of.
> Unfortunately, the output you provide seems to confirm that you don't
> have any hardware monitoring chip on-board. The only responsive
> addresses on the SMBus are for EEPROMs, and no ISA chip is detected
> either. You seem to have a rather old version of sensors-detect which
> doesn't not scan Super-I/O chips, but since your system is most likely
> not very recent, I would be surprised to find such a chip.
>
> You may still try visual inspection, or a more up-to-date version of
> sensors-detect which searches for Super-I/O chips. Who knows...

I had no visual inspection yet, but I found the manual of the motherboad. It's 
GA-568TX3 (PCI-ISA BUS). Does this information help?

Cheers,
Marcus
