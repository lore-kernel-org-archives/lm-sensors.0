From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: pwmconfig: bug in temporary file creation
Message-Id: <nfiFoTpq.1106650797.7006060.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050124140712.GA17184@bode.aurel32.net>
In-Reply-To: <20050124140712.GA17184@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Aurelien,

> Moreover, I checked the FHS, and /usr/tmp is not a standard directory.
> It is however allowed for compatibility reasons, and in that case should
> be link to /var/tmp. So /usr/tmp should not used in pwmconfig, /tmp
> should be used instead.

Actually $TMPDIR should be used instead, but your patch is obviously
better than that.

> and my linux system doesn't have the tempfile command...
> You're right, it's seems is not a standard command. I have attached a
> new patch using mktemp.

Indeed mktmp seems to be more widely available. Any idea why tempfile
exists though? I wonder why we have two commands doing basically the
same thing.

Thanks,
--
Jean Delvare
