From: "Peter Mahlknecht" <mali100@gmx.net>
Date: Sat, 01 Nov 2008 22:16:56 +0000
Subject: Re: [lm-sensors] ACPI reads wrong temperature after loading
Message-Id: <20081101221656.43350@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081101103904.7ea43d94@hyperion.delvare>
In-Reply-To: <20081101103904.7ea43d94@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
> I don't think so. Let's wait for Peter to do the tests I suggested
> first.
> 
I got the new kernel (2.6.27.4) running, here is what it outputs during boot:
Nov  1 22:48:30 laptop-mali kernel: [    9.670886] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Nov  1 22:48:30 laptop-mali kernel: [    9.670946] ACPI: I/O resource 0000:00:1f.3 [0x18e0-0x18ff] conflicts with ACPI region SMBI [0x18e0-0x18ef]
Nov  1 22:48:30 laptop-mali kernel: [    9.671002] ACPI: Device needs an ACPI driver

as just wrote before, as long as i2c-i801 isn't loaded i get the right temperatures, also if em28xx_cx25843 or lm90 (or both) are loaded. 
dmesg output from my notebook can be found here: http://stud3.tuwien.ac.at/~e0526314/dmidecode_log

Thanks for the help
Peter
-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
