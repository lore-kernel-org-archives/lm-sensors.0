From: haakon@apelseth.com (haakon@apelseth.com)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: Lm-sensors 2.8.0 on Asus P3B-F
Message-Id: <OF80F6F91B.458FD91D-ONC1256D6A.001632F6-C1256D6A.001744CE@apelseth.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <OFCA88DDCC.BD2AC8B4-ONC1256D69.007A5603-C1256D69.007B6BB2@apelseth.com>
In-Reply-To: <OFCA88DDCC.BD2AC8B4-ONC1256D69.007A5603-C1256D69.007B6BB2@apelseth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org






Hi,

Thank's for the fast reply and now i might hav another silly question.

How can i pick out the "temp2" value from sensors then?

With the sensors command:
temp2:     +40.0?C  (limit =  +67?C, hysteresis =  +60?C)

but with the: head -1l /proc/sys/dev/sensors/as99127f-i2c-0-2d/temp2
[[A60.0 50.0 22.0


H?kon.


|---------+---------------------------->
|         |           "Mark D.         |
|         |           Studebaker "     |
|         |           <mds@paradyne.com|
|         |           >                |
|         |                            |
|         |           21.07.2003 02:32 |
|         |           Please respond to|
|         |           LM Sensors       |
|---------+---------------------------->
  >-----------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                       |
  |       To:       haakon@apelseth.com                                                                                   |
  |       cc:       sensors@Stimpy.netroedge.com                                                                          |
  |       Subject:  Re: Lm-sensors 2.8.0 on Asus P3B-F                                                                    |
  >-----------------------------------------------------------------------------------------------------------------------|




Not a bug.
the values in /proc are the raw values returned by the driver.
the values from 'sensors' are converted by the libsensors library
using the 'compute' lines in /etc/sensors.conf.

haakon@apelseth.com wrote:
>
>
>
> Hi,
>
> I'm having a bit strange result with Lm-sensors v2.8.0.
> It look's ok when i just use "sensors"
>
> like this:
> # sensors
> as99127f-i2c-0-2d
> Adapter: SMBus PIIX4 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.64 V  (min =  +4.08 V, max =  +4.08 V)       ALARM
> VCore 2:   +2.59 V  (min =  +4.08 V, max =  +4.08 V)       ALARM
> +3.3V:     +3.47 V  (min =  +3.13 V, max =  +3.45 V)       ALARM
> +5V:       +5.16 V  (min =  +4.72 V, max =  +5.24 V)
> +12V:     +11.67 V  (min = +10.79 V, max = +13.19 V)
> -12V:     -11.88 V  (min = -13.19 V, max = -10.73 V)
> -5V:       -5.06 V  (min =  -5.24 V, max =  -4.74 V)
> fan1:     4753 RPM  (min = 1500 RPM, div = 4)
> fan2:        0 RPM  (min = 1500 RPM, div = 4)              ALARM
> fan3:        0 RPM  (min = 1500 RPM, div = 4)              ALARM
> temp1:       +31?C  (limit =  +60?C, hysteresis = +127?C)
> temp2:     +40.0?C  (limit =  +67?C, hysteresis =  +60?C)
> temp3:    +112.2?C  (limit =  +60?C, hysteresis =  +50?C)
> vid:      +16.50 V
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm enabled
>
> but if i run these lines afterwards i get another reading:
> # head -1l /proc/sys/dev/sensors/as99127f-i2c-0-2d/temp1
> ^[[A60.0 127.0 31.0
> # head -1l /proc/sys/dev/sensors/as99127f-i2c-0-2d/temp2
> ^[[A60.0 50.0 22.0
> # head -1l /proc/sys/dev/sensors/as99127f-i2c-0-2d/temp3
> 60.0 50.0 112.2
>
> The strange part is the "temp2" value wich looks completely diffirent.
>
> also, this it my loaded modules:
> lsmod
> Module                  Size  Used by    Not tainted
> w83781d                22768   0
> i2c-proc                9232   1  [w83781d]
> i2c-dev                 5764   0
> i2c-piix4               5260   0
> dmi_scan                2564   0  [i2c-piix4]
> i2c-core               19236   0  [w83781d i2c-proc i2c-dev i2c-piix4]
> 3c59x                  30704   1
> iptable_filter          2412   0  (autoclean) (unused)
> ip_tables              15096   1  [iptable_filter]
> microcode               4668   0  (autoclean)
> mousedev                5588   0  (unused)
> keybdev                 2976   0  (unused)
> hid                    22340   0  (unused)
> input                   5920   0  [mousedev keybdev hid]
> usb-uhci               26412   0  (unused)
> usbcore                78944   1  [hid usb-uhci]
> ext3                   70880   7
> jbd                    51988   7  [ext3]
>
>
> Also, i used the detect function to help me find the right sensor.
>
> Driver `w83781d' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus PIIX4 adapter at e800' (Non-I2C SMBus adapter)
>     Busdriver `i2c-piix4', I2C address 0x2d (and 0x48 0x49)
>     Chip `Asus AS99127F' (confidence: 8)
>
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
>
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-piix4
> # I2C chip drivers
> modprobe w83781d
> # sleep 2 # optional
> /usr/local/bin/sensors -s # recommended
> #----cut here----
>
>
>
> Hope this is all the information you need to help me out with this
strange
> bug.
> I use Red Hat 8 with 2.4.20-18.8
>
>
> Kind regards
>
> H?kon.
>
>



