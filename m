From: lists@sk2.org (Stephen Kitt)
Date: Sun, 06 Nov 2005 22:45:24 +0000
Subject: [lm-sensors] reset=1 required for PWM control on Asus P4P800 Deluxe
Message-Id: <20051106224429.533f13b7@heffalump.sk2.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've been using fancontrol for a while to control my CPU fan. I'm using an
Asus P4P800 Deluxe board with a W83627THF controller which has PWM2 wired to
control the CPU fan (there are two other headers on the board, but they only
report the fan speed, their PWM isn't connected).

I switched to 2.6.14 yesterday and noticed today that the CPU fan was stuck
at the speed the BIOS cruise control left it at before the w83627hf module
was loaded. Changing the PWM value via /sys/bus/i2c/devices/.../pwm2 had no
effect. Loading the module with reset=1 fixed things, and I noticed in my
logs the request to report its usefulness. I compared the code from 2.6.13 to
2.6.14 and saw the change (and the comment!).

So here's a reason why it's needed ;-)

I hope this is useful; if you need more info, please cc me, I'm not
subscribed to the list.

Regards,

Stephen Kitt
