From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Call for 2.8.0 soon
Message-Id: <20030612104014.2451bc9b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE7C67A.4040703@paradyne.com>
In-Reply-To: <3EE7C67A.4040703@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I think things are getting into shape here after a lot of work.
> Maybe we can do a release in a week or two?

Would be great, but I doubt we'll have all the issues below fixed in two
weeks. I admit there's a need for a new release as soon as possible
though.

> - sensors-detect "UTF" issue

I'm on it.

> - Need testing against kernel 2.4.9

I could take care of this. I could also test on some kernels between
2.4.9 and 2.4.18 (the oldest I'm still using). I just have to avoid the
ones that can destroy the machine... 2.4.11 and 2.4.15 IIRC.

And I'm adding:

- Fix GCC 3 compilation warnings.

I've seen some, I'll have a look and see what I can do.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
