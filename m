From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: sensors shows uninteresting chips
Message-Id: <20031202223005.790b6990.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130145100.722ebe68.khali@linux-fr.org>
In-Reply-To: <20031130145100.722ebe68.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It tells us we forgot to add support to 'sensors' so
> that's one reason to leave it the way it is.

Isn't the missing output enough to make you realize you forgot it? We
don't add new chips that often, and I'm sure people will remind us if we
forget.

On the other hand, more and more people have video stuff on their i2c
busses these days, that sensors will display as unknown chips. So I
still pretend we should at least provide a way to hide them, and should
I be the one to decide, I would make it the default.

That default could be reverted later if we are ever able to select chips
by class in 2.6, as Ky?sti mentioned.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
