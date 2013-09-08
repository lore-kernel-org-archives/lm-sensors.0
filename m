From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Sep 2013 16:55:17 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <522CABF5.40500@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/08/2013 09:33 AM, Tomas Larsson wrote:
> lsmod sayas that they are loaded
>
> dmesg
> i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> ACPI: resource 0000:00:1f.3 [io  0x2000-0x201f] conflicts with ACPI region
> SMB1 [io 0x2000-0x2016]
> ACPI: If an ACPI driver is available for this device, you should use it
> instead of the native driver
> coretemp coretemp.0: Unable to read TjMax from CPU.
> coretemp coretemp.0: Unable to read TjMax from CPU.
> smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
> ACPI: resource smsc47m1 [io  0x0680-0x06ff] conflicts with ACPI region RTIO
> [io 0x680-0x6ff]
> ACPI: If an ACPI driver is available for this device, you should use it
> instead of the native driver
>

You do see the answer above. You have an ACPI resource conflict.
See http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
