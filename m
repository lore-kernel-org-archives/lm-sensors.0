From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Hi, would you help me about lm87?
Message-Id: <20011106193039.B2843@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000a01c16736$4d826290$0a09010a@cn.mvd>
In-Reply-To: <000a01c16736$4d826290$0a09010a@cn.mvd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



It looks like your hardware has two LM87.  That's interesting!  It
looks like all the Bios readings are there (including a little extra).

So, what's the trouble?  Both core values are there, the fan,
temperatures, power supplies, etc.  The Bios has the benefit of being
customized to the hardware, but our code just tries to report
everything it can based on the hardware detected.  It looks it has
detected and reported everything the Bios has.


Phil


On Wed, Nov 07, 2001 at 10:45:36AM +0800, jack wrote:
>       Ticket #: 718 Timestamp: 2001-11-05 22:23:20-08 Version/Environment: lm_sensors 2.6.0 linux 2.4.5 
>       Subject: Some errors in lm87 sensors? Category: unsorted 
>       Contact: jzhao@mountainviewdata.com  Client Machine: 211.99.247.66 Status: Unconfirmed/Unexamined 
>       Problem in detail: 
> My hardware is supermicro??s 370DER, and only one CPU.
> 
> http://www.supermicro.com/product/motherboards/rcc_he_sl/370DER.htm
> 
> When I run sensor to get the PC health, I get the output as following:
> 
> lm87-i2c-0-2d
> Adapter: SMBus OSB4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> 2.5V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> Vccp1:     +1.29 V  (min =  +2.55 V, max =  +2.84 V)   ALARM
> 3.3V:      +3.35 V  (min =  +3.12 V, max =  +3.47 V)
> 5V:        +5.05 V  (min =  +4.73 V, max =  +5.26 V)
> 12V:      +12.25 V  (min = +11.37 V, max = +12.62 V)
> Vccp2:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> fan1:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> temp1:    +42.0?C   (min = +10?C, max = +60?C)
> CPU_Temp: +128.0?C   (min = +10?C, max = +60?C)  FAULT
> vid:       +1.30 V
> 
> lm87-i2c-0-2e
> Adapter: SMBus OSB4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> 2.5V:      +3.29 V  (min =  +1.41 V, max =  +1.57 V)   ALARM
> Vccp1:     +1.68 V  (min =  +2.55 V, max =  +2.84 V)   ALARM
> 3.3V:      +3.35 V  (min =  +3.12 V, max =  +3.47 V)
> 5V:        +5.05 V  (min =  +4.73 V, max =  +5.26 V)
> 12V:      +12.18 V  (min = +11.37 V, max = +12.62 V)
> Vccp2:     +1.49 V  (min =  +1.53 V, max =  +1.70 V)   ALARM
> fan1:     4017 RPM  (min = 3000 RPM, div = 2)
> fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> temp1:    +45.0?C   (min = +10?C, max = +60?C)
> CPU_Temp: +55.0?C   (min = +10?C, max = +60?C)
> vid:       +1.70 V
> 
> But I get data from BIOS is :
> cpu1       56C
> cpu2       N/A
> Overheat   85C
> cpu1 vcore 1.69
> cpu2 vcore 1.29
> +3.3v      3.35
> +5v        5.07
> +12v       12.25v
> cpu fan1   4066
> cpu fan2   N/A
> chasis fan1N/A
> chasis fan2N/A
> 
> Would you give me any advice?
> I need this output to be correct very much.
> Thank you !
> 
> 
> 
>      
>       Reply from support: 
> (unresolved/unanswered)
>      
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
