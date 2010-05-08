From: mat <matthieu.stigler@gmail.com>
Date: Sat, 08 May 2010 09:47:15 +0000
Subject: Re: [lm-sensors] Problem with intel i7: not detected
Message-Id: <4BE53053.2010304@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BDEF051.7010708@gmail.com>
In-Reply-To: <4BDEF051.7010708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Dear Jean

Thank a lot for taking time to answer to all my questions!! I will look=20
rather on the acpi side as you suggest!

Merci!

Matthieu

Jean Delvare a =E9crit :
> Hi Matthieu,
>
> On Mon, 03 May 2010 21:18:33 +0530, mat wrote:
>  =20
>> I have a Dell Studio 1557 with intel i7, installed with Ubuntu 9.10. As =

>> many Dell Studio, it has the problem of overheating, reaching easily=20
>> temperatures of 80-90, sometimes even shutting down. Now, the fan does=20
>> not even start...
>>    =20
>
> That would most likely be an ACPI issue. Did you try upgrading your
> BIOS to the latest available version already?
>
>  =20
>> I really have few knowledge of that, but I tried to get better insights =

>> running lm-sensors, especially hoping to see whether the fan is=20
>> recognized...
>>    =20
>
> Fans are almost never supported by lm-sensors on laptops. Except for
> integrated CPU sensors (coretemp driver), lm-sensors has to rely on
> ACPI for monitoring and that usually means a couple temperature values
> being reported and that's it.
>
> You may be able to use vendor-specific kernel modules though, such as
> thinkpad_acpi, eeepc-laptop etc. For some Dell laptops, there's the i8k
> driver, you should give it a try if you didn't already, but probably
> it's for older models.
>
>  =20
>> Running
>> sudo sensors-detect
>> I have:
>> Trying family `National Semiconductor'...                   Yes
>> Found unknown chip with ID 0x8502
>>    =20
>
> We don't know all Super-I/O chips out there. But not all of them
> include hardware monitoring features, especially on laptops, so the
> above isn't necessarily meaningful. The next investigation step would
> be to figure out which chip it is exactly, which means either taking
> your laptop apart and looking at all the chips, or asking the vendor.
> Not very appealing either way.
>
>  =20
>> There was a similar post in the list:
>> http://www.spinics.net/lists/lm-sensors/msg27726.html
>>
>> But I don't really understand what was dealt there, and especially what =

>> are the conclusions, especially:
>> -whether there is a way to have this chip detected
>>    =20
>
> The chip is already detected. It isn't identified though.
>
>  =20
>> -whether this is likely to solve my problem of overheating /fan not work=
ing
>>    =20
>
> No, rather unlikely. What you want is to disassemble your ACPI tables
> (use acpidump) and have ACPI experts look at it. Maybe there's something
> wrong in there, that can be fixed by a BIOS update or worked around in
> the kernel.
>
>  =20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
