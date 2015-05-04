From: Rodrigo Wezher <rodrigo.wezher@fluidolabs.com>
Date: Mon, 04 May 2015 15:37:09 +0000
Subject: [lm-sensors] [PATCH] fancontrol: syslog flooded by error messages.
Message-Id: <CAHbfunW_O=KQiOX4dD2O9kuBqkoafWm7ijMOrqa957+PJsgzZg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is an error at this line:
http://lm-sensors.org/browser/lm-sensors/trunk/prog/pwm/fancontrol?revb55#L544

Bug reported at:
https://launchpad.net/~debianbug

Fix by: Mac_Weber

Replace:
if [ $pwmpval -eq 0 -o $min_fanval -eq 0 ]
By:
if [ "${pwmpval} -eq 0 -o ${min_fanval} -eq 0" ]


Without this fix the file /var/log/syslog gets flooded by error messages.
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
