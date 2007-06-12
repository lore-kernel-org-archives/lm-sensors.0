From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Tue, 12 Jun 2007 17:29:42 +0000
Subject: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5979624303403543916=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5979624303403543916==
Content-Type: multipart/alternative; boundary="0-1426477169-1181669382=:79319"
Content-Transfer-Encoding: 8bit

--0-1426477169-1181669382=:79319
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello

First of all, thanks to all for developing such a useful tool.

Now to my problem, I'm using an AOpen XC Cube (ex18), sensors-detect shows =
that a have to use the module f75375s, i install it using the driver develo=
ped by Riku Voipio, posted may 22.=20
Using w83627hf don't show any fan-speed or temperature, voltage seems to be=
 ok.

I try to integrate the driver in lm-sensors, but now i'm confused how to ge=
t lm-sensors (svn- version) working with this chip. Could someone give me a=
 hint. Maybe somone else is testing it too and could send me his version of=
 lm-sensors or could publish his configuration/files.

It would also be helpfull if somone only gives an example of an driver whic=
h is similar to f75375s.

Is it correct that i have to update lib/chips.c, lib/chips.h and prog/senso=
rs/chip.h, prog/sensors/chip.c and prog/sensors/main.c? What functions are =
needed and so on.

The module is recognized by 'sensors-detect' but i'm not able to get an out=
put running 'sensors', because the needed functions, structs and defines ar=
e mostly not correct.

many thanks
christian.
=20
 __________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden Schut=
z gegen Massenmails.=20
http://mail.yahoo.com=20
--0-1426477169-1181669382=:79319
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello<br><br>First of all, thanks to all for developing such a useful tool.=
<br><br>Now to my problem, I'm using an AOpen XC Cube (ex18), sensors-detec=
t shows that a have to use the module f75375s, i install it using the drive=
r developed by Riku Voipio, posted may 22. <br>Using w83627hf don't show an=
y fan-speed or temperature, voltage seems to be ok.<br><br>I try to integra=
te the driver in lm-sensors, but now i'm confused how to get lm-sensors (sv=
n- version) working with this chip. Could someone give me a hint. Maybe som=
one else is testing it too and could send me his version of lm-sensors or c=
ould publish his configuration/files.<br><br>It would also be helpfull if s=
omone only gives an example of an driver which is similar to f75375s.<br><b=
r>Is it correct that i have to update lib/chips.c, lib/chips.h and prog/sen=
sors/chip.h, prog/sensors/chip.c and prog/sensors/main.c? What functions ar=
e needed and so on.<br><br>The module is recognized by 'sensors-detect' but=
 i'm not able
 to get an output running 'sensors', because the needed functions, structs =
and defines are mostly not correct.<br><br>many thanks<br>christian.<br> <p=
>&#32;__________________________________________________<br>Do You Yahoo!?<=
br>Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden Sc=
hutz gegen Massenmails. <br>http://mail.yahoo.com=20
--0-1426477169-1181669382=:79319--


--===============5979624303403543916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5979624303403543916==--
