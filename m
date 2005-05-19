From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: Two Masters on one Bus?
Message-Id: <200307231641.23416.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello list,

I'm currently wondering if it is possible to have two master devices 
connected to one I2C-Bus. I will also look into the I2C-Specifications, but 
I guess most of you would know the answer on-the-fly. I have a book (about 
a Motorola Microcontroller), where it is described to use the MC as an 
I2C-Master. It sais there, that it is "sometimes" possible to drive two 
masters on one bus, but not how specifically.

The intention is to build a small Home-Controller connected to the server, 
and I've thought about connecting them using I2C (easiest, only two/four 
wires needed). The "plain" way would be to implement the I2C-Slave Protocol 
on the MC, but that seems somewhat hard to accomplish, since it is a rather 
slow processor doing quite some other things (such as driving an LCD, where 
a refresh already takes ~10ms). So I thought about using both server and 
controller as a Master Device, sharing an EEPROM where they can exchange 
data.

Greetings,
Sascha
