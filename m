From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: wrong cpu temp
Message-Id: <20030630164903.52ad4d73.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <001201c33f14$0ee832a0$f265a8c0@gf01>
In-Reply-To: <001201c33f14$0ee832a0$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> and with 'modprobe it87 temp_type=0x290' tha i think is the correct
> parameter for my it87. show negative number

No, it isn't. You should have read the docs... Try temp_type=0x1c.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
