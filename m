From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: bus scan removal
Message-Id: <20031221225845.2793ea55.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I wasn't there back to these times, but we now use a quick write
> > command (which, as you know, doesn't really write anything). A quick
> > look at i2c-ibm_iic.c in Linux 2.6.0 shows that they use one-byte
> > read instead.
> 
> Not all chips acknowledge the read address. With the i2c-ibm_iic, I
> don't see the reason for using one-byte read,  if hw could not do
> quick write a one-byte read is next best choice.

I don't quite follow you there. Is the one-byte read method a good
choice or not?

Anyway, that's not really a problem if we are going to remove that bus
scan from the i2c-ibm_iic driver. Just curious.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
