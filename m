From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Tue, 15 May 2007 18:53:18 +0000
Subject: Re: [lm-sensors] hwmon/w83627ehf
Message-Id: <4dfa50520705151153j56912b63lffd8f0cc6bf5c186@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
In-Reply-To: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, All,

On 5/15/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Lambert, David,
>
> On Tue, 15 May 2007 10:19:59 +0200, Lambert Carsten wrote:
> > Actually I think it is working with the latest lm_sensors (2.10.3). I didn't
> > configure anything except uncommenting 'ignore in9' in /etc/sensors.conf as
> > advised by the emerge script (gentoo) for the W83627DHG chip. Here is the
> > output of sensors after installing and running the init script:
> >
> > sensors
> > w83627dhg-isa-0a00
> > Adapter: ISA adapter
> > VCore:     +1.26 V  (min =  +0.00 V, max =  +1.74 V)
> > in1:      +12.30 V  (min =  +1.37 V, max =  +7.55 V) ALARM
> > AVCC:      +3.26 V  (min =  +1.06 V, max =  +2.18 V) ALARM
> > 3VCC:      +3.26 V  (min =  +1.71 V, max =  +3.74 V)
> > in4:       +1.58 V  (min =  +1.11 V, max =  +1.04 V) ALARM
> > in5:       +1.66 V  (min =  +1.52 V, max =  +0.09 V) ALARM
> > in6:       +4.94 V  (min =  +5.43 V, max =  +1.31 V) ALARM
> > VSB:       +3.26 V  (min =  +2.58 V, max =  +2.21 V) ALARM
> > VBAT:      +3.17 V  (min =  +2.22 V, max =  +3.90 V)
> > Case Fan:    0 RPM  (min =    0 RPM, div = 64) ALARM
> > CPU Fan:   683 RPM  (min =  664 RPM, div = 8)
> > Aux Fan:     0 RPM  (min = 1757 RPM, div = 64) ALARM
> > fan4:        0 RPM  (min = 56250 RPM, div = 8) ALARM
> > fan5:        0 RPM  (min = 9375 RPM, div = 8) ALARM
> > Sys Temp:    +45 C  (high =  +115 C, hyst =   +27 C)
> > CPU Temp:  +24.5 C  (high = +80.0 C, hyst = +75.0 C)
> > AUX Temp: +121.5 C  (high = +80.0 C, hyst = +75.0 C)   ALARM
> >
> > The CPU Temp reading seems low but I put the machine to work and the temp went
> > up as expected and seems right. The CPU Fan reading I think is corrct too.
> > The bios is configured to speed up the fan when the CPU reaches 50 C.
>
> Could be that the Sys Temp and CPU Temp labels need to be swapped.
> Check the order and values in your BIOS (if it prints them.)
>
> > Here follows the isadumps you requested in case they are still usefull. It's
> > all 'middle clicked' this time so no typo.
> > (...)
> > isadump -y -k 0x87,0x87 0x4e 0x4f 0xb 0x7
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: ff ff ff ff ff ff ff 0b ff ff ff ff ff ff ff ff
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 20: a0 23 ff 00 44 00 40 ff 50 00 00 00 03 21 00 ff
> > 30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 60: 0a 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > f0: 81 ff 80 ff 00 01 00 00 ff ff ff ff ff ff ff ff
>
> This confirms that the configuration space of the W83627DHG is mapped
> to 0x4e/0x4f. This explains the log message that you reported: the
> driver printed it after it failed to find a device at 0x2e/0x2f. Then
> it tried 0x4e/0x4f and succeeded, so the message was only a warning,
> not an error.
>
> The w83627ehf driver should be changed to _not_ print a message when the
> device ID reads 0xffff (or 0x0000, for that matter) as it means there
> is _no_ chip at this address.
>
> On top of that, the driver should _not_ print a message by default when
> it finds an unsupported ID. It is perfectly valid to have a W83627DHG
> at 0x4e/0x4f and another LPC chip at 0x2e/0x2f. I think we already
> heard of boards with two LPC chips, and we don't want to fill the log
> with irrelevant messages in that case. So I believe that the driver
> should only print this message when compiled with debugging enabled, as
> the w83627hf driver is doing.
>
> David, can you please submit a patch doing that?

Yes, I'd consider it a bug when it finds an OK chip at 0x43. I'll look
at how w83627hf driver does it and copy that.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
