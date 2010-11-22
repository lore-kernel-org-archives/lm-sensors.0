From: "Matthias Zacharias" <Matthias.Zacharias@bmk-solutions.de>
Date: Mon, 22 Nov 2010 09:24:18 +0000
Subject: [lm-sensors] Need help to fix some issues with the linux driver
Message-Id: <4CEA44D2020000AA00007F74@center.bmk-electronics.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1093183707339752129=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--===============1093183707339752129==
Content-Type: multipart/alternative; boundary="=__Part2A0781D2.2__="

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part2A0781D2.2__=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello mailing list,
=20
we have to use the linux driver =22i2c-gpio=22 because the =22i2c-at91=22 =
is
marked as =22BROKEN=22 and for our application it can as well not be used.
=20
Here a brief description of the application:
=20
AT91SAM9261 based embedded system running kernel 2.6.25.4, with Atmel
and our own BSP patches. This system uses both SPI interfaces, one USART
(for console),  MMC, Sound on SPI and SSC, digital poti for contrast
control and the an chip Frambuffer for a monochrome LCD (QVGA).
=20
On the TWI interface are attached:=20
    the AT24C04 SMB EEPROM,   (=40 0x50)
    two LM84 Temperature sensors  (=40 0x18, 0x19)
    and the Infrared temperature sensor MLX90614 manfactured by
MELEXIS. (=40 0x5A)
Note: The LM84 sensors are not yet operated by the linux kernel.
=20
Now the description of the issue we have with the I2C subsystem:
=20
1. the EEPROM is working fine with =22i2c-at91=22 and the =22i2c-gpio=22
modules
2. for IR-Sensor MLX90614, a hwmon class linux driver was implemented
by Linutronix on our demand. This driver works fine but delivers
sporadic the error message =22i2c-adapter i2c-0: sendbytes: NAK bailout.=22=
=20
(this message is thrown by the  =22i2c-algo-bit=22 driver), or invalid
temperature values ( near 0xFFFF). The invalid temperature values and as
well the error message appear as reponse on bus timeout situations which
are not correctly handled by the linux driver. This we find out using a
I2C analyzer. In our opinion these issues come while the i2c
communication is disturbed by other tasks and/or interrupt service
routines (ISR) which extend the SMB clock over the permitted timeouts,
leaving the IR-Sensor in an undefined or erroneous (
http://dict.leo.org/ende?lp=3Dende&p=3DCi4HO3kMAA&search=3Derroneous&trestr=
=3D0x8004
) state.
=20
The address mentioned in the driver source =22Haavard Skinnemoen
<hskinnemoen=40atmel.com>=22 invalid (unknown)
=20
Please let us now if somebody can help in fixing the i2c-gpio, or give
us an other name who can help.
=20
Thank you.
With best regards
=20
=20
Matthias Zacharias
Dipl.-Elektroingenieur (Univ)=20
Projektleiter Entwicklung=20



BMK professional electronics GmbH =C2=B7 Werner-von-Siemens-Str. 6 =C2=B7 =
D-86159
Augsburg
Tel: +49(0)821/20788-715=C2=B7 Fax: +49(0)821/20788-721=C2=B7 www.bmk-group=
de

--------------------
BMK electronic solutions GmbH
Werner-von-Siemens-Str. 6, Eingang 18 f
D-86159 Augsburg
Tel. +49 (0) 821 / 207 88 - 700
Fax +49 (0) 821 / 207 88 - 721
info=40bmk-solutions.de
Gesch=C3=A4ftsf=C3=BChrer: Dipl.-oec. Alois Kn=C3=B6ferle
Sitz: Augsburg
HR-Nr.: B21197
---------------------

Diese E-mail kann vertrauliche Informationen enthalten. Falls Sie diese
E-Mail irrt=C3=BCmlich erhalten haben, informieren Sie bitte unverz=C3=BCgl=
ich den
Absender und l=C3=B6schen Sie diese E-Mail von jedem Rechner, auch von den
Mailservern. Jede Verbreitung des Inhalts, auch die teilweise
Verbreitung, ist in diesem Fall untersagt. Au=C3=9Fer bei Vorsatz oder =
grober
Fahrl=C3=A4ssigkeit schliessen wir jegliche Haftung f=C3=BCr Verluste oder =
Sch=C3=A4den
aus, die durch Viren befallene Software oder E-Mails verursacht werden.

This e-mail may contain confidential information. If you received this
e-mail in error, please contact the sender and delete this e-mail from
your computer, including your mailservers. Any dissemination, even
partly, is prohibited. Except in case of gross negligence or wilful
misconduct we accept no liability for any loss or damage caused by
software or e-mail viruses.

--=__Part2A0781D2.2__=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<HTML><HEAD>
<META content=3D"text/html; charset=3Dutf-8" http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.18975"></HEAD>
<BODY style=3D"MARGIN: 4px 4px 1px; FONT: 10pt Microsoft Sans Serif">
<DIV>Hello mailing list,</DIV>
<DIV>&nbsp;</DIV>
<DIV>we have to use the linux driver "i2c-gpio" because the "i2c-at91" is =
marked as "BROKEN" and for our application it&nbsp;can as well not be =
used.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Here a brief description of the application:</DIV>
<DIV>&nbsp;</DIV>
<DIV>AT91SAM9261 based embedded system running kernel 2.6.25.4, with Atmel =
and our own BSP patches. This system uses both SPI interfaces, one USART =
(for console), &nbsp;MMC, Sound on&nbsp;SPI and SSC, digital&nbsp;poti&nbsp=
;for contrast control and the an chip Frambuffer for a monochrome LCD =
(QVGA).</DIV>
<DIV>&nbsp;</DIV>
<DIV>On the TWI interface are&nbsp;attached: </DIV>
<DIV>&nbsp;&nbsp;&nbsp; the AT24C04 SMB EEPROM,&nbsp;&nbsp; (@ 0x50)</DIV>
<DIV>&nbsp;&nbsp; &nbsp;two LM84 Temperature sensors&nbsp; (@ 0x18, =
0x19)</DIV>
<DIV>&nbsp;&nbsp;&nbsp; and the Infrared temperature sensor MLX90614 =
manfactured by MELEXIS.&nbsp;(@ 0x5A)</DIV>
<DIV>Note: The LM84 sensors are not yet operated by the linux kernel.</DIV>=

<DIV>&nbsp;</DIV>
<DIV>Now the description of the issue we have with the I2C subsystem:</DIV>=

<DIV>&nbsp;</DIV>
<DIV>1. the EEPROM is working fine with "i2c-at91" and the "i2c-gpio" =
modules</DIV>
<DIV>2.&nbsp;for IR-Sensor MLX90614, a hwmon class linux driver was =
implemented by Linutronix on our demand. This driver works fine but =
delivers sporadic the error message "i2c-adapter i2c-0: sendbytes: NAK =
bailout." &nbsp;(this message is&nbsp;thrown&nbsp;by the&nbsp; "i2c-algo-bi=
t" driver), or invalid temperature values ( near 0xFFFF). The invalid =
temperature values and as well the error message appear as reponse on bus =
timeout situations&nbsp;which are not correctly handled by the linux =
driver. This we find out using a I2C analyzer. In our opinion these issues =
come while the i2c communication is disturbed by other tasks and/or =
interrupt service routines (ISR) which extend the SMB clock over the =
permitted timeouts, leaving the IR-Sensor in an undefined or <A href=3D"htt=
p://dict.leo.org/ende?lp=3Dende&amp;p=3DCi4HO3kMAA&amp;search=3Derroneous&a=
mp;trestr=3D0x8004"><FONT color=3D#000000>erroneous</FONT></A>&nbsp;state.<=
/DIV>
<DIV>&nbsp;</DIV>
<DIV>The address mentioned in the driver source "Haavard Skinnemoen &lt;<A =
href=3D"mailto:hskinnemoen@atmel.com">hskinnemoen@atmel.com</A>&gt;" =
invalid (unknown)</DIV>
<DIV>&nbsp;</DIV>
<DIV>Please let us now if&nbsp;somebody can help in fixing the i2c-gpio, =
or give us an other name who can help.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you.</DIV>
<DIV>With best regards</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN style=3D"FONT-FAMILY: Arial; FONT-SIZE: 7.5pt; mso-fareast-font-=
family: 'Times New Roman'; mso-ansi-language: DE; mso-fareast-language: =
DE; mso-bidi-language: AR-SA"><SPAN style=3D"FONT-FAMILY: Arial; FONT-SIZE:=
 10pt">Matthias Zacharias<BR>Dipl.-Elektroingenieur (Univ)&nbsp;<BR>Projekt=
leiter Entwicklung</SPAN><SPAN style=3D"FONT-FAMILY: Arial; FONT-SIZE: =
10pt">&nbsp;<?xml:namespace prefix =3D o /><o:p></o:p></SPAN></DIV>
<DIV>
<DIV style=3D"TEXT-ALIGN: center; MARGIN: 0cm 0cm 0pt" class=3DMsoNormal =
align=3Dcenter><SPAN style=3D"FONT-FAMILY: Arial; FONT-SIZE: 7.5pt">
<HR align=3Dcenter SIZE=3D2 width=3D"100%">
</SPAN></DIV>
<P style=3D"MARGIN: 0cm 0cm 0pt" class=3DMsoNormal><B><SPAN style=3D"FONT-F=
AMILY: Arial; COLOR: navy; FONT-SIZE: 10pt; mso-bidi-font-size: 12.0pt">BMK=
 professional electronics GmbH</SPAN></B><SPAN style=3D"FONT-FAMILY: =
Arial; FONT-SIZE: 10pt">&nbsp;=C2=B7&nbsp;Werner-von-Siemens-Str. =
6&nbsp;=C2=B7&nbsp;D-86159 Augsburg</SPAN><SPAN style=3D"FONT-FAMILY: =
Arial; FONT-SIZE: 7.5pt"><o:p></o:p></SPAN></P>
<P style=3D"MARGIN: 0cm 0cm 0pt" class=3DMsoNormal><SPAN style=3D"FONT-FAMI=
LY: Arial; FONT-SIZE: 10pt; mso-ansi-language: EN-GB" lang=3DEN-GB>Tel: =
+49(0)821/20788-715=C2=B7 Fax: +49(0)821/20788-721=C2=B7 </SPAN><SPAN =
style=3D"FONT-FAMILY: Arial; FONT-SIZE: 7.5pt"><A href=3D"http://www.bmk-gr=
oup.de/"><SPAN style=3D"FONT-SIZE: 10pt; mso-ansi-language: EN-GB; =
mso-bidi-font-size: 12.0pt" lang=3DEN-GB>www.bmk-group.de</SPAN></A></SPAN>=
<SPAN style=3D"FONT-FAMILY: Arial; FONT-SIZE: 7.5pt; mso-ansi-language: =
EN-GB" lang=3DEN-GB><o:p></o:p></SPAN></P>
<DIV style=3D"TEXT-ALIGN: center; MARGIN: 0cm 0cm 0pt" class=3DMsoNormal =
align=3Dcenter><SPAN style=3D"FONT-FAMILY: Arial; FONT-SIZE: 7.5pt">
<HR align=3Dcenter SIZE=3D2 width=3D"100%">
</SPAN></DIV></SPAN></DIV><BR>

    <p>
      <font face=3D"Arial">--------------------
</font>    </p>
    <p>
      <font face=3D"Arial">BMK electronic solutions GmbH
</font>    </p>
    <p>
      <font face=3D"Arial">Werner-von-Siemens-Str. 6, Eingang 18 f
</font>    </p>
    <p>
      <font face=3D"Arial">D-86159 Augsburg
</font>    </p>
    <p>
      <font face=3D"Arial">Tel. +49 (0) 821 / 207 88 - 700
</font>    </p>
    <p>
      <font face=3D"Arial">Fax +49 (0) 821 / 207 88 - 721
</font>    </p>
    <p>
      <font face=3D"Arial">info@bmk-solutions.de
</font>    </p>
    <p>
      <font face=3D"Arial">Gesch&#228;ftsf&#252;hrer: Dipl.-oec. Alois =
Kn&#246;ferle
</font>    </p>
    <p>
      <font face=3D"Arial">Sitz: Augsburg
</font>    </p>
    <p>
      <font face=3D"Arial">HR-Nr.: B21197
</font>    </p>
    <p>
      <font face=3D"Arial">---------------------
</font>    </p>
    <p>
      <font face=3D"Arial">
</font>    </p>
    <p>
      <font face=3D"Arial">Diese E-mail kann vertrauliche Informationen=20
      enthalten. Falls Sie diese E-Mail irrt&#252;mlich erhalten haben, =
informieren=20
      Sie bitte unverz&#252;glich den Absender und l&#246;schen Sie diese =
E-Mail von=20
      jedem Rechner, auch von den Mailservern. Jede Verbreitung des =
Inhalts,=20
      auch die teilweise Verbreitung, ist in diesem Fall untersagt. =
Au&#223;er bei=20
      Vorsatz oder grober Fahrl&#228;ssigkeit schliessen wir jegliche =
Haftung f&#252;r=20
      Verluste oder Sch&#228;den aus, die durch Viren befallene Software =
oder=20
      E-Mails verursacht werden.
</font>    </p>
    <p>
      <font face=3D"Arial">
</font>    </p>
    <p>
      <font face=3D"Arial">This e-mail may contain confidential information=
. If=20
      you received this e-mail in error, please contact the sender and =
delete=20
      this e-mail from your computer, including your mailservers. Any=20
      dissemination, even partly, is prohibited. Except in case of =
gross=20
      negligence or wilful misconduct we accept no liability for any loss =
or=20
      damage caused by software or e-mail viruses.</font>
    </p>
  </BODY></HTML>

--=__Part2A0781D2.2__=--


--===============1093183707339752129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1093183707339752129==--
