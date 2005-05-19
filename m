From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: ALi M1535 datasheet
Message-Id: <20030804112558.3d7bba6d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F2DBE19.7000505@paradyne.com>
In-Reply-To: <3F2DBE19.7000505@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'm sitting on the big patch to the 1535 driver which as you
> may recall was quite disruptive (lots of renaming, etc.).
> 
> The recent 'resource' patch conflicts with that.

I don't remember this second patch.

> Guess I have to decide what to do now. I'm inclined to fix it and
> check in the patch.

Well, it would be silly to lose improvements that have been done to the
driver. I don't know if any of these changes provide clean support for
the M1535+/M1535D+, that would be needed too.

I don't know anything about bus drivers, so I won't be able to help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
