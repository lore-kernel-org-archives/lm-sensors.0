From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 07 Apr 2010 20:37:38 +0000
Subject: Re: [lm-sensors] Jetway NC92-330-LF and Fintek 71862FG Sensors
Message-Id: <k2r68676e01004071337q785b82eel8e5244f5193b20b3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6350.199.74.155.50.1269641903.squirrel@webmail.myamigos.us>
In-Reply-To: <6350.199.74.155.50.1269641903.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Tue, Apr 6, 2010 at 3:09 PM, Jeff Rickman <jrickman@myamigos.us> wrote:
>> On 04/02/2010 09:24 PM, Jeff Rickman wrote:
>>> Examination of "/var/log/messages" shows:
>>>
>>> Mar 26 16:34:58 XX yum: Installed: i2c-tools-3.0.2-4.fc12.i686
>>> Mar 26 16:37:06 XX kernel: i2c /dev entries driver
>>> Mar 26 16:37:21 XX kernel: f71882fg: Found f71862fg chip at 0x290,
>>> revision 18
>>> Mar 26 16:37:21 XX kernel: ACPI: I/O resource f71882fg [0x290-0x297]
>>> conflicts with ACPI region IP__ [0x295-0x296]
>>> Mar 26 16:37:21 XX kernel: ACPI: If an ACPI driver is available for this
>>> device, you should use it instead of the native driver
>>>
>>
>> ACPI has reserved that IO ports, so the hwmon driver is not allowed to
>> touch
>> them. Starting from 2.6.31 the kernel actually enforces that reservation.
>>
>> See the FAQ for the details:
>> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
>>
>
> I understand, but are there any workarounds to getting this chip working
> until an ACPI driver is available?

In your case I think that the monitoring chip is used for ACPI thermal zone:

>>> [root@XX ~]# sensors
>>> acpitz-virtual-0
>>> Adapter: Virtual device
>>> temp1:       +36.0°C  (crit = +100.0°C)

So that's the ACPI driver...
If you send me a copy of the DSDT I'll see if there's something interesting.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
