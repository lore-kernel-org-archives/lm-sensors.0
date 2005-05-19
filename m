From: rankincj@yahoo.com (=?iso-8859-1?q?Chris=20Rankin?=)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Thermal fan on PIIIDME
Message-Id: <20020619011558.24140.qmail@web13105.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
In-Reply-To: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 --- phil@netroedge.com wrote:
> 
> 
> Try to find out what chip you have.

I have a pair of lm87 chips, at the very least:

lm87-i2c-0-2d
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
2.5V:      +2.51 V  (min =  +2.36 V, max =  +2.63 V)  

Vccp1:     +1.63 V  (min =  +1.53 V, max =  +1.72 V)  

3.3V:      +3.21 V  (min =  +3.12 V, max =  +3.47 V)  

5V:        +4.79 V  (min =  +4.73 V, max =  +5.26 V)  

12V:      +12.00 V  (min = +11.37 V, max = +12.62 V)  

Vccp2:     +3.27 V  (min =  +1.56 V, max =  +1.72 V)  
ALARM
Internal:    +55?C  (min =  +10?C, max =  +60?C) 
CPU_Temp:    +43?C  (min =  +10?C, max =  +60?C) 
vid:       +1.65 V

lm87-i2c-0-2e
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
Vccp1:     +1.63 V  (min =  +1.53 V, max =  +1.72 V)  

3.3V:      +3.21 V  (min =  +3.12 V, max =  +3.47 V)  

5V:        +5.02 V  (min =  +4.73 V, max =  +5.26 V)  

12V:      +11.93 V  (min = +11.37 V, max = +12.62 V)  

fan1:     4891 RPM  (min = 3000 RPM, div = 2)         

fan2:     4821 RPM  (min = 3000 RPM, div = 2)         

Internal:    +35?C  (min =  +10?C, max =  +60?C) 
CPU_Temp:    +48?C  (min =  +10?C, max =  +60?C) 
vid:       +1.65 V

The fans on lm87-i2c-0-2e are CPU fans, whereas the
other two on lm87-i2c-0-2d are for chassis fans (which
I don't have, and so aren't shown). I don't know where
the thermal fan may be connected.

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
