From: Michael Vorburger <mike@vorburger.ch>
Date: Wed, 22 Jan 2014 14:43:20 +0000
Subject: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

On an Asus H87-PRO, running on Ubuntu 13.10, if, I'm getting
"/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed"
from "pwmconfig" [revision 5857 (2010-08-22]. I've tried
the acpi_enforce_resources=lax thing, which doesn't seem to help.
http://pastebin.com/Up6KFRyu has full log from sensors-detect.

Do I need any special drivers or other settings, for this motherboard? -
Thank you for any tips!

PS: Same also on
http://askubuntu.com/questions/408929/asus-h87-pro-usr-sbin-pwmconfig-there-are-no-pwm-capable-sensor-modules-instal
 ..
_______________________
Michael Vorburger
http://www.vorburger.ch
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
