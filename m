From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Pre-release tests
Message-Id: <20030707213700.3eef7104.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I've finished testing I2C and LM Sensors CVS on three out of my four
systems (last is left for tomorrow) and here is my report:

1* We'll have trouble with i2c bus drivers from outside our package.
Those who won't load at all aren't the main problem IMHO (we'll just get
dozens of complaints stating that since the user installed I2C 2.8.0,
his/her video card doesn't work anymore). The real problem is those who
still load but crash upon scanning. I have old Matrox video cards in two
of my machines, and sensors-detect says I should load i2c-matroxfb. The
module loads properly, but sensors-detect crashes as soon as it tries to
scan this device. What's more, any subsequent load of a chip driver will
crash too (because this will scan all I2C busses, including
i2c-matroxfb).

So, what can we do? The very least we can do is add a BIG WARNING on our
news page at the time we release, stating that any other I2C-related
module (most of which are video-related) should not be loaded anymore
after I2C 2.8.0 is installed. The message would explain that we plan to
submit a patch to the Linux kernel so that all devices are back with the
next Linux version. A second thing I'd suggest is commenting out in
sensors-detect all such devices. I now it sounds crazy because we'll
have to reenable them right after the release, but I think that if we
don't do that, we'll have hundreds of people complaining about system
crashes. Remember that FB modules, such as i2c-matroxfb, cannot be
unloaded. So, loading the module from sensors-detect while the user
never used it before, then crashing the system and finally give him/her
no other choice but to reboot probably won't make the user happy.

2* We should warn the user that /etc/sensors.conf never gets
overwritten. I agree that we shouldn't overwrite it, but the user should
be told about this, so that he/she can copy and edit the new file if
he/she wants.

3* At the end of sensors-detect, we should tell the user to run the
commands he/she is told to add to /etc/rc.*. Two reasons for that.
First, he/she can make sure it works well before editing his/her init
scripts. Second, he/she can use sensors right away, without having to
restart the system or run the init scripts by himself/herself. I had
users complaining that sensors wouldn't work right after sensors-detect
being ran.

4* What's that "sleep 3" sensors-detect suggests adding between modules
load and sensors -s? I have no sleep between these two steps in my own
scripts, and I never had any problem. I would replace this block:
  # Next 2 lines are optional
  sleep 3
 /usr/local/bin/sensors -s
with this one:
  # sleep 2 # optional
  /usr/local/bin/sensors -s # recommended
It should work for most people. Waiting for 3 seconds can represent 5 or
10% of the total boot time! Too much for what it's worth IMHO.

5* The "you must run ldconfig" message at the end of a lm_sensors2's
make install still doesn't please me. I'd replace "libsensors.so*" by
"libsensors.so.2" (well, the file name as it actually is), or I fear the
users won't understand why we say there were no libsensors ever in
/usr/local/lib, while there may be.

This five points can be left to me, but I want to hear you about them
before I do anything.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
