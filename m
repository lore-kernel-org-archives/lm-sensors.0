From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <20030924224049.7f547f71.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I did it this way, as ioremap returns a void *.  And it's ok to do
> math on a void pointer, works the same way as math on a char *.  It
> got rid of two casts in the driver with this change.

Not too sure abour that. Gcc wouldn't have a flag (-Wcast-arith) for
this without a reason.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
