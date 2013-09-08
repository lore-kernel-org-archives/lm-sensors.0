From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Sep 2013 17:47:20 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <522CB828.5000803@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 09/08/2013 10:15 AM, Tomas Larsson wrote:
> Ok, that explains things, so how to get it working, are there any
> aspi-drivers available?
>

Please don't top-post.

I don't think there is an acpi driver available; most of the time there isn=
't.
Also, looks like the acpi thermal module isn't loaded, meaning acpi may not=
 export
the necessary thermal information at all.

acpi drivers are highly board and vendor specific, which means that typical=
ly no one
really bothers to write a driver for it, including board vendors. Besides, =
most of the time
much of the available information from the chips is not exported to the use=
r through acpi,
so even if you had an acpi driver you would likely end up with limited or e=
ven no information.

Only option I could see (besides enabling the relax option) would be to dis=
assemble the DSDT,
check what is available, and if there is anything write a driver yourself t=
o access it.
By disassembling the DSDT you would also see what kind of risk you could ru=
n into by disabling
the region conflict checks.

Guenter

>
> With best regards
> Tomas Larsson
> TL Engineering & Consultants (TLEC)
> Engelbrektsgatan 121
> SE 50639 Bor=E5s
> Sweden
> +46 (0)739-932673
> tomas@tlec.se
> www.tlec.se
>
>
>> -----Original Message-----
>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>> Sent: Sunday, September 08, 2013 6:55 PM
>> To: Tomas Larsson
>> Cc: lm-sensors@lm-sensors.org
>> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
>>
>> On 09/08/2013 09:33 AM, Tomas Larsson wrote:
>>> lsmod sayas that they are loaded
>>>
>>> dmesg
>>> i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
>>> ACPI: resource 0000:00:1f.3 [io  0x2000-0x201f] conflicts with ACPI
>>> region
>>> SMB1 [io 0x2000-0x2016]
>>> ACPI: If an ACPI driver is available for this device, you should use
>>> it instead of the native driver coretemp coretemp.0: Unable to read
>>> TjMax from CPU.
>>> coretemp coretemp.0: Unable to read TjMax from CPU.
>>> smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
>>> ACPI: resource smsc47m1 [io  0x0680-0x06ff] conflicts with ACPI region
>>> RTIO [io 0x680-0x6ff]
>>> ACPI: If an ACPI driver is available for this device, you should use
>>> it instead of the native driver
>>>
>>
>> You do see the answer above. You have an ACPI resource conflict.
>> See http://www.lm-
>> sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.3
>> 1
>>
>> Guenter
>>
>>
>
>
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
