From: Magnus Ekhall <koma@lysator.liu.se>
Date: Fri, 27 Apr 2007 17:18:34 +0000
Subject: [lm-sensors] No pwm with abituguru driver?
Message-Id: <4632306A.5010904@lysator.liu.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have an Abit Fatal1ty AN8 motherboard that in Windows uses uGuru to
read sensors and control fans.

In Ubuntu Linux I have tried lm_sensors with both the w83627hf driver
and the abituguru one.

The abituguru seems to be the most successful, I get temperatures and
fan speeds. However I cannot control the fan speed! (And this is what I
really want to do.)

In /sys/devices/platform/abituguru.224/ I have some files starting with
pwm1, for example pwm1_enable. But I cannot write to this "file" even as
root. I get an access denied.

And when I run pwmconfig I get:

/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed

What can I try to get pwm working? I think that there are at least 2
pwms on this MB.


sensors-detect report this:

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `k8temp' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `AMD K8 thermal sensors' (confidence: 9)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)





But using the winbond driver gives me a lot of crap sensor values...

Anyone know what I'm doing wrong?  How can I control the fans?

Thanks,

Magnus E

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
