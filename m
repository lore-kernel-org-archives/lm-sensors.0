From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: libsensors for linux 2.6
Message-Id: <20031118201242.58f09497.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116144447.6ac271ca.khali@linux-fr.org>
In-Reply-To: <20031116144447.6ac271ca.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Mark,

> looks fine to me...
> temp_min1 is 3rd from last...

OK, actually the variables are swapped everywhere (for temp1), so
although it is a mess from a developer's point of view, it doesn't hurt
the user.

Still I would bet that temp2 and temp3 suffer from the problem I
suspected. Writing to temp_max2 would probably change temp_min2's value
instead. Could you confirm?

I will send a modified patch to Greg, that should fix that. Would be
great if you could test it, just to make sure I did not miss a thing
(although I'll double check this time).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
