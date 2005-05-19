From: crotariu@vega.it.nuigalway.ie (Cosmin Rotariu)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: please help me with my project
Message-Id: <200405042111.24488.crotariu@vega.it.nuigalway.ie>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, 
I'm Cosmin Rotariu, I'm a student in electonic engineering and i need some 
help with my project

i made a batery charger , a separate board with LTC1759 , I soldered some 
wires on SDRAM card to have acces to I2c from my PC and i connected that 2 
wires SCL and SDA to LTC1759 chip

i need to read an write to this chip from my computer. 
i have i801 smbus controller inside of my PC

can you tell me the steps that i should follw from now on to write a program 
to "talk " with this chip or wit some chip like this?

i think i have to use this chip i801 as a master i2c controler to send to 
ltc1759 some data.

i need to write some functions read an write to an smb adress

read(slave_chip_addr,registry_addr)  
write(slave_chip_addr,command,data)

data is 2 bytes 
and read() should return 2 bytes 

can you tell me how can i do that? 

thank you for your time
