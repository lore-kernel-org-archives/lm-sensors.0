From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <1080222852.4062e48477b7c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Eric <plukje@gmx.net>:

> About the version I used, I couldn't find a version number in
> sensors-detect

We don't include any version in it because it would be a real pain to
update it with each new release.

> but I'm fairly sure this is 2.8.5 (from sensors --version) or
> better.

So you did the right thing, this was the right way to get the
information :)

> root@pathfinder eric # i2cdump 0 0x2e

OK, I am too stupid. This was "i2cdump 0 0x4e", since the mysterious
chip is as 0x04e.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
