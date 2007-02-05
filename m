From: nick.upson@gmail.com (Nick Upson)
Date: Mon, 05 Feb 2007 16:56:09 +0000
Subject: [lm-sensors] install problem
Message-Id: <36ba31bd0702050856p43e34277se02078d9815328c8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I get "Can't access procfs/sysfs file" upon running sensors. I'm using
fedora core 5 which is a 2.6.16 core. sensors-detect seems to work ok
and produces output that I have used for the modprobe commands below.
I read every reference I could find but none seem to apply/fix the
issue. I've used both the tar.gz and rpm with the same effect, both
2.10.2

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-sis96x
modprobe i2c-isa
# Chip drivers
modprobe eeprom
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

