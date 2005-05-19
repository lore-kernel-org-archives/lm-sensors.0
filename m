From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Ticket number 725
Message-Id: <3BF5AA3A.EF1A4AFB@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011113225818.A4133@milhouse.turboshower.net>
In-Reply-To: <20011113225818.A4133@milhouse.turboshower.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

isadump 0x295 0x296


Jan Medlock wrote:
> 
> here's the output from 'sensors':
> 
> [medlock@milhouse medlock]$ sensors
> eeprom-i2c-0-50
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> 
> eeprom-i2c-0-51
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> 
> w83627hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.79 V  (min =  +1.23 V, max =  +1.36 V)
> VCore 2:   +0.00 V  (min =  +1.23 V, max =  +1.36 V)
> +3.3V:     +1.50 V  (min =  +3.13 V, max =  +3.45 V)
> +5V:       +4.97 V  (min =  +4.72 V, max =  +5.24 V)
> +12V:     +11.89 V  (min = +10.79 V, max = +13.19 V)
> -12V:      +2.10 V  (min = -10.90 V, max = -13.21 V)
> -5V:       +0.52 V  (min =  -4.76 V, max =  -5.26 V)
> V5SB:      +5.38 V  (min =  +4.72 V, max =  +5.24 V)
> VBat:      +3.12 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     4963 RPM  (min = 3000 RPM, div = 2)
> fan2:        0 RPM  (min = 3000 RPM, div = 2)
> fan3:        0 RPM  (min =  750 RPM, div = 8)
> temp1:       +24  (limit =  +60, hysteresis =  +50) sensor > thermistor
> temp2:     +36.0  (limit =  +60, hysteresis =  +50) sensor > thermistor
> temp3:    +255.5  (limit = +256, hysteresis = +256) sensor > thermistor
> vid:      +1.30 V
> alarms:   Chassis intrusion detection
> beep_enable:
>           Sound alarm disabled
> 
> I was asked to do an 'i2cdump' but this doesn't work because the chip
> is on an ISA bus.  I presume that I should use 'isadump' but with what
> arguments?
> 
> Thanks.
