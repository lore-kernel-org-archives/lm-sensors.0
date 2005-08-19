From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 19 Aug 2005 19:24:51 +0000
Subject: [lm-sensors] lm77 driver locks up with kernel-2.6.12
Message-Id: <430615D5.3070409@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43027C3E.6020309@infovia.com.ar>
In-Reply-To: <43027C3E.6020309@infovia.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> What's wrong? Anyone having this problem?
> 

Hello,

Lets see if it is chip driver problem or bus driver problem or hw problem. (or any combination)
Please can you just modprobe the scx200_acb driver and also i2c-dev.

When done with this please several times try:
i2cdump -y 0 0x48 w

0 is the bus number, add there yours. i2cdetect -l will tell you how many busses you have.
0x48 is chip addr also supply yours. You can use:
 i2cdetect 0
to detect all devices on the bus. (better to restart/poweroff the system after that to be sure we do not interfere with yet another issues)

Also please check syslog if you can see something there. You can also try to switch all debug flags in menuconfig (i2c section)

Thanks

regards
Rudolf
