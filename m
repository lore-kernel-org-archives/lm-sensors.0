From: Daniel Spannbauer <ds@marco.de>
Date: Thu, 12 Jun 2008 09:18:00 +0000
Subject: [lm-sensors] lmsensors on Tyan S2932 with 2x Quadcore-Opteron
Message-Id: <4850E9C8.70205@marco.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

I've installed SuSE 10.2 on a Tyan S2932 with 2 Quadcore-Opterons on it.
Shipped with SuSE was Kernel 2.6.18 and  sensors 2.10.1.

sensors-detect was running, but when I run "sensors" there is the Message:

No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

According to /etc/sysconfig/lm_sensors the following Modules are loaded:
MODULE_0=3Di2c-nforce2
MODULE_1=3Dlm85
MODULE_2=EEprom


Can anybody help me to get sensors working?

Regards

Daniel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
