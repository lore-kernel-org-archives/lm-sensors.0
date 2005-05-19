From: unknownnumber123@yahoo.com (bla bla)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: pwmconfig for winbond sensors chip not working
Message-Id: <20050122170453.83751.qmail@web61305.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i have a winbond sensors chip that gives readings
through lmsensors, but the pwm controls do not work

i am using kernel 2.4.28

lsmod:
w83627hf               13044   0
i2c-isa                  784   0  (unused)
i2c-proc                6180   0  [w83627hf]
i2c-dev                 3424   0  (unused)
i2c-core               14852   0  [w83627hf i2c-isa
i2c-proc i2c-dev]
ide-scsi                9840   0


output of pwmconfig:
Found the following PWM controls:
   w83627hf-isa-0290/pwm1
   w83627hf-isa-0290/pwm2

Found the following fan sensors:
   w83627hf-isa-0290/fan1     current speed: 0 ...
skipping!
   w83627hf-isa-0290/fan2     current speed: 0 ...
skipping!
   w83627hf-isa-0290/fan3     current speed: 3708 RPM

Warning!!! This program will stop your fans, one at a
time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control w83627hf-isa-0290/pwm1 ...
  w83627hf-isa-0290/fan3 ... speed was 3708 now 3708
    no correlation

No correlations were detected.
There is either no fan connected to the output of
w83627hf-isa-0290/pwm1,
or the connected fan has no rpm-signal connected to
one of
the tested fan sensors. (Note: not all motherboards
have
the pwm outputs connected to the fan connectors,
check out the hardware database on
http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test
(n)?

Testing pwm control w83627hf-isa-0290/pwm2 ...
  w83627hf-isa-0290/fan3 ... speed was 3708 now 3668
    no correlation

No correlations were detected.
There is either no fan connected to the output of
w83627hf-isa-0290/pwm2,
or the connected fan has no rpm-signal connected to
one of
the tested fan sensors. (Note: not all motherboards
have
the pwm outputs connected to the fan connectors,
check out the hardware database on
http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test
(n)?

Testing is complete.
Please verify that all fans have returned to their
normal speed.

The fancontrol script can automatically respond to
temperature changes
of your system by changing fanspeeds.
Do you want to set up its configuration file now (y)?
n

manually echoing differing pwm values into the proc
entries doesn't change the fan speeed either

is fan control supported on this chip?


	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail
