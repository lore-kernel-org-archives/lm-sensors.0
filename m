From: Pelle Svensson <pelle2004@hotmail.com>
Date: Sat, 29 Dec 2007 17:50:16 +0000
Subject: [lm-sensors] PWM control on Asus P4C800-E Delux dosen't work for
Message-Id: <BAY143-W26588A0C37D226CBFA5FECB9560@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi,

Installed fan control on Ubuntu 7.1 according to http://ubuntuguide.org/wik=
i/Ubuntu:Feisty#How_to_detect_CPU_temperature.2C_fan_speeds_and_voltages_.2=
8lm-sensors.29

CPU fan works nicely but chassi fan runs at full speed.=20
pwmconfig detects following:

hwmon0/device is w83627th

hwmon0/device/pwm1
hwmon0/device/pwm2
hwmon0/device/pwm3

hwmon0/device/fan1_input  current speed: 1205 RPM
hwmon0/device/fan2_input  current speed: 2700 RPM
hwmon0/device/fan3_input  current speed: 0 ... skipping

Testing pwm control hwmon0/device/pwm1  ---> no correlation
Testing pwm control hwmon0/device/pwm2  ---> hwmon0/device/fan2_input=20
Testing pwm control hwmon0/device/pwm3  ---> no correlation

Can I control the speed of the chassi fan with pwm1 or pwm3 on this ASUS P4=
C800 board.

/Pelle




_________________________________________________________________
Ladda ner hela Windows Live gratis och uppt=E4ck f=F6rdelarna!
http://get.live.com/=20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
