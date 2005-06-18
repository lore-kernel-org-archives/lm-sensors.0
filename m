From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 18 Jun 2005 23:11:51 +0000
Subject: [lm-sensors] Asus A8000 (SMBus 2Eh) Inquiry/Request
Message-Id: <42B48E09.3040106@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
In-Reply-To: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

Jean  thinks it could be also Winbond chip. We can try with:

1) reboot the computer
2) i2cdump 0 0x2e
3) i2cset 0 0x2e 0x4e 0x00
4) i2cdump 0 0x2e

Send us please that two dumps too.

Thanks
Regards

Rudolf

