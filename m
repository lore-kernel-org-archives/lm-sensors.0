From: "komang adi" <untukta@gmail.com>
Date: Mon, 26 May 2008 09:37:33 +0000
Subject: [lm-sensors] asking about monitoring soekris net4801
Message-Id: <d3a276f0805260237j33d47ac4rbf3dde908a75e70a@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4097007770314318351=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4097007770314318351==
Content-Type: multipart/alternative; 
	boundary="----=_Part_16440_5002092.1211794653916"

------=_Part_16440_5002092.1211794653916
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi. I am Komang, university student.
I want to monitor the voltage and temperatur monitoring lm-sensor. I have
installed and configure sensor3.conf, and when i check the result by using
#sensors, the output like this :
root@relay:/home/relay# sensors
pc87366-isa-6620
Adapter: ISA adapter
VCORE:       +0.00 V  (min =  +1.90 V, max =  +2.10 V)
VCC:         +0.00 V  (min =  +0.00 V, max =  +0.00 V)
VPWR:        +0.00 V  (min =  +5.93 V, max = +28.02 V)
+12V:        +0.00 V  (min = +11.02 V, max = +13.01 V)
-12V:       -29.70 V  (min = -13.04 V, max = -11.03 V)
GND:         +0.00 V  (min =  +0.00 V, max =  +0.00 V)
Vsb:         +3.31 V  (min =  +3.00 V, max =  +3.31 V)
Vdd:         +6.03 V  (min =  +3.00 V, max =  +3.59 V)
Vbat:        +0.00 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:        +6.03 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       -128.0 C  (low  =  +0.0 C, high = +70.0 C)
                      (crit = +85.0 C)
cpu0_vid:   +0.000 V
There, we see that only partial data can be get from soekris 4801, even the
data that have been succesful gather is not correctly. Anyone can help?
I want to get all of the data by using lm-sensors.
Thanks.

-komang

------=_Part_16440_5002092.1211794653916
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi. I am Komang, university student.</div>
<div>I want to monitor the voltage and temperatur monitoring lm-sensor. I have installed and configure sensor3.conf, and when i check the result by using #sensors, the output like this :</div>
<div><a href="mailto:root@relay:/home/relay">root@relay:/home/relay</a># sensors<br>pc87366-isa-6620<br>Adapter: ISA adapter<br>VCORE:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.00 V&nbsp; (min =&nbsp; +1.90 V, max =&nbsp; +2.10 V)<br>VCC:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.00 V&nbsp; (min =&nbsp; +0.00 V, max =&nbsp; +0.00 V)<br>
VPWR:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.00 V&nbsp; (min =&nbsp; +5.93 V, max = +28.02 V)<br>+12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.00 V&nbsp; (min = +11.02 V, max = +13.01 V)<br>-12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -29.70 V&nbsp; (min = -13.04 V, max = -11.03 V)<br>GND:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.00 V&nbsp; (min =&nbsp; +0.00 V, max =&nbsp; +0.00 V)<br>
Vsb:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.31 V&nbsp; (min =&nbsp; +3.00 V, max =&nbsp; +3.31 V)<br>Vdd:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +6.03 V&nbsp; (min =&nbsp; +3.00 V, max =&nbsp; +3.59 V)<br>Vbat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.00 V&nbsp; (min =&nbsp; +2.40 V, max =&nbsp; +3.01 V)<br>AVdd:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +6.03 V&nbsp; (min =&nbsp; +3.00 V, max =&nbsp; +3.59 V)<br>
Temp:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -128.0 C&nbsp; (low&nbsp; =&nbsp; +0.0 C, high = +70.0 C)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (crit = +85.0 C)<br>cpu0_vid:&nbsp;&nbsp; +0.000 V<br></div>
<div>There, we see that only partial data can be get from soekris 4801, even the data that have been succesful gather is not correctly. Anyone can help?</div>
<div>I want to get all of the data by using lm-sensors.</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>-komang</div>

------=_Part_16440_5002092.1211794653916--


--===============4097007770314318351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4097007770314318351==--
