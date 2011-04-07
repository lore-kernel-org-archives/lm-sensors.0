From: "D.B. Tsai" <dbtsai@gmail.com>
Date: Thu, 07 Apr 2011 08:01:18 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <BANLkTiknvaPJ=fQ7LwZ+MUJr2ZNr1fu_Vg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean

Thank you for clarification. But is it possible that when I/O ports is
controlled by motherboard, the kernels can still "read" the
information from the I/O ports rather than read and write data to I/O
ports? I think in this case, at least, I can monitor my fan speed
without really controlling the ports, and I think it's still safe.

Thanks.

Best Wishes,

Dong-Bang Tsai    蔡東邦
Ph.D. Student in Applied Physics at Stanford University
史丹佛大學應用物理所博士班
-----------------------------------
Web : http://www.dbtsai.com
Phone : +1-650-383-8392  (USA)
            +886-910-008-392 (Taiwan)



On Thu, Apr 7, 2011 at 12:29 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 6 Apr 2011 13:47:45 -0700, D.B. Tsai wrote:
>> Hi
>>
>> Sure, I can take the risk of the disabling acpi resource conflict
>> check, and I'm willing to test your code. Please let send me the code
>> when you finish it. By the way, I'm using Ubuntu 11.04 with kernel
>> 2.6.38-8-server, and wondering to know that when will the mainline
>> kernel fix this conflict issue?
>
> Never, as this isn't a bug per se. Your ACPI BIOS wants to control the
> I/O ports, the kernels wants them too, and that's about it. If your
> BIOS requests the I/O ports but doesn't use them, then it's a bug in
> your BIOS.
>
> Some vendors (Asus) request the I/O ports for a reason, and they
> implement a proprietary interface on top of the hardware monitoring
> chip. In this case it is possible to write an ACPI driver as a
> replacement for the native driver. Unfortunately, most other vendors
> which request the I/O ports don't implement anything like this.
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
