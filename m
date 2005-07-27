From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 27 Jul 2005 12:48:12 +0000
Subject: [lm-sensors] [PATCH] I2C W83792D driver 1/3
Message-Id: <42E7665B.5090002@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050727092431.10185.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050727092431.10185.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Uff my bad I did not check this. On the other hand the address can be changed to virtually any address via CR48, with condition
that two lowest bits cant be changed.

CR48:
Serial Bus Address <7:1> for general index registers. The
address bit 0 and bit 1 are trapped by the pin 10 and pin 11,
respectively.

Should we go for range 0x20 - 0x2f ?

So like this?

/* Addresses to scan */
static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
                                        0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
                                        0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };

> Also, it seems to me that the end of the patch file is missing?

My bad again. I messed with CC people so I bounced the mail to list and to CC. I belive Greg has good one.
But I guess I must resend anyway.

Thanks
regards

Rudolf

