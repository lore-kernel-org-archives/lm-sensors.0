From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: beeping issues
Message-Id: <20030723231514.55e54827.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721094037.55d98610.khali@linux-fr.org>
In-Reply-To: <20030721094037.55d98610.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> [root@PC pierre]# i2cdump 0 0xe600
> Error: Address out of range!
> (...)
> Something is wrong with the last command but don't know what other 
> address value I have to give to the command.

The address of the chip is 0x2d (0xe600 is the address of the adapter
the chip is located on).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
