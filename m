From: albertvd@gmail.com (Albert)
Date: Thu, 06 Jul 2006 18:10:01 +0000
Subject: [lm-sensors] Winbond W83627HF - deactivated
Message-Id: <66e9a78f0607061110o3ae4a911qa9edd5ce5f800263@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44AD4B8C.1010002@sh.cvut.cz>
In-Reply-To: <44AD4B8C.1010002@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/07/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> Albert wrote:
> > Hi Rudolf
> > On 06/07/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> This errors are normal. Ignore them.

It seems that I was too hasty in replying. I ran sensors-detect again
and it did detect the chip.

# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +0.90 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
VCore 2:   +1.52 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
+3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.95 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +11.92 V  (min = +10.82 V, max = +13.19 V)       ALARM
-12V:      -2.16 V  (min = -13.18 V, max = -10.80 V)
-5V:       -3.49 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
V5SB:      +5.03 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
VBat:      +2.05 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 225000 RPM, div = 2)
fan2:        0 RPM  (min = 7417 RPM, div = 2)
fan3:        0 RPM  (min = 675000 RPM, div = 2)
temp1:       +47??C  (high =   +73??C, hyst =   -28??C)   sensor = thermistor
temp2:     +73.0??C  (high =   +80??C, hyst =   +75??C)   sensor = thermistor
temp3:     -46.0??C  (high =   +80??C, hyst =   +75??C)   sensor = thermistor
vid:      +0.000 V  (VRM Version 8.2)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at d800
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

Now to set up the alarms...

Thanks for your help. It is much appreciated.

Albert

