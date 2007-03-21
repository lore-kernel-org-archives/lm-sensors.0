From: forest@alittletooquiet.net (Forest Bond)
Date: Wed, 21 Mar 2007 17:09:06 +0000
Subject: [lm-sensors] Fintek F71805F on Jetway 627FWE1G
Message-Id: <20070321170906.GF19205@storm.local.network>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070321155103.GD19205@storm.local.network>
In-Reply-To: <20070321155103.GD19205@storm.local.network>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 21, 2007 at 12:58:21PM -0400, Forest Bond wrote:
> sensors output and /proc/cpuinfo are attached.

> Output of "isadump 0x295 0x296" is attached.  I am not quite sure how to
> interpret that, but I belive it is indicating that an offset of 0x5d is being
> applied to temp1, while temp2 and temp3 are being read as-is.  (Assuming the
> chip is indeed at that address).

...and I forgot to attach all of those files.  Sorry about that.  They are
attached here.

-Forest
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 09 01 ff ff ff 00 00 ff 37 01 17 0f ff 0f ff 
10: cf af 87 8a 77 8c 87 86 77 00 00 00 23 23 ff ff 
20: 01 21 0f ff 0f ff ff ff 0f ff 0f ff 0f ff fc 00 
30: 00 00 00 80 00 08 80 00 08 00 80 00 ff ff ff ff 
40: fc 00 fc 00 fc 00 fc 00 fc 00 fc 00 fc 00 80 00 
50: fc 00 fc 00 ff 00 ff 00 ff 00 03 04 10 19 34 ff 
60: 24 30 10 80 00 03 93 03 19 00 00 ff ff ff ff ff 
70: 24 30 25 80 00 03 93 03 10 00 00 ff ff ff ff ff 
80: 24 30 25 80 00 03 93 03 10 00 00 ff ff ff ff ff 
90: 5d 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: 64 64 64 ff 0f ff 0f ff 0f ff ff ff ff ff ff ff 
b0: 64 64 64 ff 0f ff 0f ff 0f ff ff ff ff ff ff ff 
c0: 64 64 64 ff 0f ff 0f ff 0f ff ff ff ff ff ff ff 
d0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 80 00 00 00 00 ff ec ff ff 00 00 00 ff ff ff ff 
-------------- next part --------------
processor	: 0
vendor_id	: CentaurHauls
cpu family	: 6
model		: 9
model name	: VIA Nehemiah
stepping	: 8
cpu MHz		: 997.271
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr cx8 mtrr pge cmov pat mmx fxsr sse rng rng_en ace ace_en
bogomips	: 1995.86
clflush size	: 32

-------------- next part --------------
f71805f-isa-0290
Adapter: ISA adapter
+3.3V:     +3.31 V  (min =  +0.00 V, max =  +4.03 V)  
Vtt1.2V:   +1.40 V  (min =  +0.00 V, max =  +2.02 V)  
Vram:      +2.16 V  (min =  +0.00 V, max =  +4.03 V)  
Vchip:     +3.45 V  (min =  +0.00 V, max =  +6.31 V)  
+5V:       +4.96 V  (min =  +0.00 V, max = +10.59 V)  
+12V:     +12.23 V  (min =  +0.00 V, max = +22.18 V)  
Vcc1.5V:   +1.08 V  (min =  +0.00 V, max =  +2.02 V)  
Vcore:     +1.07 V  (min =  +0.00 V, max =  +1.02 V)  ALARM
5VSB:      +5.00 V  (min =  +0.00 V, max = +10.59 V)  
CPU Fan:  5190 RPM  (min =    0 RPM)                  
Sys Fan:     0 RPM  (min =    0 RPM)                  
Aux Fan:     0 RPM  (min =    0 RPM)                  
CPU Temp:     +0 C  (high =  +255 C, hyst =    +0 C)         [diode]
Sys Temp:    +35 C  (high =  +255 C, hyst =    +0 C)         [thermistor]
Aux Temp:    +35 C  (high =  +255 C, hyst =    +0 C)         [thermistor]

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070321/f2012e60/attachment-0001.bin 
