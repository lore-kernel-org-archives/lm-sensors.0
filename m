From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Asus a7v8x support
Message-Id: <20030626154736.7c3c5910.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055785605.5085.4.camel@localhost>
In-Reply-To: <1055785605.5085.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> see FAQ for why temperature readings may be different.

Steph and I met on IRC yesterday and solved the problem (alternate temp2
formula for as99127f, already present in CVS).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
