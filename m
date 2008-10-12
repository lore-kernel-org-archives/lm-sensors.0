From: "Tony McConnell" <amnw14545@googlemail.com>
Date: Sun, 12 Oct 2008 20:47:08 +0000
Subject: [lm-sensors] Fintek F71862FG
Message-Id: <2e01cfe50810121347xeac7909kd144dd0f7f13769d@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8196207125608695035=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8196207125608695035==
Content-Type: multipart/alternative; 
	boundary="----=_Part_32375_23108634.1223844428215"

------=_Part_32375_23108634.1223844428215
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've got a Jetway NC81-LF board with an AM2 4850e processor. The k8temp
hwmon driver reports rubbish for the core temperatures... don't worry, I'm
not going to ask why.

The board also has a Fintek F71862FG Super IO sensor on board which is
listed as recognised but not supported by the lm-sensors website.

Messed around a bit (a tiny bit) with the f71882fg driver, adding the chip
ID (0x0601), and it appears to work so far as reporting fan speeds and
cpu/case temperatures.

Values for temp1, temp3, and fan1, fan2, look reasonable (i.e. match the
figures reported by the BIOS HW monitoring)

temp2 reads 72 degC which hopefully isn't correct. But at least it's a
constant 72.

Not sure about any other functionality though; but it looks like basic
support for the chip can be enabled simply by adding the Chip ID to the
existing f71882fg driver.

Apologies if this isn't useful to anyone else but me...

------=_Part_32375_23108634.1223844428215
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">I&#39;ve got a Jetway NC81-LF board with an AM2 4850e processor. The k8temp hwmon driver reports rubbish for the core temperatures... don&#39;t worry, I&#39;m not going to ask why.<br><br>The board also has a Fintek F71862FG Super IO sensor on board which is listed as recognised but not supported by the lm-sensors website.<br>
<br>Messed around a bit (a tiny bit) with the f71882fg driver, adding the chip ID (0x0601), and it appears to work so far as reporting fan speeds and cpu/case temperatures.<br><br>Values for temp1, temp3, and fan1, fan2, look reasonable (i.e. match the figures reported by the BIOS HW monitoring)<br>
<br>temp2 reads 72 degC which hopefully isn&#39;t correct. But at least it&#39;s a constant 72.<br><br>Not sure about any other functionality though; but it looks like basic support for the chip can be enabled simply by adding the Chip ID to the existing f71882fg driver.<br>
<br>Apologies if this isn&#39;t useful to anyone else but me...<br><br><br></div>

------=_Part_32375_23108634.1223844428215--


--===============8196207125608695035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8196207125608695035==--
