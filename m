From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 19 Aug 2005 19:09:28 +0000
Subject: [lm-sensors] fancontrol wouldn't start
Message-Id: <43061235.4080904@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200508180300.11628.alex@asyring.homeip.net>
In-Reply-To: <200508180300.11628.alex@asyring.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

To Alex:

You seem to hit an issue. If you want to allow the fans regulate itselfs according the temp you can
use capabilities of the chip itself and you dont need the fancontrol script at all.

Please consult the lm85 file in Documentation/hwmon or Documentation/i2c/chips of your kernel sources.
(use commands like echo and cat to write/read values)
If you have any other trouble with this automatic *chip* stuff let us now. In meanwhile we will try to solve
the fancontrol issue with others.

To rest of developers:

> -r--r--r--  1 root root    0 2005-08-18 02:49 /sys/bus/i2c/devices/0-002e/pwm1_enable
Maybe the script are trying to write something in it and get confused because it is read only.

Our specs want this file RW.

pwm[1-3]_enable
                Switch PWM on and off.
                Not always present even if fan*_pwm is.
                0 to turn off
                1 to turn on in manual mode
                2 to turn on in automatic mode
                Read/Write

Current implementation:

  return sprintf(buf,"%d\n", (pwm_zone != 0 && pwm_zone != -1) );

/* Since we can't use strings, I'm abusing these numbers
 *   to stand in for the following meanings:
 *      1 -- PWM responds to Zone 1
 *      2 -- PWM responds to Zone 2
 *      3 -- PWM responds to Zone 3
 *     23 -- PWM responds to the higher temp of Zone 2 or 3
 *    123 -- PWM responds to highest of Zone 1, 2, or 3
 *      0 -- PWM is always at 0% (ie, off)
 *     -1 -- PWM is always at 100%
 *     -2 -- PWM responds to manual control
 */

So it  returns 0 when is off or running fullspeed.

My proposal:

Allow to change to 0,1,2

0 -> write to corresponding zone -1 (fan will run at full speed)
1 -> write to corresponding zone -2 (fan esponds to manual control)

Document the fact that automatic mode can be reenabled via writing to the pwm#_auto_channels

Any one else has some other idea?

Regards
Rudolf

