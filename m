From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: [Fwd: sensors, kernel 2.4.19, bttv ...]
Message-Id: <20031027221013.3bde3a36.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067191364.14649.3.camel@lenny.homelinux.net>
In-Reply-To: <1067191364.14649.3.camel@lenny.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'll finally upgrade to 2.4.22 kernel, to use the provided patch.
> But before doing that - as it is not that quick (recompiling nvidia
> drivers, alsa drivers, and what more?) : i'm using also lirc... and it
> seems that it requires also a patch. Will it be that complicated ?

There is a specific patch for lirc, that you'll find on the very same
page as the main patch. Both 0.6.6 and CVS versions are supported. So,
no, it shouldn't be difficult at all.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
