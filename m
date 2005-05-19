From: salvador@inti.gov.ar (salvador)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: ALi M5879 and ALi M1535D+
Message-Id: <3C4C4762.CFB58B7F@inti.gov.ar>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All!

I have 2 mothers:
1) ALi M1535D+ and GL520SM
2) ALi M1535D+ and ALi M5879

Problem 1:
Both prints "command never completed", I had to comment the printk
(lm_sensors 2.6.1 and 2.6.2).

Problem 2:
M5879 isn't really supported, I tried LM78 driver (suggested with confidence
7) and I can use it but some inputs seems to be crossed and also some
correction  factors are wrong.
Does anybody have contact with ALi people to ask for data sheets?
The temperature seems to be OK, but I can't be sure. I'm comparing with
hmonitor windows tool and meassured voltages.

All the rest works quite nice, thanks!

SET

P.S. A message making clear that 1535 means the number of the chip and not
something in the PCI bus could help users. My PCI bus have something called
1543 and hence I tried 15x3 first.

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013


