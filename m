From: d.piccoli@murdoch.edu.au (Daniel Piccoli)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: ADM 1025 on 2.6 kernel
Message-Id: <1089180427.13672.6.camel@powerride>
List-Id: <lm-sensors.vger.kernel.org>
References: <1084951647.6186.13.camel@powerride>
In-Reply-To: <1084951647.6186.13.camel@powerride>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

this is the sensors output:

adm1025-i2c-0-2d
Adapter: SMBus I801 adapter at efa0
+2.5V:     +2.49 V  (min =  +0.00 V, max =  +3.32 V)
VCore:     +1.68 V  (min =  +0.00 V, max =  +2.99 V)
+3.3V:     +3.37 V  (min =  +0.00 V, max =  +4.38 V)
+5V:       +4.92 V  (min =  +0.00 V, max =  +6.64 V)
+12V:     +11.94 V  (min =  +0.00 V, max = +15.94 V)
VCC:       +3.39 V  (min =  +0.00 V, max =  +4.38 V)
CPU Temp:  +43.0 C  (low  =    +0 C, high =  +127 C)
M/B Temp:  +39.0 C  (low  =    +0 C, high =  +127 C)
vid:      +1.700 V

The CPU is a Pentium III 866 (SL4MD). Its voltage is supposed to be 1.7V

Here is the output of /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 864.112
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1708.03

thanks,

regards Daniel

On Wed, 2004-07-07 at 13:59, Jean Delvare wrote:
> Hi Daniel,
> 
> > I have just tried the unified linux patch for ADM 1025 and everything
> > seems to be working fine.
> 
> Great :)
> 
> > The VID value is +1.700 V
> 
> I guess you were using a recent CVS snapshot of lm_sensors?
> 
> Do you know if this is the correct voltage for your CPU? What CPU is it
> BTW? Please show /proc/cpuinfo. I would also appreciate the output of
> "sensors" itself.
> 
> Thanks for testing.
