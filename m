From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: [PATCH] SPD report slightly improved
Message-Id: <20021108170526.74913818.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021108103703.03c46fbc.nickols_k@mail.ru>
In-Reply-To: <20021108103703.03c46fbc.nickols_k@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> This patch improves HTML form of SPD information report by
> locating info about every chip in independed table.
> IMHO it improves readability of report!
> Please apply this patch into the next release of lm_sensors.

Thanks for the patch. The idea is good indeed, the readability is
definitely improved. I modified your patch a little, because it was
incorrect HTML-output-wise, but kept the idea of course. I did some
other improvements by the way, and I hope everyone will like them. It
has been commited to the CVS tree, and will of course go to 2.6.6, which
should be released by the end of November.

You may test the new version if you want. It is available here:
http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/prog/eeprom/decode-dimms.pl

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
