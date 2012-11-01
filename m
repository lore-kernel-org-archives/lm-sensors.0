From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 01 Nov 2012 19:25:56 +0000
Subject: Re: [lm-sensors] f71882fg not showing motherboard temps
Message-Id: <5092CCC4.8090701@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5091A80D.3090101@embarqmail.com>
In-Reply-To: <5091A80D.3090101@embarqmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 11/01/2012 05:38 PM, Logan Freijo wrote:
> On 11/1/2012 12:19 PM, Hans de Goede wrote:

<snip>

>> Can you do a "cat /proc/ioports" and send us the output?
>>
>> That may help to figure out what is causing the io conflict.
>>
>> Regards,
>>
>> Hans
>>
> Here you go:
>
> 0000-0cf7 : PCI Bus 0000:00
>    0000-001f : dma1
>    0020-0021 : pic1
>    0040-0043 : timer0
>    0050-0053 : timer1
>    0060-0060 : keyboard
>    0064-0064 : keyboard
>    0070-0071 : rtc0
>    0080-008f : dma page reg
>    00a0-00a1 : pic2
>    00c0-00df : dma2
>    00f0-00ff : fpu
>    0170-0177 : 0000:00:14.1
>      0170-0177 : pata_atiixp
>    01f0-01f7 : 0000:00:14.1
>      01f0-01f7 : pata_atiixp
>    0225-0244 : pnp 00:09
>    0376-0376 : 0000:00:14.1
>      0376-0376 : pata_atiixp
>    03f6-03f6 : 0000:00:14.1
>      03f6-03f6 : pata_atiixp
>    040b-040b : pnp 00:08
>    04d0-04d1 : pnp 00:08
>    04d6-04d6 : pnp 00:08
>    0800-089f : pnp 00:08
>      0800-0803 : ACPI PM1a_EVT_BLK
>      0804-0805 : ACPI PM1a_CNT_BLK
>      0808-080b : ACPI PM_TMR
>      0810-0815 : ACPI CPU throttle
>      0820-0827 : ACPI GPE0_BLK
>    0900-090f : pnp 00:08
>    0910-091f : pnp 00:08
>    0ae0-0aef : pnp 00:09
>    0b00-0b0f : pnp 00:08
>    0b20-0b3f : pnp 00:08
>    0c00-0c01 : pnp 00:08
>    0c14-0c14 : pnp 00:08
>    0c50-0c51 : pnp 00:08
>    0c52-0c52 : pnp 00:08
>    0c6c-0c6c : pnp 00:08
>    0c6f-0c6f : pnp 00:08
>    0cd0-0cd1 : pnp 00:08
>    0cd2-0cd3 : pnp 00:08
>    0cd4-0cd5 : pnp 00:08
>    0cd6-0cd7 : pnp 00:08
>    0cd8-0cdf : pnp 00:08
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>    8000-800f : 0000:00:11.0
>      8000-800f : ahci
>    9000-9003 : 0000:00:11.0
>      9000-9003 : ahci
>    a000-a007 : 0000:00:11.0
>      a000-a007 : ahci
>    b000-b003 : 0000:00:11.0
>      b000-b003 : ahci
>    c000-c007 : 0000:00:11.0
>      c000-c007 : ahci
>    d000-dfff : PCI Bus 0000:01
>      d000-d0ff : 0000:01:05.0
>    e000-efff : PCI Bus 0000:02
>      e800-e8ff : 0000:02:00.0
>        e800-e8ff : r8169
>    fe00-fefe : pnp 00:08
>    ff00-ff0f : 0000:00:14.1
>      ff00-ff0f : pata_atiixp

Hmm, it seems that your bios is claiming
the io-range for the hwmon part (and then some
more ports too ...)

Can you try adding "pnp_reserve_io=0x220,8" on the kernel
cmdline? That *might* help. Also to further debug this,
can you please do:

ls -lR /sys/bus/pnp/devices/00\:09/

And:

cat /sys/bus/pnp/devices/00\:09/id

And include the output in your next mail?

Thanks,

Hans



>
> Thanks,
>
> Logan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
