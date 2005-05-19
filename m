From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: sensors gives no useful output.
Message-Id: <20030806183452.4755ebf8.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 18:13:04 +0200
Jean Delvare <khali@linux-fr.org> wrote:


> Other addresses are abviously used by the eeprom and lm75 modules.
> Unload them (and dmasound_pmac again), and run sensors-detect again. You
> should see the same things you first saw. If you could log the whole
> thing, I'd like to take a look. You may use "script" to do that (run
> "script sensors-detect.log", then "sensors-detect", then "exit", and you
> have a nice logfile).
ok, done that. And followed the instructions of the 'sensors-detect' output. I did not ad the lines to /etc/rc.* as the lm75 and eeprom are already loaded at bootup.

My sensors output now is:
lm75-i2c-0-48
Adapter: uni-n 0
Algorithm: Keywest i2c
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

lm75-i2c-0-49
Adapter: uni-n 0
Algorithm: Keywest i2c
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

eeprom-i2c-0-50
Adapter: uni-n 0
Algorithm: Keywest i2c

lm75-i2c-1-48
Adapter: uni-n 1
Algorithm: Keywest i2c
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

lm75-i2c-1-49
Adapter: uni-n 1
Algorithm: Keywest i2c
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

eeprom-i2c-1-50
Adapter: uni-n 1
Algorithm: Keywest i2c

eeprom-i2c-2-56
Adapter: mac-io 0
Algorithm: Keywest i2c
Machine name:
Serial number:

Any hints to get some useful output?

Thanks for feedback.

Zeno
