From: "Vladimir Cherednichenko" <VCherednichenko@CloudShield.com>
Date: Mon, 02 Feb 2009 22:17:32 +0000
Subject: [lm-sensors] I2C tools for Linux question
Message-Id: <FAA3D0857AA3EF4A8C072772D5C5BE710242E221@CS-MAIL01.cloudshield.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C98584.0B0732C9"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============8553919659599716631==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C98584.0B0732C9"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C98584.0B0732C9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gentlemen,

We are trying to use i2c tools for Linux for our application and =
encountered a problem:

Read and write of Microchip 24AA256 device, which is used as our fan =
tray
EEPROM, requires sequences of i2c operations which seem to be not fully =
supported by
current i2c-dev driver of Linux kernel.

To read a byte from 24AA256 one has to perform:
( -> from master to slave; <- from slave to master)

-> START=20
-> Control Byte (1010 0000)=20
<- ack=20
-> Address High Byte=20
<- ack=20
-> Address Low Byte=20
<- ack=20
-> START=20
-> Control Byte (1010 0001)=20
<- ack=20
-> Dummy byte
<- Data byte=20
<- NO ack=20
-> STOP=20

To write a byte to 24AA256:

->  START=20
-> Control Byte (1010 0010)=20
<- ack=20
-> Address High Byte=20
<- ack=20
->Address Low Byte=20
<- ack=20
                              <<<---------- no -> START  <<-------
-> Data byte=20
<- ack=20
-> STOP=20

Macros provided in i2c-dev.h  do not give us ability to write 2-byte =
address for both read
and write single byte data.
It also does not give us ability to avoid START in write operation.

We found a work-around for read by doing a small trick:
A.  Perform a Byte write to the EEPROM:
     - Slave address is the EEPROM address, Write address is the high 7 =
bits of
the address, Data is the low 7 bits of the address.
B.  Perform a Byte read from the EEPROM:
     - Slave address is the EEPROM address



We do not have a trick to avoid START in a write operation.
Can you suggest anything as a work-around?

Vladimir Cherednichenko
Sr. Software Engineer

CloudShield Technologies, Inc.
212 Gibraltar Drive
Sunnyvale, CA 94089
vcherednichenko@cloudshield.com.
408 331 6692 direct





------_=_NextPart_001_01C98584.0B0732C9
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>I2C tools for Linux question</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Gentlemen,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We are trying to use i2c tools for =
Linux for our application and encountered a problem:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Read and write of Microchip =
24AA256 device, which is used as</FONT> <FONT SIZE=3D2 FACE=3D"Courier =
New">our</FONT><FONT SIZE=3D2 FACE=3D"Courier New"> fan tray<BR>
EEPROM, requires sequences of i2c operations which</FONT> <FONT SIZE=3D2 =
FACE=3D"Courier New">seem to be</FONT><FONT SIZE=3D2 FACE=3D"Courier =
New"> not fully supported by<BR>
current i2c-dev driver of Linux kernel.<BR>
<BR>
To read a byte from 24AA256 one has to perform:<BR>
( -&gt; from master to slave; &lt;- from slave to master)<BR>
<BR>
-&gt; START<BR>
-&gt; Control Byte (1010 0000)<BR>
&lt;- ack<BR>
-&gt; Address High Byte<BR>
&lt;- ack<BR>
-&gt; Address Low Byte<BR>
&lt;- ack<BR>
-&gt; START<BR>
-&gt; Control Byte (1010 0001)<BR>
&lt;- ack<BR>
-&gt; Dummy byte<BR>
&lt;- Data byte<BR>
&lt;- NO ack<BR>
-&gt; STOP<BR>
<BR>
To write a byte to 24AA256:<BR>
<BR>
-&gt;&nbsp; START<BR>
-&gt; Control Byte (1010 0010)<BR>
&lt;- ack<BR>
-&gt; Address High Byte<BR>
&lt;- ack<BR>
-&gt;Address Low Byte<BR>
&lt;- ack<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt;&lt;---------- no -&gt; START&nbsp; =
&lt;&lt;-------<BR>
-&gt; Data byte<BR>
&lt;- ack<BR>
-&gt; STOP<BR>
<BR>
</FONT><FONT SIZE=3D2 FACE=3D"Courier New">Macros provided in =
i2c-dev.h</FONT>&nbsp;<FONT SIZE=3D2 FACE=3D"Courier New"> do not give =
us ability to write 2-byte address for both read<BR>
and write single byte data.<BR>
It also does not give us ability to avoid START in write operation.<BR>
<BR>
</FONT><FONT SIZE=3D2 FACE=3D"Courier New">W</FONT><FONT SIZE=3D2 =
FACE=3D"Courier New">e found a work-around for read by</FONT><FONT =
SIZE=3D2 FACE=3D"Courier New"></FONT> <FONT SIZE=3D2 FACE=3D"Courier =
New">doing a small trick:<BR>
A.&nbsp; Perform a Byte write to the EEPROM:<BR>
&nbsp;&nbsp;&nbsp;&nbsp; - Slave address is the EEPROM address, Write =
address is the high 7 bits of<BR>
the address, Data is the low 7 bits of the address.<BR>
B.&nbsp; Perform a Byte read from the EEPROM:<BR>
&nbsp;&nbsp;&nbsp;&nbsp; - Slave address is the EEPROM address</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">We do not have a trick to avoid =
START in a write operation.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Can you suggest anything as a =
work-around?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Vladimir Cherednichenko</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Sr. Software Engineer</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">CloudShield Technologies, Inc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">212 Gibraltar Drive</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Sunnyvale, CA 94089</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">vcherednichenko@cloudshield.com.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">408 331 6692 direct</FONT>
</P>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C98584.0B0732C9--


--===============8553919659599716631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8553919659599716631==--
