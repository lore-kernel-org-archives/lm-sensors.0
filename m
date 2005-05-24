From: sensors@xanthein.net (Jon Still)
Date: Tue, 24 May 2005 14:07:47 +0000
Subject: [lm-sensors] No temperature/fan values with 83627THF chip
Message-Id: <Pine.LNX.4.56.0505241253460.4962@io.tertial.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
In-Reply-To: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao & Rudolf,

The w83792d 2.6 driver is working great on my box now.

w83792d-i2c-0-2f
Adapter: SMBus I801 adapter at 0500
VCoreA:    +1.33 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
VCoreB:    +1.34 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
VIN0:      +3.34 V  (min =  +3.20 V, max =  +3.39 V)       
VIN1:      +3.02 V  (min =  +3.09 V, max =  +3.30 V)       ALARM
VIN2:      +0.52 V  (min =  +1.39 V, max =  +1.49 V)       ALARM
VIN3:      +3.12 V  (min =  +2.59 V, max =  +2.64 V)       ALARM
5VCC:      +5.03 V  (min =  +4.73 V, max =  +5.23 V)       
5VSB:      +4.92 V  (min =  +4.73 V, max =  +5.23 V)       
VBAT:      +3.10 V  (min =  +2.85 V, max =  +3.14 V)       
Fan2:     4687 RPM  (min = 1500 RPM, div = 4)              
Fan3:     4560 RPM  (min = 1500 RPM, div = 4)              
CPU Temp:  +24.0 C  (high = +42.0 C, hyst = +37.0 C)   ALARM
M/B Temp:  +30.0 C  (high = +43.0 C, hyst = +38.0 C)   ALARM
chassis:  Chassis is normal.

The voltages seem to be a little wonky, but I've no idea what Supermicro 
are doing with them!  Also is there any convention with the w83792d as to 
which thermistor is connected to which VTIN pin, or is it purely up to the 
board's manufacturer?

Having said that, so long as I can get the information I'm not really 
worried - I just want to make sure the box is relatively OK as I can't get 
physical access so readily.

Thanks to all for your help with this one!  I'll keep the drivers loaded 
and let you know if I see anything odd over the next week or so.

Thanks again!

Jon.

-- 
Jon Still                               E-mail: jon@tertial.org
tertial.org                             Web:    http://www.tertial.org/
GPG Key: http://xanthein.net/key.asc    Key ID: 0x00493D2B
