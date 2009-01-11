From: Jens Gottstein <ruena@web.de>
Date: Sun, 11 Jan 2009 20:44:19 +0000
Subject: [lm-sensors] "echo 0 > pwm2" does NOT stop fan
Message-Id: <676459746@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi there,

since many years I use fancontrol on many systems - its a great software - =
thanks a lot.

On my new system it does not stop my CPU-fan - just slows the fan down.

I have a ASUS p5k-v with a w83627ehf, Ubuntu 8.10 (and 8.04) with a intel b=
oxed fan (4-pins on the cable to the fan),=20

uname -a :=20
 Linux 2.6.27-9-generic SMP Thu Nov 20 21:57:00 UTC 2008 i686 GNU/Linux

I did:=20
cd /sys/devices/platform/w83627ehf.656/
echo 255 > pwm2=20
The fan is at full speed (cat fan2_input yields 2556)

echo 0 > pwm2
The fan does NOT stop, it just goes slow (cat fan2_input yields 1010)

pwmconfig and fancontrol have the same problem.

How can I stop the fan completely?

I also tried the "Thermal Cruise mode", but this does not stop the fan, too.


The content of the files in  /sys/devices/platform/w83627ehf.656/

cat pwm2: 0
cat pwm2_enable: 1
cat pwm2_min_output: 1
cat pwm2_mode: 1
cat pwm2_stop_time: 1000
cat pwm2_target: 60000
cat pwm2_tolerance: 10000

I am looking forward to your answers

Thanks in advance

ruena





_______________________________________________________________________
Sensationsangebot verl=E4ngert: WEB.DE FreeDSL - Telefonanschluss + DSL
f=FCr nur 16,37 Euro/mtl.!* http://dsl.web.de/?ac=3DOM.AD.AD008K15039B7069a


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
