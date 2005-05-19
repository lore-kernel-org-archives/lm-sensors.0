From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-patch2.4.22 => pb with alsa driver
Message-Id: <1078229860.40447b6480203@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040301155624.GA30793@cereve.enpc.fr>
In-Reply-To: <20040301155624.GA30793@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Edouard Debry <debry@cereve.enpc.fr>:

> > I don't think it is related to the i2c patch. I use alsa myself
> > and never had any problem since the first i2c patch.
> 
> hhmmm, so I do not know what the problem is, what means unresolved
> symbols ?

"depmod -ae" should tell you which symbols are missing. This should be a
good hint to start with.

> I succesfully loaded the i810_audio module and the soundcore one
> so this is not the pb

What's the point in installing ALSA if you end up using the OSS driver
for your audio chipset?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
