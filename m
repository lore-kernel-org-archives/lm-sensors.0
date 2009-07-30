From: VastOne <vastone@gmail.com>
Date: Thu, 30 Jul 2009 03:19:26 +0000
Subject: [lm-sensors] Needing help with either
Message-Id: <8d37920b0907292019y44b5c69bh23ce713a29aeb21d@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8498459930545717224=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8498459930545717224==
Content-Type: multipart/alternative; boundary=0015174c135260ba3c046fe3c5a0

--0015174c135260ba3c046fe3c5a0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Been using lm-sensors for quite a while and no issues with all of my
gigabyte motherboards

After reading great reviews for a MSI AMD 790FX-GD70 motherboard I am very
happy with it...

If I can get lm-sensors to work again. With the channels version 3.02 I was
getting the message no driver for Fintek F75387SG/RG yet and sensors
reported "No sensors found"

After reading here and everywhere about the issues with 2.5 kernels and
above with 3.02 lm-sensors, I have upgraded to 3.1.1 and now the Fintek is
found

Driver `to-be-written':
* Chip `AMD K10 thermal sensors' (confidence: 9)
* ISA bus, address 0x600
Chip `Fintek F71889FG Super IO Sensors' (confidence: 9)
* Bus `SMBus PIIX4 adapter at 0b00'
Busdriver `i2c_piix4', I2C address 0x2e
Chip `Fintek F75387SG/RG' (confidence: 7)

Note: there is no driver for AMD K10 thermal sensors yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

No modules to load, skipping modules configuration.

Unloading i2c-dev... OK

And I am back to No Sensors found..

All of these are allegedly supported but I cannot get any of them to load.

Has any one ever seen the AMD K10 or the Fintek Super chip loaded and
working?


-- 
Thank you,

vastone@gmail.com

--0015174c135260ba3c046fe3c5a0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Been using lm-sensors for quite a while and no issues with all of my gigabyte motherboards<br>
<br>
After reading great reviews for a MSI AMD 790FX-GD70 motherboard I am very happy with it...<br>
<br>
If I can get lm-sensors to work again. With the channels version 3.02 I
was getting the message no driver for Fintek F75387SG/RG yet and
sensors reported &quot;No sensors found&quot;<br>
<br>
After reading here and everywhere about the issues with 2.5 kernels and
above with 3.02 lm-sensors, I have upgraded to 3.1.1 and now the Fintek
is found <br>
<br>
Driver `to-be-written&#39;:<br>
  * Chip `AMD K10 thermal sensors&#39; (confidence: 9)<br>
  * ISA bus, address 0x600<br>
    Chip `Fintek F71889FG Super IO Sensors&#39; (confidence: 9)<br>
  * Bus `SMBus PIIX4 adapter at 0b00&#39;<br>
    Busdriver `i2c_piix4&#39;, I2C address 0x2e<br>
    Chip `Fintek F75387SG/RG&#39; (confidence: 7)<br>
<br>
Note: there is no driver for AMD K10 thermal sensors yet.<br>
Check <a href="http://www.lm-sensors.org/wiki/Devices" target="_blank">http://www.lm-sensors.org/wiki/Devices</a> for updates.<br>
<br>
No modules to load, skipping modules configuration.<br>
<br>
Unloading i2c-dev... OK<br>
<br>
And I am back to No Sensors found..<br><br>
All of these are allegedly supported but I cannot get any of them to load.<br>
<br>
Has any one ever seen the AMD K10 or the Fintek Super chip loaded and working? <br>
<br clear="all"><br>-- <br>Thank you,<br><br><a href="mailto:vastone@gmail.com">vastone@gmail.com</a><br>

--0015174c135260ba3c046fe3c5a0--


--===============8498459930545717224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8498459930545717224==--
