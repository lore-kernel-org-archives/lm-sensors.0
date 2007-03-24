From: sammy.spade@laposte.net (sammy.spade)
Date: Sat, 24 Mar 2007 11:26:07 +0000
Subject: [lm-sensors] mobo MS-6535 and fancontrol
Message-Id: <JFENRJ$D4AD128694E5AD94740BDDF8C312E623@laposte.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

As I did not found a way to post my report/query/quesion to a
lm-sensors forum, I send them to this mail address.

So I would like to report how I succeeded in making lm-sensors
to work with my pretty old PC, as well as to ask to improve
the lm-sensors package.

My PC is a MSI barebone called MS-6232 including the MSI
motherboard called MS-6535. You can find details in the manual
available in
http://www.msi.com.tw/program/support/download/dld/spt_dld_detail.php?UID4&kind=4
The barebone is small so the fans are too (one for the CPU,
two for the box). Without any software, they are managed by
the BIOS. They spin 6300-7000 rpm when the CPU temperature
reaches 57C and get slower to 2900-3400 rpm when the
temperature falls down to 44C. The problem is the normal
working temperature is around 50C. So once the fans are
triggered to the full speed, they run fast and are noisy for a
VERY long time.
The 2 fans speed seems to be very correlated. There are 3
possible speed states : low, medium, high.
I have not investigated to replace the CPU fan (calloducs are
magic), but I guess it is difficult to find one to fit to this
small box.
So it is VERY important to get lm-sensors to work ! The
encouraging thing was that the windows program SpeedFan works
fine.

I have not found any information through google concerning
lm-sensors working directly with this hardware, so it is why I
consider my post could interest some people.

My distro is Mandriva One 2007 installed on the harddrive.
I setup the package lm_sensors-2.10.0-5mdk but I did not
succeeded in making it to work, so I downloaded the latest
source package v2.10.2. I unpacked it the run the recommended
following commands for kernel 2.6.x:
make user
make user_install
But I noticed that installed scripts were not updated so I run
the following commands from the unpack directory with root
rights to do it :
cp ./prog/detect/sensors-detect	/usr/sbin/
cp ./prog/detect/i2cdetect	/usr/sbin/
cp ./prog/dump/i2cdump		/usr/sbin/
cp ./prog/dump/i2cget		/usr/sbin/
cp ./prog/dump/i2cset		/usr/sbin/
cp ./prog/dump/isadump		/usr/sbin/
cp ./prog/dump/isaset		/usr/sbin/
cp ./prog/init/lm_sensors.init	/etc/rc.d/init.d/lm_sensors
cp ./prog/pwm/fancontrol	/usr/sbin/
cp ./prog/pwm/pwmconfig		/usr/sbin/
cp ./prog/sensors/sensors	/usr/bin/

Then I run sensors-detect and the sensor W83697HF is detected.
The following recomendation is displayed :

/etc/modules.conf:
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:
#----cut here----
# I2C adapter drivers
modprobe i2c-sis96x
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

So I respected the recommendations and I put the "modprobe"
commands in /etc/rc.d/rc.local
Then I could read sensor value with the sensors command and
with ksensors.
But when I run pwmconfig, no correlation with fan speed was
detected.
After many tests, I found that the following manual commands
allowed the pwmconfig script to find a correlation :
modprobe -r w83627hf
modprobe w83627hf reset=1
Then the command fancontrol is effective to modify the fan speed.
So I modified /etc/rc.d/rc.local with adding the "reset=1".
But when I reboot, the fan speed is not managed by fancontrol.
So I noticed that the service lm_sensors is started. By
editing /etc/rc.d/init.d/lm_sensors I understood this service
consists in loading modules listed in
/etc/sysconfig/lm_sensors.conf and running the command sensors.
So modules were loaded once with service lm_sensors at
runlevel 3 then "reloaded" by /etc/rc.d/rc.local (that is run
after every other service runlevels). But the module w83627hf
were actually loaded once without the parameter "reset=1", so
the fancontrol was uneffective.
I deleted everything concerning lm-sensors in
/etc/rc.d/init.d/lm_sensors and added "reset=1" in
/etc/sysconfig/lm_sensors.conf. It did not work.

Finally I get fancontrol to work with doing :
- I modified the script /etc/rc.d/init.d/lm_sensors to load
explicitly (and dirtily) the module w83627hf with the
parameter "reset=1" after loading everything included in
/etc/sysconfig/lm_sensors.conf
- I deleted w83627hf in /etc/sysconfig/lm_sensors.conf
- I disabled the lm_sensors service in every runlevel in drakconf
- I created the file /etc/init.d/fancontrol as it is described
at http://www.ubuntuforums.org/showthread.php?tB737
and modified the file to make it to work in mandriva.
- I added the following commands in /etc/rc.d/rc.local:
service lm_sensors start
service fancontrol start
- I get a input error with fancontrol so I needed to modify
the file /etc/fancontrol:
INTERVAL
FCTEMPS=hwmon0/device/pwm1=hwmon0/device/temp2_input 
hwmon0/device/pwm2=hwmon0/device/temp2_input
FCFANS=hwmon0/device/pwm1= 
hwmon0/device/pwm2=hwmon0/device/fan1_input
MINTEMP=hwmon0/device/pwm1`  hwmon0/device/pwm2`
MAXTEMP=hwmon0/device/pwm1e  hwmon0/device/pwm2e
MINSTART=hwmon0/device/pwm1=5  hwmon0/device/pwm2=0
MINSTOP=hwmon0/device/pwm1=0  hwmon0/device/pwm2=0

To improve the package, my suggestion is:

- modify the install script to automatically update the
installed scripts 
- modify the recommendation not avoid double-load of modules
- modify the script ./prog/init/lm_sensors.init to make it
compatible with the syntax <module> <parameter> in
/etc/sysconfig/lm_sensors.conf

In order to get less noise earlier at the boot time, I tried
to move the lm_sensors and fancontrol services from
/etc/rc.d/rc.local to any previous runlevel. The result is
that temperatures are read, but fans are not controlled. So my
question is :
Is there any service that must be run before fancontrol ?

Kind Regards.

Cr?ez votre adresse ?lectronique prenom.nom at laposte.net 
1 Go d'espace de stockage, anti-spam et anti-virus int?gr?s.


