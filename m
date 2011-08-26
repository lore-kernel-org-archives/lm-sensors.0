From: Jane Teng <sunshine97s@yahoo.com>
Date: Fri, 26 Aug 2011 02:18:42 +0000
Subject: [lm-sensors] dell pe 600sc
Message-Id: <1314325122.65777.YahooMailClassic@web161426.mail.bf1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3016530175323819655=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3016530175323819655==
Content-Type: multipart/alternative; boundary="2110051027-1415252202-1314325122=:65777"

--2110051027-1415252202-1314325122=:65777
Content-Type: text/plain; charset=us-ascii

Hi All,

I have an old dell poweredge 600sc. I can't detect any sensor after running sensors-detect.

motherboard: 
CPU: Processor, 80532, 2.4G, 512K,     533, Socket N, C1

however I read this from google:
"Sorry to fly in the face of common wisdom, but after some persistence, I 
have discovered that the Dell Poweredge 600SC DOES in fact have managment 
sensors an lm_sensors CAN read them.
 The secret was to force load the i2c_piix4 module: modprobe i2c_piix4 
force=1
 Works fine, reads temperature, fan speeds, etc.
"

I have tried:
modprobe i2c_piix4 
force=1
what should I do next?

Thanks in advance

Jane


--2110051027-1415252202-1314325122=:65777
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">Hi All,<br><br>I have an old dell poweredge 600sc. I can't detect any sensor after running sensors-detect.<br><br>motherboard: <br>CPU: Processor, 80532, 2.4G, 512K,     533, Socket N, C1<br><br>however I read this from google:<br>"Sorry to fly in the face of common wisdom, but after some persistence, I 
have discovered that the Dell Poweredge 600SC DOES in fact have managment 
sensors an lm_sensors CAN read them.
 The secret was to force load the i2c_piix4 module: modprobe i2c_piix4 
force=1
 Works fine, reads temperature, fan speeds, etc.
"<br><br>I have tried:<br>modprobe i2c_piix4 
force=1<br>what should I do next?<br><br>Thanks in advance<br><br>Jane<br><br></td></tr></table>
--2110051027-1415252202-1314325122=:65777--


--===============3016530175323819655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3016530175323819655==--
