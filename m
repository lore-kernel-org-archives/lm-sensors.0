From: rodeham <rodeham.zhou@gmail.com>
Date: Thu, 12 Nov 2009 09:23:40 +0000
Subject: [lm-sensors] hi,how to resolve the problem,thank you
Message-Id: <3e29351d0911120123s6a3b217fle7d999e9cf82f6ff@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0118543222963085943=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0118543222963085943==
Content-Type: multipart/alternative; boundary=001636e0addb5125f40478291958

--001636e0addb5125f40478291958
Content-Type: text/plain; charset=ISO-8859-1

I searched the information that is as following. how to resolve this
problem? Thank you

I'm working on a project that uses a smm665 that contains a small
eeprom device on an i2c bus connected to an intel ICH9.

The datasheet for the smm665 specifies that a eeprom read needs
a repeated start.

Figure 24 here:

  http://www.summitmicro.com/prod_select/summary/SMM665/SMM665B_2089_20.pdf

Does anyone happen to know if this adapter supports repeated starts?
The kernel version I'm currently using (admittedly a bit old) does not
appear to do so.

Needless to say, vanilla reads using the smbus api don't work for this
device (but do for an atmel eeprom that I also have access to).

Thanks,
Craig

--001636e0addb5125f40478291958
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I searched the information that is as following. how to resolve this p=
roblem? Thank you</div>
<div>=A0</div>
<div>I&#39;m working on a project that uses a smm665 that contains a small<=
br>eeprom device on an i2c bus connected to an intel ICH9.<br><br>The datas=
heet for the smm665 specifies that a eeprom read needs<br>a repeated start.=
<br>
<br>Figure 24 here:<br><br>=A0 <a href=3D"http://www.summitmicro.com/prod_s=
elect/summary/SMM665/SMM665B_2089_20.pdf">http://www.summitmicro.com/prod_s=
elect/summary/SMM665/SMM665B_2089_20.pdf</a><br><br>Does anyone happen to k=
now if this adapter supports repeated starts?<br>
The kernel version I&#39;m currently using (admittedly a bit old) does not<=
br>appear to do so.<br><br>Needless to say, vanilla reads using the smbus a=
pi don&#39;t work for this<br>device (but do for an atmel eeprom that I als=
o have access to).<br>
<br>Thanks,<br>Craig<br></div>

--001636e0addb5125f40478291958--


--===============0118543222963085943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0118543222963085943==--
