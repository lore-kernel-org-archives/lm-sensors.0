From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: please help me with my project
Message-Id: <20040506223602.0352375b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405042111.24488.crotariu@vega.it.nuigalway.ie>
In-Reply-To: <200405042111.24488.crotariu@vega.it.nuigalway.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i made a batery charger , a separate board with LTC1759 , I soldered
> some wires on SDRAM card to have acces to I2c from my PC and i
> connected that 2 wires SCL and SDA to LTC1759 chip
> 
> i need to read an write to this chip from my computer. 
> i have i801 smbus controller inside of my PC
> 
> can you tell me the steps that i should follw from now on to write a
> program to "talk " with this chip or wit some chip like this?
> 
> i think i have to use this chip i801 as a master i2c controler to send
> to ltc1759 some data.

Correct.

> i need to write some functions read an write to an smb adress
> 
> read(slave_chip_addr,registry_addr)  
> write(slave_chip_addr,command,data)
> 
> data is 2 bytes 
> and read() should return 2 bytes 
> 
> can you tell me how can i do that? 

You have to options:

1* Write a kernel driver for the LTC1759 chip, either for Linux 2.4 or
2.6, at your option. Use existing chip drivers as examples. This is the
most common way to support new chips, but not necessarily what you want
to do in your particular case.

2* Write a user-space program that access the i2c-dev driver. The
i2c-dev driver is a generic way to control i2c busses from user-space.
You can see the doc/dev-interface file in our i2c package for details.
You can use prog/dump tools from our lm_sensors package as examples.

Hope that helps.

-- 
Jean Delvare
http://khali.linux-fr.org/
