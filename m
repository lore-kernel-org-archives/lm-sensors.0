From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: W83L785R Support
Message-Id: <20040221171327.21f76a0e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402201842.48537.coflynn@newae.com>
In-Reply-To: <200402201842.48537.coflynn@newae.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Did you try
> http://rivatv.sourceforge.net/download.html
> 
> It should have a driver called
> 
> i2c-riva

Since some times now, they have a single module for everything
(including i2c), so it is called rivatv.

> so you dont need to override the bus.
> It will create new bus with hopefully this device too.

Yes, it should.

A recent version of sensors-detect *should* also have detected it and
suggest that you go and get the above-mentioned module. Colin, didn't
that happen? If it did not, please provide the output of lspci -v and
lspci -n so that we can add your card to the list.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
