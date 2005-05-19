From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: [PATCH 2.6] more i2c bus drivers (2/2)
Message-Id: <20031211223249.0a9a8524.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031205222400.1b7ff3a6.khali@linux-fr.org>
In-Reply-To: <20031205222400.1b7ff3a6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I only count 31 letters...
> 
> [ppokorny@vaio ppokorny]$ echo SMBus AMD756 compatible adapter | wc
>       1       4      32
> 
>  (+1 for the newline)

The exact code is (or would be):
  sprintf(amd756_adapter.name,
    "SMBus AMD756 compatible adapter at %04x", amd756_ioport);

39 unless I made a mistake.

> If you want something shorter, what about "type", "compat", or
> "style" instead of "compatible"

Still wouldn't fit.

> Or leave "compatible" out entirely...

My preference.

> Or go with 7xx.

You didn't seem to like it in the first place.

> It's just cosmetic, and I was only trying to improve understanding. 
> If it doesn't fit, then it doesn't fit.

Maybe we could gzip it? ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
