From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Read word
Message-Id: <20031022192953.53c9d7bb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031013214150.4d6a92a9.khali@linux-fr.org>
In-Reply-To: <20031013214150.4d6a92a9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Are there negative side effects trying to read an I2C chip register
> > in byte mode while it is supposed to be read in word mode? I'm
> > thinking of using this to enhance our LM75 detection. Since the LM75
> > returns the words high byte first, while other chips usually return
> > low byte first, we could try and read registers 0, 2 and 3 in byte
> > mode and make sure that the byte returned matches the high byte, not
> > the low byte, of the words we previously read.
>
> sounds harmless to me
> (famous last words...)

Whatever, my proposal doesn't make sense. Reading a word register in
byte mode will always return the first byte that would have been
returned if read in word mode, wether it is the low or high one. We
don't know if the first byte is high or low unless we know what chip we
are talking to - while this is precisely what we are trying to detect.

Let's forget about all this, sorry for the noise.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
