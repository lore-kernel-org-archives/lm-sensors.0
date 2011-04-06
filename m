From: "D.B. Tsai" <dbtsai@gmail.com>
Date: Wed, 06 Apr 2011 09:34:02 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <BANLkTinr11a--bh+jCsCpAiym7o+ANLQ6A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hey

This is the error message I got. I hope that help.

[ 2338.411723] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[ 4594.391901] f71882fg: Found f71808a chip at 0xe80, revision 33
[ 4594.392414] ACPI: resource f71882fg [io  0x0e80-0x0e87] conflicts
with ACPI region HMIO [io 0xe80-0xf7f]
[ 4594.392423] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver

Thanks.

Best Wishes,

Dong-Bang Tsai    蔡東邦
Ph.D. Student in Applied Physics at Stanford University
史丹佛大學應用物理所博士班
-----------------------------------
Web : http://www.dbtsai.com
Phone : +1-650-383-8392  (USA)
            +886-910-008-392 (Taiwan)



On Wed, Apr 6, 2011 at 2:24 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 6 Apr 2011 01:54:56 -0700, D.B. Tsai wrote:
>> Hi
>>
>> Since Fintek F71808E seems to be quick closed to F71808A, I copy
>
> How can you tell? Similar numbers are no guarantee of compatibility.
>
>> everything related to 71808E into F71808A in the f71882fg.c. The code
>> can be compiled, but when I try to modprobe, I got the error message
>> "FATAL: Error inserting f71882fg
>> (/lib/modules/2.6.38-8-server/kernel/drivers/hwmon/f71882fg.ko):
>> Device or resource busy
>> "
>>
>> Anything I should notice?
>
> Read the kernel logs (dmesg | tail). Most likely ACPI requested the I/O
> ports in question for its own use.
>
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
>
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
