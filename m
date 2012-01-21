From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 Jan 2012 18:13:55 +0000
Subject: Re: [lm-sensors] w83627ehf can not be modprobed as of 3.3-rc1
Message-Id: <20120121191355.2838a102@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAG-2HqVsLbpTrUAJ06AU-9_rOjQtkHap1ygYqpH_RBfM5ESb6w@mail.gmail.com>
In-Reply-To: <CAG-2HqVsLbpTrUAJ06AU-9_rOjQtkHap1ygYqpH_RBfM5ESb6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 21 Jan 2012 18:27:17 +0100, Tom Gundersen wrote:
> Hi guys,
> 
> I don't know the importance of this, or if it is even a bug, but I get
> a difference in behavior when updating from 3.2 to 3.3:
> 
> # modprobe w83627ehf
> FATAL: Error inserting w83627ehf
> (/lib/modules/3.3.0-rc1-ARCH/kernel/drivers/hwmon/w83627ehf.ko):
> Device or resource busy
> 
> 
> from dmesg:
> 
> w83627ehf: Found W83627DHG chip at 0x290
> ACPI Warning: 0x0000000000000295-0x0000000000000296 SystemIO conflicts
> with Region \_SB_.PCI0.SBRG.SIOR.HWRE 1 (20120111/utaddress-251)
> ACPI: If an ACPI driver is available for this device, you should use
> it instead of the native driver

That was indeed a bug... in 3.2. Kernels between 2.6.39 and 3.2
(inclusive) lack the ACPI resource conflict check, it was accidentally
disabled. And this is fixed in 3.3.

See
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
for details.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
