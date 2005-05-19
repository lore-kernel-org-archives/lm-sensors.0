From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Acer Veriton 5500G
Message-Id: <20030626203952.10ef4afd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030406164617.10845.qmail@web40612.mail.yahoo.com>
In-Reply-To: <20030406164617.10845.qmail@web40612.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> My workstation is running Mandrake Linux 9.1 only.
> 
> I'm not really sure if the chipset of my workstation
> is 'Intel_ 845G' but it is written in
> http://global.acer.com/products/desktop/vt5500g.htm 
> The manual  of my workstation is located at
> 'http://csd.acer.com.tw/acer/URMUL1.NSF/1af87a750eeeb70f0825628f006e0
> bfc/f04d0fee69862b7448256bae0014c344/$FILE/User%2520Guide%205500.pdf'
> if you don't mind viewing/downloading from that site.

Nothing really interesting in this document, apart from the fact that
the sensors chipset must be on the Intel ICH4 bus, which isn't supported
by LM Sensors 2.7.0. You'll have to wait for next release (2.8.0 in some
weeks), unless you want to play with CVS (I doubt it).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
