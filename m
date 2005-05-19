From: greguric@stud.uni-frankfurt.de (Tomislav Greguric)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: lm_sensor's ticket no. 839
Message-Id: <20020414203005.A702@greguric.stud.rz.uni-frankfurt.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello all,

I have an Asus A7A266-E motherboard, too, and would like to add my 2
cents to the problem described in ticket 839
<http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=839>:

1. the Asus A7A266-E uses an AS99127F for hardware monitoring
   (=3D> modprobe w83781d force_as99127f=3D0,0x2d)

2. the board uses the ALI M1535D+ South Bridge. I guess that some
   registers have moved or the initialization changed slightly
   compared to the plain M1535 chip, so this is probably the reason
   for the errors I and other owners of this board get:
   | [...] kernel: i2c-ali1535.o: Error: command never completed

Feel free to contact me for further questions or if I can help you in
any way!

Sincerely,
Tomislav
