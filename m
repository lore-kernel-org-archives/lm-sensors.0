From: Hubert Kario <hka@qbs.com.pl>
Date: Thu, 02 Jul 2009 14:46:36 +0000
Subject: Re: [lm-sensors] false/fake lm_sensors result ?
Message-Id: <200907021646.37185.hka@qbs.com.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thursday 02 July 2009 14:05:17 czezz wrote:
> I have run lm_sensor on my Slackware 12.0.0 (generic kernel 2.6.22.6 #2 SMP
> form install DVD).
>
> "sensors-detect" found 3 modules.
> I have loaded them again, just for sure:
>
> # modprobe i2c-piix4
> # modprobe w83781d
> # modprobe eeprom
>
> This is an output of "sensors":
>
> # sensors
> w83782d-i2c-0-2d
> Adapter: SMBus PIIX4 adapter at 5000
> VCore 1:   +2.03 V  (min =  +1.79 V, max =  +2.19 V)
> VCore 2:   +1.49 V  (min =  +1.79 V, max =  +2.19 V)       ALARM
> +3.3V:     +3.28 V  (min =  +2.82 V, max =  +3.79 V)
> +5V:       +5.16 V  (min =  +6.85 V, max =  +6.40 V)       ALARM
> +12V:     +12.52 V  (min = +13.56 V, max = +15.50 V)       ALARM
> -12V:     -12.20 V  (min =  -8.41 V, max =  +5.73 V)       ALARM
> -5V:       -5.30 V  (min =  -2.94 V, max =  +2.69 V)       ALARM
> V5SB:      +5.03 V  (min =  +5.78 V, max =  +6.85 V)       ALARM
> VBat:      +2.98 V  (min =  +4.05 V, max =  +3.06 V)       ALARM
> fan1:        0 RPM  (min = 2700 RPM, div = 2)              ALARM
> fan2:        0 RPM  (min =    0 RPM, div = 2)
> fan3:        0 RPM  (min =    0 RPM, div = 2)
> temp1:       +47°C  (high =    -9°C, hyst =  +125°C)   sensor = thermistor
> temp2:    +120.5°C  (high =   +70°C, hyst =   +65°C)   sensor = thermistor 
>  ALARM temp3:     -48.0°C  (high =   +70°C, hyst =   +65°C)   sensor > thermistor vid:      +2.000 V  (VRM Version 8.2)
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm enabled
>
> w83782d-isa-0290
> Adapter: ISA adapter
> VCore 1:   +2.03 V  (min =  +1.79 V, max =  +2.19 V)
> VCore 2:   +1.49 V  (min =  +1.79 V, max =  +2.19 V)       ALARM
> +3.3V:     +3.28 V  (min =  +2.82 V, max =  +3.79 V)
> +5V:       +5.16 V  (min =  +6.85 V, max =  +6.40 V)       ALARM
> +12V:     +12.52 V  (min = +13.56 V, max = +15.50 V)       ALARM
> -12V:     -12.11 V  (min =  -8.41 V, max =  +5.73 V)       ALARM
> -5V:       -5.30 V  (min =  -2.94 V, max =  +2.69 V)       ALARM
> V5SB:      +5.03 V  (min =  +5.78 V, max =  +6.85 V)       ALARM
> VBat:      +2.99 V  (min =  +4.05 V, max =  +3.06 V)       ALARM
> fan1:        0 RPM  (min = 2700 RPM, div = 2)              ALARM
> fan2:        0 RPM  (min =    0 RPM, div = 2)
> fan3:        0 RPM  (min =    0 RPM, div = 2)
> temp1:       +47°C  (high =    -9°C, hyst =  +125°C)   sensor = thermistor
> temp2:    +121.0°C  (high =   +70°C, hyst =   +65°C)   sensor = thermistor 
>  ALARM temp3:     -48.0°C  (high =   +70°C, hyst =   +65°C)   sensor > thermistor vid:      +2.000 V  (VRM Version 8.2)
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm enabled
>
> I cant belive that "temp2" = 121 °C. Except that I dont know what temp2
> really is, I guess it is CPU (?). This same about temp3 -48. That machine
> does not stand in a fridge. Any help what is wrong ?

It looks like temp2 and temp3 are not connected (it's quite common, 
manufacturers frequently buy off-the-shelf equipment install only one or two 
thermistors to an IC that can monitor more of them), just ignore those 
results.

You can remove them entirely from view by adding

ignore temp2
ignore temp3

lines to your sensors config file to a section with following header:
chip "w83792d-*"

you can do the same to fan1-fan3
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



-- 
Hubert Kario
QBS - Quality Business Software
02-656 Warszawa, ul. Ksawerów 30/85
tel. +48 (22) 646-61-51, 646-74-24
www.qbs.com.pl

System Zarządzania Jakością
zgodny z normą ISO 9001:2000

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
