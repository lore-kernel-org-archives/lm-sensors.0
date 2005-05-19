From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-matroxfb
Message-Id: <20030718145914.3f5f4be1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710182523.4ceef8fa.khali@linux-fr.org>
In-Reply-To: <20030710182523.4ceef8fa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I tried to run i2cdump on my Matrox Mystique, first with timeout0,
> second with timeoutP. It took 8s for each address scanned in the
> first case, 4s for each address scanned in the second case. This shows
> that the timeout is the value that makes it slow, but this also raise
> another problem. I would have expected the average scan time to be
> exactly the timeout value. And it is eight times higher.I checked the
> i2cdump code and it only calls i2c_smbus_read_byte_data() once for
> each address.

Hm. I meant i2cdetect of course. So the function that is called is
i2c_smbus_write_quick(), not i2c_smbus_read_byte_data(). BTW there is
also an ioctl() call, which I am not familiar with. Could it also cause
the slowdown too?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
