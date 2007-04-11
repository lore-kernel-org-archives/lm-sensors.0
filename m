From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Wed, 11 Apr 2007 01:48:58 +0000
Subject: Re: [lm-sensors] w83627ehf reporting ghost fan?
Message-Id: <4dfa50520704101848hfbf1db9v9734f2e0a0a7a1f1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <461C3562.2070006@gmail.com>
In-Reply-To: <461C3562.2070006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ankit,

Thank you for reporting this. This issue has been reported before, and
I was unable to reproduce the error. I would like to track this down,
although it might be a little difficult. Can you please provide the
following information? (I am looking for the root cause)

Motherboard info: manufacturer, model number
CPU: manufacturer, model, speed
RAM installed
Graphics Card

How often have you seen this problem? Is it reproducible?

Would you also be able to sign on to irc.freenode.net #linux-sensors
on Saturday? (And if yes, what times?)

I have an Asus A8N-VM/CSM, with an AMD Athlon 64 X2 4400+, 1 Gb RAM,
and no graphics card (I use the integrated nVidia 6150 on the
A8N-VM/CSM).

Thanks,
David

On 4/10/07, Ankit Chaturvedi <ankit.chaturvedi@gmail.com> wrote:
> Hi,
>                 I am having this message repeated in my kernel log over and over again :
>
> ------
> [100817.346197] w83627ehf 9191-0a10: Increasing fan 4 clock divider from 64 to 128
> [100822.343770] w83627ehf 9191-0a10: Increasing fan 4 clock divider from 64 to 128
> [100827.339333] w83627ehf 9191-0a10: Increasing fan 4 clock divider from 64 to 128
> [100830.901327] w83627ehf 9191-0a10: Increasing fan 4 clock divider from 64 to 128
> [100832.334967] w83627ehf 9191-0a10: Increasing fan 4 clock divider from 64 to 128
> [100837.332900] w83627ehf 9191-0a10: Increasing fan 4 clock divider from 64 to 128
> ------
>         I tried adding "ignore fanx" to sensors.conf, as I have only one 3 wire fan(CPU Fan) but the message still shows up. The relevent portion of my sensors.conf file is:
>
> -------
>    label fan1      "Case Fan"
>    label fan2      "CPU Fan"
>    label fan3      "Aux Fan"
>    ignore fan3
>    ignore fan1
>    ignore fan4
>    ignore fan5
> ----
> And the corresponding sensors output goes like this:
>
> -----
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>              +35 C
> Core1 Temp:
>              +37 C
>
> w83627ehf-isa-0a10
> Adapter: ISA adapter
> VCore:     +1.31 V  (min =  +0.00 V, max =  +1.74 V)
> in1:      +12.46 V  (min = +13.36 V, max =  +6.49 V) ALARM
> AVCC:      +3.36 V  (min =  +3.06 V, max =  +1.20 V) ALARM
> 3VCC:      +3.36 V  (min =  +3.79 V, max =  +2.80 V) ALARM
> in4:       +1.62 V  (min =  +0.91 V, max =  +1.49 V) ALARM
> in5:       +1.62 V  (min =  +2.04 V, max =  +1.51 V) ALARM
> in6:       +5.20 V  (min =  +6.53 V, max =  +0.54 V) ALARM
> VSB:       +3.28 V  (min =  +1.90 V, max =  +2.90 V) ALARM
> VBAT:      +3.04 V  (min =  +3.90 V, max =  +3.68 V) ALARM
> in9:       +1.45 V  (min =  +1.26 V, max =  +1.23 V) ALARM
> CPU Fan:  4218 RPM  (min =  892 RPM, div = 8)
> Sys Temp:    +38 C  (high =   -83 C, hyst =  +105 C)
> CPU Temp:  +40.0 C  (high = +80.0 C, hyst = +75.0 C)
> AUX Temp:  +41.0 C  (high = +80.0 C, hyst = +75.0 C)
> -------
>
>         Here only one fan(CPU Fan) is being listed. Earlier another fan(fan4) was also listed with div8 (probably the one referred to in kernel logs) which stopped showing up after adding "ignore fanx" to sensors.conf. But that did not stop printing the line in dmesg output. The sensors are working good otherwise, but it is really annoying as it fills up my whole kernel log, and after 30-40 mins of uptime, I don't have anything else remaining in dmesg output. Any ideas?
>
>         Also, any specific reason why the min and max values are interchanged? Should I set those manually in sensors.conf? Thanks in advance.
>
> Regards,
> Ankit Chaturvedi
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
