From: paul.aviles@palei.com (Paul Aviles)
Date: Tue, 08 Nov 2005 23:12:35 +0000
Subject: [lm-sensors] adm1027 on 2.6.9-5.EL
Message-Id: <20051108205859.M19825@palei.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <XVkq04oM.1131444138.7357880.khali@localhost>
In-Reply-To: <XVkq04oM.1131444138.7357880.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

almost positive this is my issue not the cpu or board.

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 2994.321
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl 
cid xtpr
bogomips        : 5914.62

Also, what about the pwm for the fans

On Tue, 8 Nov 2005 20:00:35 +0100 (CET), Jean Delvare wrote
> Hi Paul,
> 
> On 2005-11-08, Paul Aviles wrote:
> > # i2cdump 0 0x2e b
> > (...)
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 20: c7 74 c5 c4 00 29 23 25 a1 02 6e 03 a0 02 00 00    ?t??.)#%??n???..
> > 30: 40 40 40 64 64 64 00 00 00 00 00 00 00 27 41 6a    @@@ddd.......'Aj
> > 40: 05 80 01 d3 be d2 6b 82 b6 ca b6 ca 00 ff 05 44    ??????k?????..?D
> 
> This confirms that this is an ADT7463. The detection code is already
> fixed in later versions of the driver. In the meantime you may want 
> to add the following line to /etc/modprobe.conf:
> 
> options lm85 force_adt7463=0,0x2e
> 
> One mystery remains. The VRM detection code said your CPU used VRM 
> 9.1, while the chip is configured in VRM 10 mode. What's your CPU? Please
> paste /proc/cpuinfo. Maybe your CPU is too recent and was not yet
> supported by our code in 2.6.9.
> 
> Thanks,
> --
> Jean Delvare


