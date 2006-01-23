From: ps@ucw.cz (Sanda Pavel)
Date: Mon, 23 Jan 2006 18:49:12 +0000
Subject: [lm-sensors] kacpid vs sensors and fan problem
Message-Id: <20060123184912.GA25092@atrey.karlin.mff.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi,

i have tried to run acpi and sensors on asus m6va notebook,
but i have come accross problems im not able to solve.

sensors-detect found i2c-i801 bus and lm85 and eeprom chips.
i can probe all kernel modules without difficulty, sensors
seem to work as far as statistics concerned.

first problem starts, when boot initscript tries to intialize
sensors - kacpid kernel module takes 99% CPU and stick to this
usage. i found, this happens whenever "sensors -s" is executed.
when i switched off initialization (INITSENSORS=no), notebook
boots without difficulty.

second problem is, that i can't setup fans, although i can read
their current state. when i run pwmconfig, there are errors such as: 
   
   0-002d/pwm1
   /usr/sbin/pwmconfig: line 102: 0-002d/pwm1_enable: Permission denied

can be this problem caused by skipping sensors initialization ?

i tried to change permissions and write directly some values to pwm files
in sys/bus/i2c/drivers/lm85/0-002d, but without success.
i have tried 2.6.12/15/16 kernels, using 2.9.2 sensors.
i filed kacpid bug #5872 in kernel bugzilla, where i put additional log-attachments
few weeks ago.

have anybody idea whats wrong ?

pavel

