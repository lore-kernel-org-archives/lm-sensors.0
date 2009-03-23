From: "Ghent.Debian" <ghent.debian@gmail.com>
Date: Mon, 23 Mar 2009 17:47:22 +0000
Subject: [lm-sensors] A bug ? and a question.
Message-Id: <49C7CB2A.2050200@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm on Debian squeeze with lm-sensors 3.1.0. And a motherbord Asus P5Q 
Deluxe.

Fisrt : a bug ?
In my motherboard, one pwm control 2 fans (3, if I have the maximum 
number of fans). So, in the file "/etc/fancontrol", pwconfig has 
indicated "FCFANS= 
hwmon2/device/pwm2=hwmon2/device/fan4_input+hwmon2/device/fan2_input". 
But with the 2 fans, fancontrol does'nt OK. If I indicate only one fan 
(for example : "FCFANS= hwmon2/device/pwm2=hwmon2/device/fan4_input") 
It's no problem.

Second :
I would like that fancontrol control my fans according to several 
temperatures (example : the same fan for my hard disk and my CPU (it's a 
fan case, but my CPU have a passif cooling)). I have a solution for do 
that ?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
