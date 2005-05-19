From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030806143415.3bf03655.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> make of lm-sensors_2.7.0 gives me:
> 
> usses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
> kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old -
> i2c-2.7.0 or greater required!
> (...)
> Any hints?

Sure. http://secure.netroedge.com/~lm78/, see new item "# May 31st,
2003". Get the updated Makefile and config.c, should work OK then.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
