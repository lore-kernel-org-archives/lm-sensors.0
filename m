From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040307160552.2205a041.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> works great!
> I'll fix up our userspace so that if the 'name' file is present we
> will use that rather than descend into the i2c-adapter directory to
> get it. thanks

I tested this on my 7-busses system and it works great :) Thanks guys.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
