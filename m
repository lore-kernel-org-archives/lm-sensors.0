From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Tue, 06 Apr 2010 13:09:31 +0000
Subject: Re: [lm-sensors] Jetway NC92-330-LF and Fintek 71862FG Sensors
Message-Id: <3196.66.169.124.218.1270559371.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <6350.199.74.155.50.1269641903.squirrel@webmail.myamigos.us>
In-Reply-To: <6350.199.74.155.50.1269641903.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi,
>
> On 04/02/2010 09:24 PM, Jeff Rickman wrote:
>> This message was previously sent to the lm-sensors list on Friday
>> 26-March-2010.
>>
>> Resending in hopes someone, anyone, has any ideas regarding this matter.
>>
>> Thank you.
>> ----------------
>> Hello,
>>
>> I am using the Jetway NC-92-330-LF as a multi-purpose firewall and
>> router
>> with the attachment of the 3 port GigE daughterboard. In Fedora Core 10,
>> the sensors on the Fintek 71862FG Super I/O chip were detected and
>> accessible to LM-Sensors.
>>
>> Now in Fedora Core 12 running kernel 2.6.32.9-70.fc12.i686.PAE the
>> Fintek
>> F71862FG sensors are not accessible to LM-Sensors, apparently due to
>> ACPI
>> conflict.
>>
>
> <snip>
>
>>
>> Examination of "/var/log/messages" shows:
>>
>> Mar 26 16:34:58 XX yum: Installed: i2c-tools-3.0.2-4.fc12.i686
>> Mar 26 16:37:06 XX kernel: i2c /dev entries driver
>> Mar 26 16:37:21 XX kernel: f71882fg: Found f71862fg chip at 0x290,
>> revision 18
>> Mar 26 16:37:21 XX kernel: ACPI: I/O resource f71882fg [0x290-0x297]
>> conflicts with ACPI region IP__ [0x295-0x296]
>> Mar 26 16:37:21 XX kernel: ACPI: If an ACPI driver is available for this
>> device, you should use it instead of the native driver
>>
>
>
> ACPI has reserved that IO ports, so the hwmon driver is not allowed to
> touch
> them. Starting from 2.6.31 the kernel actually enforces that reservation.
>
> See the FAQ for the details:
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
>
> Regards,
>
> Hans
>

Hello Hans,

I understand, but are there any workarounds to getting this chip working
until an ACPI driver is available?

Thank you.

Jeff



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
