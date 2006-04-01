From: m.mcknight@yahoo.ca (Mark McKnight)
Date: Sat, 01 Apr 2006 21:58:08 +0000
Subject: [lm-sensors] nForce 410
Message-Id: <20060401215808.67999.qmail@web37401.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Asus K8n-vm
geforce 6100 / nforce 410
Ubuntu dapper 6.06
lm-sensors = 2.9.2-5ubuntu2

Looking at supported devices on lm-sensors site I thought i2c-nforce2 might work. It doesn't auto-install  on boot  so I modprobe. Here's lsmod output:

i2c_nforce2             7360  0
i2c_dev                10752  0
i2c_core               23168  2 i2c_nforce2,i2c_dev


Here's i2cdetect output:

Error: No i2c-bus specified!
Syntax: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]
        i2cdetect -l
        i2cdetect -V
  I2CBUS is an integer
  With -a, probe all addresses (NOT RECOMMENDED)
  With -q, uses only quick write commands for probing (NOT RECOMMENDED)
  With -r, uses only read byte commands for probing (NOT RECOMMENDED)
  If provided, FIRST and LAST limit the probing range.
  With -l, lists installed busses only
Error: No I2C busses found!
Be sure you have done 'modprobe i2c-dev'
and also modprobed your i2c bus drivers
Error: No i2c-bus specified!
Syntax: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]
        i2cdetect -l
        i2cdetect -V
  I2CBUS is an integer
  With -a, probe all addresses (NOT RECOMMENDED)
  With -q, uses only quick write commands for probing (NOT RECOMMENDED)
  With -r, uses only read byte commands for probing (NOT RECOMMENDED)
  If provided, FIRST and LAST limit the probing range.
  With -l, lists installed busses only
Error: No I2C busses found!
Be sure you have done 'modprobe i2c-dev'
and also modprobed your i2c bus drivers

As you can see it doesn't detect any busses. Is it because the chipset isn't supported yet or... ?

Thanks, Mark


		
---------------------------------
Have a question? Yahoo! Canada Answers. Go to Yahoo! Canada Answers  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060401/35751225/attachment.html
