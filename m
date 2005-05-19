From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Disabling chassis intrusion alarm?
Message-Id: <3FCFB90A.1000804@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0312041256360.18024-100000@druifje.clustervision.com>
In-Reply-To: <Pine.LNX.4.44.0312041256360.18024-100000@druifje.clustervision.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You might also try placing a shorting jumper over the intrusion 
detection pins on the motherboard to prevent the alarm in the future.

:v)

John Hearns wrote:

>Dear all,
>can I ask for a little help please?
>I am trying to configure lm_sensors for a dual processor
>Supermicro motherboard.
>
>I'm using the Nagios plugin check_sensors,
>which very simply does a grep on the output of sensors,
>and returns an alarm sate if the string ALARM is present.
>On this motherboard, the chassis intrusion alarm is often set,
>and I'd rather not alarm on this.
>
>Is there a way of switching off this alarm in sensors.conf please?
>
>
>Here is the sensors output below.
>
>
>
>
>
>max1617-i2c-0-1a
>Adapter: SMBus I801 adapter at 1100
>Algorithm: Non-I2C SMBus adapter
>Board:       +29???C  (min =  +20???C, max =  +60???C)
>CPU:         +32???C  (min =  +20???C, max =  +60???C)
> 
>w83627hf-i2c-0-2d
>Adapter: SMBus I801 adapter at 1100
>Algorithm: Non-I2C SMBus adapter
>VCore 1:   +1.47 V  (min =  +4.08 V, max =  +4.08 V)
>VCore 2:   +3.32 V  (min =  +4.08 V, max =  +4.08 V)
>+3.3V:     +3.31 V  (min =  +2.97 V, max =  +3.63 V)
>+5V:       +4.97 V  (min =  +4.50 V, max =  +5.48 V)
>+12V:     +11.86 V  (min = +10.79 V, max = +13.11 V)
>-12V:     -11.41 V  (min = -13.21 V, max = -10.90 V)
>-5V:       -2.00 V  (min =  -5.51 V, max =  -4.51 V)
>V5SB:      +5.51 V  (min =  +4.50 V, max =  +5.48 V)
>VBat:      +3.24 V  (min =  +2.70 V, max =  +3.29 V)
>fan1:     4787 RPM  (min = 3000 RPM, div = 2)
>fan2:     4753 RPM  (min = 3000 RPM, div = 2)
>fan3:        0 RPM  (min =  750 RPM, div = 8)
>temp1:       +36???C  (limit =  +60???C)                       sensor = 
>thermistor
>temp2:     +30.0???C  (limit =  +60???C, hysteresis =  +50???C) sensor = 
>thermistor
>temp3:     +30.0???C  (limit =  +60???C, hysteresis =  +50???C) sensor = 
>thermistor
>vid:      +1.400 V
>alarms:   Chassis intrusion detection                      ALARM
>beep_enable:
>          Sound alarm disabled
>
>
>
>
>  
>

