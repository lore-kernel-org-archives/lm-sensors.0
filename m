From: MrNice <wxcvbn2006@iol.ie>
Date: Sun, 23 Sep 2012 18:07:05 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <505F4FC9.1030109@iol.ie>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 09/17/2012 09:43 PM, Guenter Roeck wrote:
> On Mon, Sep 17, 2012 at 06:19:34PM +0100, MrNice wrote:
> [ ... ]
>
>> I had a look on the NCT5577D datasheet but it's not for me ;-)
>> So I tried your commands in a file named cpufan:
>> #!/bin/bash
>> isaset -y -f 0x2e 0x87
>> isaset -y -f 0x2e 0x87
>> isaset -y 0x2e 0x2f 0x7 0x8
>> isaset -y 0x2e 0x2f 0xf0 0xb2
>> isaset -y 0x2e 0x2f 0xf1 0xf2
>>
>> I have this error
>> sudo ./cpufan
>> Data mismatch, wrote 0x87, read 0xff back.
>> Data mismatch, wrote 0x87, read 0x09 back.
>>
>> Nothing more with sensors
>> What can I do?
> I am out of ideas. At this point I would need a board to be able to play =
with
> it. Reboot and live with it...
>
> Guenter
>
>
For the last few days I was testing different programs to monitor M/B=20
and CPU with Ubuntu and Windows 7, FYI:
AMD Overdrive
Core Temp
Hardware Monitor
None has the good values and are complete.

AMD Overdrive
has the 2 chassis fan value but not the CPU_fan pwm. It has a board temp=20
TMPIN1 value (64.7 degrees C) very high compare to other program. I=20
can't find what is TMPIN1.
It has a CPU temp (around 7 degrees C) so this is Tctl.

Core Temp
has CPU temp around 6 degrees C, so this is Tctl.
has "Tj. Max:" 70 degrees C.
More info here for the Tj. Max definition:
http://www.alcpu.com/forums/viewtopic.php?t=892
Do you agree with 70 C for the AMD FX-8120 CPU?
This program has no fan value area.

Hardware Monitor
has AUXTIN in the same way than sensors. Wrong value, should be idle=20
like with sensors.
has CPU Core temp around 6 C, so this is Tctl.
This program has no fan value area.

This afternoon, for some reason, sensors has CPU_Fan1 pwm value again:
fan1:            0 RPM  (min =3D    0 RPM)  ALARM
CPU_Fan1 pwm: 1036 RPM  (min =3D    0 RPM)  ALARM
fan3:            0 RPM  (min =3D    0 RPM)  ALARM
fan4:            0 RPM  (min =3D    0 RPM)
fan5:            0 RPM  (min =3D    0 RPM)  ALARM

this value is right compared to UEFI.
Do you want some info to understand why it's appear again?
Let me know.

Question: What program do you advise to heavy load the CPU and get=20
higher temp?

JP


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
