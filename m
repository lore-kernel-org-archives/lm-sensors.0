From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: I am developing a driver for MAX6900 (RTC chip)
Message-Id: <20040308214907.4be41af2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
In-Reply-To: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> just to let you know, its okay to put my name on the new drivers list:
> Anthony Petillo and can you please put me on the mailing list.
> 
> I will be developing the driver for Linux kernel version 2.4 only.

OK, I've added this information on our "New drivers" page.

I also added MAX6900 detection to our sensors-detect script. Could you
please give it a try and confirm it works for you?

(BTW, do you think that the "reserved" register at 0x97 could be used
for identification? According to the datasheet, it looks like a
read-only register that should always return 0x07, although it has a
write address too. Strange...)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
