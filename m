From: den_tichel@zonnet.nl (Jan van Tiggelen)
Date: Tue, 27 Feb 2007 22:04:11 +0000
Subject: [lm-sensors] SMSC47m1 Error inserting and Not configured - will not
Message-Id: <20070227220412.7D6195920@mta-fe.casema.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The issue's been bugging me for a few days, but nevertheless I hope this is
an issue which can be sorted out. So here goes with the details:

FSC micro-atx mainboard (W26361-W39) with an SMC LPC47M107S-MC onboard (I
physically checked the presence! ;) )
 
Installed Fedora Core 6
2.6.19-1.2911.fc6 
i686 i686 i386 GNU/Linux

Sensors version 2.10.1 with libsensors version 2.10.1

Sensors-detect returns (as it seems) the proper values:
modprobe.conf:
# I2C module options
alias char-major-89 i2c-dev

rc.local:
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe smsc47m1
sleep 2 # optional
/usr/bin/sensors -s # recommended

Everything seems to load properly:
# lsmod |grep i2c
i2c_isa                 9665  0
i2c_ec                  9281  1 sbs
i2c_i810                9797  0
i2c_algo_bit           12105  1 i2c_i810
i2c_i801               11853  0
i2c_core               26049  5 i2c_isa,eeprom,i2c_ec,i2c_algo_bit,i2c_i801

But modprobe smsc47m1 seems to cause the initial error: 
FATAL: Error inserting smsc47m1
(/lib/modules/2.6.19-1.2911.fc6/kernel/drivers/hwmon/smsc47m1.ko): No such
device

And dmesg returns:
smsc47m1: Found SMSC LPC47M10x/LPC47M112/LPC47M13x
i2c_adapter i2c-9191: Device at 0x800 is not configured, will not use

Some history I could find on a similar issue is:
http://www-gatago.com/linux/kernel/14705857.html

But it doesn't really give me a clue on how to resolve this. So any help
would be appreciated.

Just FYI:
- I have disabled ALL serial/parallel ports in BIOS
- ACPI/APM in BIOS is ENABLED
- I did not make any changes to the original /etc/sensors.conf

Kind regards,

Jan van Tiggelen



