From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: ATXP1 kernel patch
Message-Id: <Pine.LNX.4.58.0501021813510.18510@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Here are some random notes to start with.

+static unsigned short normal_i2c[]= { 0x37, 0x4e, I2C_CLIENT_END };

I read on some forum also about 0x44. Any clue?

+static 	DEVICE_ATTR(vcore, 0644, atxp1_showvcore, atxp1_storevcore);

cpu[0-1]_vid    CPU core reference voltage.
                Unit: millivolt

What about to use this? (This is also question for other developers :)

+	if(i2c_smbus_read_byte_data(new_client, ATXP1_CVID) <= 0) {
+		kfree(data);
+		return 0;

Hmm really not very scientific nor realible. Any other method is possible?

Next question is about update lock.
Why is gone? It is always good idea...

Also what about ATXP3 and ATX5 my asus board (A7S333) has ATXP3.

Any effort about getting datasheet?

Regards

Rudolf
