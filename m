From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 11 Jul 2006 18:33:33 +0000
Subject: [lm-sensors] 18-rc1-mm1  and unchecked return-codes
Message-Id: <44B3EEFD.5050209@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


from the 18-rc1-mm1 announcement:

- We're getting a relatively large number of crash reports coming out of the
  core sysfs/kobject/driver/bus code, and they're all really hard to diagnose.

  I am suspecting that what's happening is that some registration functions
  are failing and the caller is ignoring that failure.  The code proceeds and
  crashes much later, in obscure ways.

  All these functions return error codes, and we're not checking them.  We
  should.  So there's a patch which marks all these things as __must_check,
  which causes around 1,500 new warnings.

  These are all bugs and they all need to be fixed.



Many of these 1500 are from lm-sensors modules;
for example - a single function - device_create_file(),
is called 1027 times, and 'every' one is a void context return.

     grep device_create_file drivers/hwmon/*.c

So, what kinds of errors are possible here ?
and what should we do if they occur ?
does it ever happen that only 1 create fails ? 
do/would we care ? (not currently)

These Qs are somewhat rhetorical, theyre at least a heads-up.

FWIW, device_remove_file() is only called 9 times.
This doesnt seem to be a problem though, or we'd have heard it by now.
Specifically - hwmon/pc87360 appears to clean up after itself,
(or rather sysfs core code does), without any calls to device_remove_file()

soekris:/sys/bus/i2c/devices# ls
9191-6620@
soekris:/sys/bus/i2c/devices# rmmod pc87360
soekris:/sys/bus/i2c/devices# ls
soekris:/sys/bus/i2c/devices#


Ive gone ahead and worked up a patch against pc87360 to
count-errors-and-warn, which should suffice, at least for short term.

thanks
-jimc

