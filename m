From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] Forced i2c chip drivers have no name
Message-Id: <20040315223636.0905631f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040312231647.21a101ca.khali@linux-fr.org>
In-Reply-To: <20040312231647.21a101ca.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I just noticed that I am doing something wrong in the i2c chip
> > drivers I ported to Linux 2.6. If these drivers are forced to a
> > specific chip type("kind" as we call it internally), then the device
> > doesn't have its name set (and defaults to an empty string).
> 
> Nice catch.

You probably meant "shame on you" ;) I actually thought I was smarter
that other chip driver authors and tried doing things differently...
Turned out to be a bad idea.

I'm lucky that the missed path wasn't leading to anything critical.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
