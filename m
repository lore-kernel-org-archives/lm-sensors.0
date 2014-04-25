From: "Naitik Amin" <Naitik.Amin@ametek.com>
Date: Fri, 25 Apr 2014 18:49:20 +0000
Subject: [lm-sensors] Question about eeprom
Message-Id: <OFA9C1E753.B11E37C4-ON85257CC5.0066EAB8-85257CC5.00676535@LocalDomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello All,

I am trying to read and write to 24LC256 from userspace. I have inserted a 

module from 3.13, the name of the module is at24.ko (at24.c) This creates 
a eeprom node at /sys/bus/i2c/devices/2-0054/eeprom

Right now, I can do echo helloworld > /sys/bus/i2c/devices/2-0054/eeprom

And it puts the helloworld starting from 0x00 in eeprom, is there are way 
that i can put helloworld starting at address 0x10 ? And the read from 
starting at address 0x10 ?

Can someone pls comment. I am open to a different method too, my goal is 
read and write to eeprom from the userspace.

Thanks,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
