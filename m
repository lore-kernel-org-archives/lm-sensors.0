From: dhaab@gpengineering.com (Dan Haab)
Date: Tue, 25 Jul 2006 19:56:27 +0000
Subject: [lm-sensors] no sensors found on Intel se7230 server board
Message-Id: <001601c6b024$6a6ae760$3f01a8c0@haab>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an Intel SE7230 server board that has (at least) the following
sensors on it:  Philips NE916 and National PC8375.  However I am having no
luck in getting lm_sensors to recognize these devices.  After following the
QUICKSTART as well as reading the INSTALL I cannot figure out why this would
be.  I would like to be able to at least scan the I2C bus for devices but
the address that shows up when I run 'i2cdetect' appears to be out of the
valid range:

Installed I2C busses:
I2c-0	smbus	SMBus I801 adapter at 3000	Non-I2C SMBus adapter

I am sure that lm_sensors should work with this motherboard as Intel uses
lm_sensors as part of its Server Manager software for linux.

I am running lm_sensors-2.10.0 on RHEL 3 update 7.

Thanks


