From: mike808@users.sourceforge.net (mike808)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: RH 7.3 /etc/rc.d/init.d/sensors
Message-Id: <200206220315.11079.mike808@users.sourceforge.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I've integrated 'sensors' into my RH 7.3 startups in /etc/rc.d/init.d.

I'm attaching my current sensors script and the related=20
/etc/sysconfig/sensors.

I've got a Asus K7M (Athlon/650) motherboard.
sensors-detect picks up a w83782d (loads the w83781d driver and a via686a.
However, the via doesn't ever display anything.

It's also picking up my monitor with the DDCMON driver (which is kind of ne=
at)=20
because I have a Matrox G400-TV video card.

Also, lots of your links are broken (link rot) or they do not point to the =

"real" www2 server URL.

Mike808/
--=20
() Join the ASCII ribbon campaign against HTML email and Microsoft-specific
/\ attachments. If I wanted to read HTML, I would have visited your website!
Support open standards.
-------------- next part --------------
# This is /etc/sysconfig/sensors.
#
# sensors is used for monitoring motherboard sensor values.
#
# See also the lm_sensors homepage at:
#     http://www2.lm-sensors.nu/~lm78/index.html
#
# This file is used by /etc/rc.d/init.d/sensors and defines the modules to =
be=20
# loaded/unloaded. This file is sourced into /etc/rc.d/init.d/sensors.

# The format of this file is a shell script that simply defines the modules=
=20
# in order as normal variables with the special names:=20
#    MODULE_1, MODULE_2, MODULE_3, etc.

#
# List the modules that are to be loaded for your system
# Adapted from results of running /usr/sbin/sensors-detect
#
# Mine said (I have an ASUS K7M motherboard):
#
# #----cut here----
# # I2C adapter drivers
# modprobe i2c-matroxfb
# # modprobe unknown adapter MAVEN:fb0 on i2c-matroxfb using Bit-shift algo=
rithm
# # modprobe unknown adapter MAVEN:fb0 on i2c-matroxfb using Bit-shift algo=
rithm
# modprobe i2c-isa
# # I2C chip drivers
# modprobe ddcmon
# modprobe w83781d
# modprobe via686a
# #----cut here----
#
# Here is my module list
MODULE_1=3Di2c-matroxfb
MODULE_2=3Di2c-isa
MODULE_3=DDcmon
MODULE_4=3Dw83781d
MODULE_5=3Dvia686a
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors
Type: application/x-shellscript
Size: 2243 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020622=
/8477effc/sensors.bin
