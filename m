From: pjkonweb@gmail.com (Prakash J K)
Date: Tue, 05 Sep 2006 23:32:12 +0000
Subject: [lm-sensors] lm_sensors trigger pc buzzer beeping continuously
Message-Id: <5251aaf50609051620r683eb75fm95d738c444ff86da@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello all,
i use a gigabyte mobo(GA-8I915GV-MF)with i915GV chipset and only CPU
temperature sensor available.it shows CPU temp correctly.now i configure it
with`sensors-detect` and it detected driver `it87'.the problem is during
booting itself after sometime it triggers PC beeping continuously.am quoting
results below.
Driver `it87' (should be inserted):
Detects correctly:
* ISA bus address 0x0290 (Busdriver `i2c-isa')
Chip `ITE 8712F Super IO Sensors' (confidence: 9)
To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe it87
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
now one think i noticed is `sensors` gave all o/p along with CPU
temp(correctly)~33degrees and the non-existent M/B temp as -55 and temp3 as
-12degrees.
so i disabled those temps by ignore temp1 and temp3 and ran `sensors -s`.no
luxk yet as still beeps.help me ppl,it really hurts this beeping pals.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/a6a20532/attachment.html 
