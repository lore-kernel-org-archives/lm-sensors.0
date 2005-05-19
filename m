From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: testing adm1026
Message-Id: <3D5F0456.22EAB4F7@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4.3.2.7.0.20020815223522.00ba6180@192.168.72.5>
In-Reply-To: <4.3.2.7.0.20020815223522.00ba6180@192.168.72.5>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
if you get it working all (or most) of the way,
please submit it to us for our package.
mds


"ing. Gert-Jan de Jonge" wrote:
> 
> Hi,
> 
> After following some instructions on the "New drivers" page, I did the
> following:
> /sbin/modprobe i2c-core
> /sbin/modprobe i2c-dev
> /sbin/modprobe i2c-piix4
> /sbin/modprobe i2c-proc
> /sbin/modprobe adm1025 force_adm1025=0,0x51,0,0x52
> 
> sensors output showed no correct temperature, after comparing the both
> datasheets i noticed the temp registers are located at
> different adresses. After playing around with the code of adm1025.c (only
> for the temp) I get the following output:
> adm1025-i2c-0-51
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> +2.5V:     +0.27 V  (min =  +2.22 V, max =  +2.72 V)
> VCore:     +0.09 V  (min =  +1.73 V, max =  +1.93 V)
> +3.3V:     +0.36 V  (min =  +2.93 V, max =  +3.59 V)   ALARM
> +5V:       +0.20 V  (min =  +4.45 V, max =  +5.44 V)   ALARM
> +12V:      +0.00 V  (min = +10.68 V, max = +13.06 V)
> VCC:       +0.00 V  (min =  +2.93 V, max =  +3.59 V)
> SYS Temp:  +32.0?C  (min =   +0?C, max =  +60?C) ALARM
> CPU Temp:   +0.0?C  (min =   +0?C, max =  +60?C) ALARM
> vid:       +1.85 V
> 
> adm1025-i2c-0-52
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> +2.5V:     +0.27 V  (min =  +2.22 V, max =  +2.72 V)
> VCore:     +0.09 V  (min =  +1.73 V, max =  +1.93 V)
> +3.3V:     +0.36 V  (min =  +2.93 V, max =  +3.59 V)   ALARM
> +5V:       +0.20 V  (min =  +4.45 V, max =  +5.44 V)   ALARM
> +12V:      +0.00 V  (min = +10.68 V, max = +13.06 V)
> VCC:       +0.00 V  (min =  +2.93 V, max =  +3.59 V)
> SYS Temp:  +32.0?C  (min =   +0?C, max =  +60?C) ALARM
> CPU Temp:   +0.0?C  (min =   +0?C, max =  +60?C) ALARM
> vid:       +1.85 V
> 
> I have not looked at the other values, at this moment i am especially
> interested in the temp, because it's causing some problems. ;)
> 
> regards,
> Gert-Jan de Jonge
> 
> p.s.: in adm1025.c i changed the following as a test:
> .....
> //#define ADM1025_REG_RTEMP 0x26
> #define ADM1025_REG_RTEMP 0x29
> //#define ADM1025_REG_TEMP 0x27
> #define ADM1025_REG_TEMP 0x1F
> .....
> //#define ADM1025_REG_RTEMP_HIGH 0x37
> //#define ADM1025_REG_RTEMP_LOW 0x38
> //#define ADM1025_REG_TEMP_HIGH 0x39
> //#define ADM1025_REG_TEMP_LOW 0x3A
> #define ADM1025_REG_RTEMP_HIGH 0x41
> #define ADM1025_REG_RTEMP_LOW 0x49
> #define ADM1025_REG_TEMP_HIGH 0x68
> #define ADM1025_REG_TEMP_LOW 0x69
> Gert-Jan de Jonge
> http://www.saturnus.nl/~gertjan
