From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: I am developing a driver for MAX6900 (RTC chip)
Message-Id: <20040302201853.4550df28.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
In-Reply-To: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi, my name is Anthony Petillo and I am currently working on a driver
> for Maxim's MAX6900. It is an I2C bus compatible real-time clock and
> contains 31 bytes of battery backed ram. 
> 
> I was wondering if I could get a device id to add to i2c-id.h.

Hi Anthony,

We have a driver for clock chips named icspll. Please take a look and
confirm that your MAX6900 wouldn't fit in it. If not, I'll give you an
ID.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
