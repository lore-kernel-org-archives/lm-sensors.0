From: "dave jones" <s.dave.jones@gmail.com>
Date: Fri, 17 Aug 2007 11:44:36 +0000
Subject: [lm-sensors] Questions about sysfs
Message-Id: <5628d8010708170444i76bdc033t900cec37a726e2c1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm trying to use pwmconfig to verify whether my porting driver is
working or not.
While running pwmconfig, I got the following result:

Found the following PWM controls:
   0-002e/pwm1
/usr/sbin/pwmconfig: line 102: echo: write error: Invalid argument

Found the following fan sensors:
   0-002e/fan1_input     current speed: 6683 RPM
   0-002e/fan2_input     current speed: 6192 RPM

My question is why it displays 0-002e instead of hwmon0/devices ?
The second question is why pwmconfig cannot write value ?
In line 102 with pwmconfig is:

# $1 = pwm file name
function pwmdisable()
{
        if [ "$SYSFS" = "1" ]
        then
                echo $MAX > $1
                ENABLE=${1}_enable
                if [ -w $ENABLE ]
                then
                        echo 0 > $ENABLE          ---- line 102
                fi
        else
                echo $MAX 0 > $1
        fi
}

Would you tell me how to fix my driver? Thank you.

BR,
Dave.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
