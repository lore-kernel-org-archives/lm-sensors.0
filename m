From: rutger@nospam.com (Rutger Nijlunsing)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: w83627hf driver: one pwm value, two fan speeds?
Message-Id: <20050306230902.GA17472@nospam.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

While trying to control the CPU temperature with the fan speed on a
P4P800 motherboard + P4 CPU with the w83627hf driver (kernel
2.6.11-rc4) just like Asus's Q-Fan (see http://www.wingding.demon.nl/
for qfan.rb), I encountered a strange effect.

Doing

cd /sys/devices/platform/i2c-1/1-0290
echo 240 > pwm2
sleep 1
echo 192 > pwm2

.will stabilize at a fanspeed of around 3229, while changing the 240
to 128 will give a fanspeed of around 2136.

Somehow a 'state' is kept somewhere, or the driver has a bug. Is this
a known bug?

Regards,
Rutger.

-- 
Rutger Nijlunsing ----------------------------------------------------
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
