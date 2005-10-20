From: P.Glassenbury@cosc.canterbury.ac.nz (Peter Glassenbury)
Date: Thu, 20 Oct 2005 03:47:39 +0000
Subject: [lm-sensors] lm-sensors in a rollout on FC4 - Attempts fail
Message-Id: <4356F706.20904@cosc.canterbury.ac.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,
I ran sensor-detect and everything just works - thanks for great utility.

I would like to roll out this to all our machines (around 250) via
the kickstart setup that we do. (onto about 5 variations of machine)
I tried to copy what I though were the config files but seemed to miss
something because I got no sensors until I ran sensor-detect.

There are two ways I suppose to fix this...

** 1 ** Is there a way to run the sensor-detect without prompts??
so I can just put it in the kickstart configuration files.

** 2 ** Less portable is to fix whatever step I missed in this
and have 5 varients for the different machines.

I copy the modules into /etc/sysconfig/lm_sensors
MODULE_0=3Di2c-viapro
MODULE_1=3Di2c-isa
MODULE_2=3Dlm75
MODULE_3=EEprom
MODULE_4=3Dsmbus-arp
MODULE_5=3Dw83627hf

/etc/modules.conf gets created with...
alias char-major-89 i2c-dev

then a /etc/init.d/lm_sensors restart
to modprobe them all....
No luck finding the sensors.

Run sensor-detect then all goes... arghhh what is missing

Can anyone suggest something?
Thanks
Pete

--=20
-------------------------------------------------------------------
Peter Glassenbury			Computer Science dept.
pete@cosc.canterbury.ac.nz		University of Canterbury
+64 3 3642987 ext 7762			New Zealand

