From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 20 Aug 2005 09:41:05 +0000
Subject: [lm-sensors] lm77 driver locks up with kernel-2.6.12
Message-Id: <4306DE86.4080707@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43027C3E.6020309@infovia.com.ar>
In-Reply-To: <43027C3E.6020309@infovia.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

It seems is a definetly combination of HW and bus driver problems.

Now a little excercise:

1) cold boot the device
2) modprobe scx200_acb
3) modprobe i2c-dev
3) i2cdump -y 0 0x4b b
 Try several times dumping in byte mode. Will the transfer be delayted too? I mean does the driver also produce the messages to syslog while in bytemode?

Thanks

regards
Rudolf
