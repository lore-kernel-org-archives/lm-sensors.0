From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: sensors stop working after some hours/days
Message-Id: <20020111143311.R31003@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020108220123.CAPS1238.viefep16-int.chello.at@there>
In-Reply-To: <20020108220123.CAPS1238.viefep16-int.chello.at@there>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Please upgrade!

http://www.netroedge.com/~lm78/download.html

We have 2.6.2 out, or better yet get the current CVS.  Make sure you
get both i2c and lm_sensors2.  We can't help debug old versions since
such issues might long since have been fixed.


Phil

On Fri, Jan 11, 2002 at 11:18:48PM +0100, Matthias Meyer wrote:
> Hello
> 
> I have an lm_sensors 2.5.5 directory-tree on my harddisk.
> 
> I try modprobe i2c-dev and than your ideas.
> In the attachement you can find the outputs:
> 
> 

> w83782d-i2c-0-2d
> Adapter: SMBus AMD7X6 adapter at 50e0
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
> VCore 2:   +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
> +3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
> +5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
> +12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
> -12V:     -14.91 V  (min = -14.91 V, max = -14.91 V)              
> -5V:       -7.71 V  (min =  -7.71 V, max =  -7.71 V)              
> V5SB:      +0.13 V  (min =  +0.13 V, max =  +0.13 V)              
> VBat:      +0.08 V  (min =  +0.08 V, max =  +0.08 V)              
> fan1:       -1 RPM  (min =   -1 RPM, div = 1)                     
> fan2:       -1 RPM  (min =   -1 RPM, div = 1)                     
> fan3:       -1 RPM  (min =   -1 RPM, div = 1)                     
> temp1:      +0.0?C  (limit =   +0?C, hysteresis =   +0?C) sensor = thermistor           
> temp2:        +0?C  (limit =   +0?C, hysteresis =   +0?C) sensor = thermistor           
> temp3:        +0?C  (limit =   +0?C, hysteresis =   +0?C) sensor = PII/Celeron diode           
> vid:      +2.05 V
> alarms:   Chassis intrusion detection                             
> beep_enable:
>           Sound alarm disabled
> 

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c UU 2e 2f 
> 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f 
> 40: 40 41 42 43 44 45 46 47 UU UU 4a 4b 4c 4d 4e 4f 
> 50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f 
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f 
> 70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f 


-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
