From: timm@fnal.gov (Steven Timm)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1833
Message-Id: <Pine.LNX.4.58.0412031228420.25485@boxer.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Further followup ticket 1833

i2cdump showed the chip at 0x2f on the i2c bus to be a winbond type chip.
I was able to follow the instructions on the web page and do 

insmod w83781d force_w83781d=0,0x2f

We then saw the following:

w83781d-i2c-0-2f
Adapter: SMBus I801 adapter at 0540
VCore 1:   +2.64 V  (min =  +2.37 V, max =  +3.17 V)              (beep)
VCore 2:   +2.66 V  (min =  +2.37 V, max =  +3.17 V)              (beep)
+3.3V:     +1.31 V  (min =  +3.14 V, max =  +3.46 V)              (beep)
+5V:       +2.05 V  (min =  +4.74 V, max =  +5.24 V)              (beep)
+12V:      +4.48 V  (min = +11.36 V, max = +12.58 V)       ALARM  (beep)
-12V:      -8.73 V  (min = -12.59 V, max = -11.33 V)       ALARM  (beep)
-5V:       -4.98 V  (min =  -5.25 V, max =  -4.74 V)       ALARM  (beep)
fan1:        0 RPM  (min = 2848 RPM, div = 2)                     (beep)
fan2:     10887 RPM  (min = 5696 RPM, div = 1)                     (beep)
fan3:     1298 RPM  (min =  712 RPM, div = 8)              ALARM  (beep)
temp1:       +47C  (high =  +127C, hyst =    +0C)          (beep)
temp2:     +41.0C  (high =   +78C, hyst =   +68C)   ALARM  (beep)
temp3:     +48.5C  (high =   +78C, hyst =   +68C)   ALARM  (beep)
vid:      +3.400 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm enabled

The two temperatures on this chip, temp2 and temp3, go up and down 
with load as expected.  temp1 appears to be constant.  The voltages 
are likely garbage but I am not concerned with that anyway.

The fan rpms fan2 and fan3, have non-zero readings on the slots
where they are expected, but not the right readings, should be about
5100-5400 rpms apiece.

Once this insmod is done, a second chip is detected at 2c as well,
which was previously not detectable
[root@fnpt126 seti]# sensors
w83627hf-i2c-0-2c
Adapter: SMBus I801 adapter at 0540
VCore 1:   +1.52 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
VCore 2:   +3.38 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
+3.3V:     +3.42 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.19 V  (min =  +4.74 V, max =  +5.24 V)
+12V:     +12.46 V  (min = +10.83 V, max = +13.19 V)
-12V:     -11.88 V  (min = -13.16 V, max = -10.90 V)
-5V:       +0.52 V  (min =  -5.26 V, max =  -4.76 V)       ALARM
V5SB:      +5.75 V  (min =  +4.74 V, max =  +5.24 V)       ALARM
VBat:      +0.02 V  (min =  +2.40 V, max =  +3.60 V)       ALARM
fan1:        0 RPM  (min = 3391 RPM, div = 2)              ALARM
fan2:        0 RPM  (min = 5532 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 39705 RPM, div = 2)              ALARM
temp1:       +31C  (high =   +80C, hyst =    +0C)   sensor = thermistor
temp2:     +29.5C  (high =   +80C, hyst =   +75C)   sensor = thermistor
temp3:     +28.5C  (high =   +80C, hyst =   +75C)   sensor = thermistor
vid:      +0.000 V  (VRM Version 8.2)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

The temp1 in this configuration corresponds to the system temperature.

Steve Timm


------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team
