From: Domenico Andreoli <domenico.andreoli@linux.com>
Date: Sun, 25 Oct 2020 09:45:20 +0000
Subject: Configuring PWM sysfs entries
Message-Id: <20201025094520.GA848@dumbo>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm using fancontrol on a NanoPi M4 having a PWM controlled fan.

This is the configuration I'm using:

INTERVAL=10
FCTEMPS=/sys/class/pwm/pwmchip1/pwm0/duty_cycle=/sys/class/hwmon/hwmon1/temp1_input
MINTEMP=/sys/class/pwm/pwmchip1/pwm0/duty_cycle=45
MAXTEMP=/sys/class/pwm/pwmchip1/pwm0/duty_cycle=70
MINSTART=/sys/class/pwm/pwmchip1/pwm0/duty_cycle=1500000
MINSTOP=/sys/class/pwm/pwmchip1/pwm0/duty_cycle=1500000
MAXPWM=/sys/class/pwm/pwmchip1/pwm0/duty_cycle=10000000

This is effective only after sysfs has been configured:

PWM=0
CHIP=1
POLARITY=normal
PERIOD=10000000

echo $PWM > /sys/class/pwm/pwmchip$CHIP/export
echo $PERIOD > /sys/class/pwm/pwmchip$CHIP/pwm$PWM/period
echo $POLARITY > /sys/class/pwm/pwmchip$CHIP/pwm$PWM/polarity
echo 1 > /sys/class/pwm/pwmchip$CHIP/pwm$PWM/enable

Additional caveat, fancontrol accepts PWM values up to 255 while my
configuration works iff such value is 1500000. Therefore I have to
comment out the max PWM value check in the fancontrol script.

Is this the best way to achieve the result?

Would you accept a patch to improve fancontrol and handle this situation
in a nicer way?

Kind regards,
Domenico

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
