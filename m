From: matej.obid@siol.net (Matej Obid)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: lm-sensors 2.8 serious bug
Message-Id: <1064705078.1960.10.camel@workstation.webdstom.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello!

I am a user of gentoo linux and I have just installed masked
lm-sensors-2.8.0 and i2c-2.8.0. After running sensors detect
which detected my chipset and sensors I ran it and it seriously crashed
linux after trying to load adm1021 module (the machine stopped
responding to anything so I had to turn it off completely, even the
reset button was not enough)
My system is running on ABIT NF7-S motherboard. (I dont know if this is
important information but I have AthlonXP 2100+ and Radeon 9600 Pro)
The modules that sensors-detect put in /etc/conf.d/lm_sensors are:
MODULE_0=3Di2c-nforce2
MODULE_1=3Di2c-isa
MODULE_2=ADm1021
MODULE_3=EEprom
MODULE_4=3Dw83781d

I hope that I helped somehow with this information.

