From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 08 Mar 2007 18:08:12 +0000
Subject: [lm-sensors] IT8726F support (was: mcp61 sensors support)
Message-Id: <20070308190812.6a2253f5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070301075719.9e1c0127.khali@linux-fr.org>
In-Reply-To: <20070301075719.9e1c0127.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

On Wed, 7 Mar 2007 23:10:01 -0500, Thomas Garner wrote:
> Sorry this has taken some time to do.

No problem, I'm busy with other stuff anyway and won't have time to
look into clean IT8726F support anytime soon.

> [root at ns ~]# modprobe it87
> [root at ns ~]# tail -n 1 /var/log/kern.log
> Mar  7 21:55:48 ns kernel: it87: Found IT8726F chip at 0x290, revision 1
> [root at ns ~]# sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>              +26 C
> Core1 Temp:
>              +24 C
> 
> it8716-isa-0290
> Adapter: ISA adapter
> VCore:     +1.26 V  (min =  +0.00 V, max =  +4.08 V)
> VDDR:      +2.50 V  (min =  +1.28 V, max =  +1.68 V)   ALARM
> +3.3V:     +1.87 V  (min =  +2.78 V, max =  +3.78 V)   ALARM
> +5V:       +5.54 V  (min =  +4.49 V, max =  +5.48 V)   ALARM
> +12V:      +4.93 V  (min =  +9.98 V, max = +13.95 V)   ALARM
> in5:       +1.17 V  (min =  +0.58 V, max =  +1.34 V)
> in6:       +2.98 V  (min =  +1.04 V, max =  +1.36 V)   ALARM
> 5VSB:      +5.03 V  (min =  +4.49 V, max =  +5.48 V)
> VBat:      +2.98 V
> fan1:     3013 RPM  (min =   10 RPM)
> fan2:     1298 RPM  (min =   10 RPM)
> temp1:       +24 C  (low  =  +127 C, high =  +127 C)   sensor = diode
> temp2:       +34 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor
> temp3:       +25 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor
> vid:      +1.525 V

Fans and temperatures look good, voltages not quite so. Not really
surprising, as voltages are the only significant difference between the
IT8716F and the IT8726F as far as hardware monitoring is concerned. The
difference is that the in4, in5 and in6 pins can be used for an
alternative function. The datasheet isn't very clear what this
alternative function is though. I asked my contact at ITE and he tried
to clarify, he did help to some degree but I have to admit I am still
confused. So I think we'll have to wait for more users with that chip
to find out how the IT8726F works exactly.

In the mean time, at least Vcore, VDDR, 5VSB and Battery look OK for
you, so not too bad.

> [root at ns ~]# isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 0x04
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 4 using bank register 0x07.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 87 26 01 11 00 41 d4 01 00 08 81 00 40 00 00 00
                                          ^^
This is the register which is supposed to make a difference, but bit 6
being set probably means that your chip behaves like an IT8716F would.

> 30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 02 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 02 00 00 04 04 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 80 00 0a 00 80 00 ff 00 00 00 00 00 00 00 00 00
> 
> Since this machine is remote to me, I looked at the manual from the
> manufacturer.  It gives:
> 
> CPU Tcontrol
> System Temperature
> CPU Fan Speed
> System Fan Speed
> CPU Vcore
> VDIMM
> 
> If needed, I get get remote hands to verify.

Well the idea is to compare the values displayed by the BIOS and the
values displayed by "sensors" to ensure that the labels match and the
compute forumlas are correct. But the items you list here are probably
already correct so maybe you don't want to bother.

What would have been really interesting are the other values - +3.3V,
+5V, +12V, which aren't correct in the sensors output. But if your BIOS
doesn't show these, there's no possible comparison and it might even
mean that these pins aren't wired. If some of the voltage values
displayed by sensors change all the time, we can assume the pins are
left floating.

Quoting myself:
> > Recompile, test and report. The report should include the output of
> > "sensors" and the message printed in the kernel logs when you loaded
> > the it87 driver.

You didn't report what was to be seen in the logs.

-- 
Jean Delvare

