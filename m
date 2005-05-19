From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503101210060.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

i2c-0: Transaction (pre):  STS=00, CNTL1=00, CNTL2=10, CMD=C1, ADDX,
DAT0=00, DAT1=00
i2c-0: Transaction (post): STSD, CNTL1=00, CNTL2=10, CMD=C1, ADDX,
DAT0=00, DAT1=00
Mar 10 18:01:07 pi140001 kernel: i2c_adapter i2c-0: SMBus Error: Timeout
Device Error Transaction Neve
r Finished

I cant see what status is defined for bit number 6. (status 0x40 or 0x44)
I do not have datasheet (it is not public avaiable now) so only Patrick
could help now.

Or try to compare your windows driver and ours and see what is done
differently. Or even better try if windows drivers works.

I'm sorry I cant help any further with this now.

Regards

Rudolf
