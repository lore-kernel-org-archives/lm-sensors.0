From: Nebojsa Trpkovic <trx.lists@gmail.com>
Date: Thu, 28 Jan 2010 19:52:57 +0000
Subject: [lm-sensors] monitoring multiple sensors, setting one PWM
Message-Id: <4B61EB19.1010700@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.

I have Asus P5Q Premium mobo. It has 5 fan headers:
1x CPU FAN
3x Chassis FAN
1x Power FAN

CPU FAN is controled by BIOS and cannot be controled by lm_sensors.
Chassis FANs can be conntroled by changing pwm, but echoing value in
pwm2 changes ALL 3 Chassis FANs.
Power FAN cannot be controled.

So, I've connected both CPU and system FAN to Chassis FAN headers.
Using lm_sensors and fancontrol, I was able to make config file that
would monitor just one temperature and set all fans accordingly.

I wanted to monitor both Motherboard and CPU temperature, so I've made
changes to fancontrol script. It is not pretty, it isn't useable for
general population and _it_controls_just_one_pwm_, but I still decided
to post it here just in case someone needs something similar.

What I've done:
1. removed setting of pwm at the end of the loop in function UpdateFanSpeeds
2. added one variable to "remember" biggest pwm calculated during all
runs through the loop
3. set the biggest value to pwm output once we've finished all runs
through the loop


###########################################################
--- fancontrol.original 2010-01-28 20:13:18.837213507 +0100
+++ fancontrol.v0.1     2010-01-28 20:13:46.227212974 +0100
@@ -254,6 +254,7 @@
 # main function
 function UpdateFanSpeeds {
        let fcvcount=0
+       let biggestpwm=0
        while (( $fcvcount < ${#AFCPWM[@]} )) # go through all pwm outputs
        do
                #hopefully shorter vars will improve readability:
@@ -326,18 +327,21 @@
                        wait $!
                  fi
                fi
-               echo $pwmval > $pwmo # write new value to pwm output
-               if [ $? -ne 0 ]
-               then
-                       echo "Error writing PWM value to $DIR/$pwmo"
-                       restorefans 1
-               fi
-               if [ "$DEBUG" != "" ]
-               then
-                       echo "new pwmval=$pwmval"
+               if (( $biggestpwm < $pwmval ))
+                   then biggestpwm=$pwmval
                fi
                let fcvcount=$fcvcount+1
        done
+       echo $biggestpwm > ${AFCPWM[0]} # write the biggest pwm value to
pwm output
+       if [ $? -ne 0 ]
+       then
+               echo "Error writing PWM value to $DIR/$pwmo"
+               restorefans 1
+       fi
+       if [ "$DEBUG" != "" ]
+       then
+               echo "new pwmval=$biggestpwm"
+       fi
 }

 echo 'Enabling PWM on fans...'


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
