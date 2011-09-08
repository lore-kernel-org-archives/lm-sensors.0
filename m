From: Henri C Kjellberg <hck@utexas.edu>
Date: Thu, 08 Sep 2011 19:29:34 +0000
Subject: [lm-sensors] I2C Combined Transactions in Linux
Message-Id: <CAHxUU74ecDvocFpXvhQPdJUndh+FfqU-AfEu0bw2d3+Eim2-MA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4285789493267072110=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4285789493267072110==
Content-Type: multipart/alternative; boundary=0015174bf258a1bc3304ac7314db

--0015174bf258a1bc3304ac7314db
Content-Type: text/plain; charset=ISO-8859-1

Greetings Friends,

I am looking for a way to perform combined transactions over I2C in Linux.
The structure of the message I need to send is as follows. The slave
responds in the brackets.

START
Slave Address, Write
[ACK]
Data
[ACK]
Data
[ACK]
...
FEND
START
Slave Address, Write
[Data]
ACK
[Data]
ACK
...
[FEND]
ACK
STOP

Here, FEND is a special end of message byte defined in a manner similar to
the SLIP encapsulation. It does not appear that I can use the
i2c_smbus_block_process_call because it requires the first data byte to be
the message length. Is there any way to send these sorts of combined
transaction in Linux without using the smbus interface?

Best,
Henri Kjellberg
UT-Austin
Satellite Design Laboratory

--0015174bf258a1bc3304ac7314db
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Greetings Friends,<div><br></div><div>I am looking for a way to perform com=
bined transactions over I2C in Linux. The structure of the message I need t=
o send is as follows. The slave responds in the brackets.</div><div><br>

</div><div>START</div><div>Slave Address, Write</div><div>[ACK]</div><div>D=
ata</div><div>[ACK]</div><div>Data</div><div>[ACK]</div><div>...</div><div>=
FEND=A0</div><div>START</div>
<div>Slave Address, Write</div><div>[Data]</div><div>ACK</div><div>[Data]</=
div><div>ACK</div><div>...</div><div>[FEND]</div><div>ACK</div><div>STOP</d=
iv><div><br></div><div>Here, FEND is a special end of message byte defined =
in a manner similar to the SLIP encapsulation. It does not appear that I ca=
n use the i2c_smbus_block_process_call because it requires the first data b=
yte to be the message length. Is there any way to send these sorts of combi=
ned transaction in Linux without using the smbus interface?</div>
<div><br></div><div>Best,</div><div>Henri Kjellberg</div><div>UT-Austin=A0<=
/div><div>Satellite Design Laboratory</div><div><br></div>

--0015174bf258a1bc3304ac7314db--


--===============4285789493267072110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4285789493267072110==--
