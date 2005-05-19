From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <20030726002443.21c17b9a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>     I've attached i2c-elektor.patch for proper readb/writeb support in
> newest kernel. Please incorporate it with your Alpha fixes.

Is "newest kernel" to be understood as 2.4.22 or 2.6.0-pre1? (Just to
know if we have to commit your patch to i2c CVS or only Greg on his
side.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
