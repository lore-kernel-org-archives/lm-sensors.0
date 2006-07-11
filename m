From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 11 Jul 2006 14:11:38 +0000
Subject: [lm-sensors] it87 driver supports ITE8716 chip on new AM2 boards
Message-Id: <44B3B19A.4030502@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060705202045.GA15892@debamd64>
In-Reply-To: <20060705202045.GA15892@debamd64>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Mike,

Thanks for the chip dump.

I would like to know what happen now:
(unload the it87 module)
rmmod it87
isadump -y -f 0x290
isaset -y -f 0x295 0x58
isadump -y -f 0x290
isaset -y -f 0x295 0x55
isadump -y -f 0x290
isaset -y -f 0x295 0xAA
isadump -y -f 0x290

I need this so I can fix the detection script.
Thanks,

Regards
Rudolf

