From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <20050311220645.206224e3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunaho,

> It seems that no device is at address 0x58. I attached the
> /proc/ioports In this mail, please check it.

0x58 would be an I2C address, not an I/O address. Also, as I said in an
earlier post, this would certainly be 0x58 >> 1, i.e. 0x44.

-- 
Jean Delvare
