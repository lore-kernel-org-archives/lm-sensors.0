From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: LM90 compatibles
Message-Id: <20030830203914.4b909283.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F50D95D.3050507@paradyne.com>
In-Reply-To: <3F50D95D.3050507@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> as we've noted on our new drivers page there are Maxim and Analog
> Devices chips that appear to be compatible with the LM90. Do you plan
> to add support for those to your lm90 driver?

I plan to do so on request. I don't want to add support for chipsets
that nobody has or that even don't exist on any computer motherboard,
that's why I'm waiting for requests before adding support.

Maybe I should change the new drivers page to reflect that?

Also, I could add detection for these chips to sensors-detect (the same
way we have detection for the LM82, LM86 and LM89 although we don't have
driver support for those either). Do you want me do to so?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
