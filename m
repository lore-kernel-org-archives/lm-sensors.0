From: aurelien.jarno@laposte.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: New driver for PCF8591
Message-Id: <E162vWB-0000d5-00@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I would like to write a new driver for the PCF8591. It is an 8-bit A/D and 
D/A converter (4 analog input and one analog ouptpu) for the I2C bus produced 
by Philips Semiconductors.  

According to the website in the "New Drivers" section, nobody has started to 
write a driver for this chip. Please tell me if it is wrong.

I have read the new_drivers file in the lm-sensors package and I have seen I 
am needing an ID reserved in i2c-id.h. Could you provide me one ?

Thanks

Aurelien Jarno
