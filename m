From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 11 Nov 2006 20:44:24 +0000
Subject: [lm-sensors] About fancontrol: I could not control the CPU fan
Message-Id: <45563628.4020605@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
In-Reply-To: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yongkui

>        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0800: 00 00 00 00 38 f7 77 bf a0 00 00 00 00 00 00 00
> 0810: 02 00 77 df ca 00 00 00 00 00 00 00 00 00 02 00
> 0820: 00 00 00 81 81 81 81 80 01 01 80 80 80 80 00 80
> 0830: 80 80 84 05 05 04 04 05 04 84 84 04 04 84 80 05
> 0840: 05 05 04 05 04 05 04 81 80 00 00 f7 77 1d 08 57
> 0850: 02 00 00 00 ff ff 10 7f f0 26 ff 00 00 00 00 00

Is this dump done before you loaded the driver?

Fan2 is set to fullspeed (bit 0 is 1)
Fan1 is set to some speed 001000 -> 8/64 of duty cycle


> So, the register 0x58 is f0, which is 11110000. But I am not sure 
> whether the Bit 0 is from left or right. I assume it is from right. So 
> Bit 0 to Bit 3 = 0, and Bit 4 to Bit 7 = 1.

Bits are from right.

> Accoring to Table 57 on page 118 of the manual, this means the Fout is 
> 15.625 kHz?

Yes seems correct to me.Please write there 80/120Hz so:

isaset -y -f 0x858 0xff

Is there a change in pwmconfig curve?

Regards
Rudolf

