From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [CVS PATCH] Sync cvs tree with latest 2.5 bk tree
Message-Id: <20030426100806.15bb1080.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030425183641.GB2257@kroah.com>
In-Reply-To: <20030425183641.GB2257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Namely, do we do another 2.4-compatible release.
> I'm in favor of at least one more, because I would like to
> clear up some problems in 2.7.0. The problems are really on the i2c
> side though.

I'm clearly in favor of one more, too. I've been telling people far too
many times to try previous versions of LM Sensors because 2.7.0 wasn't
working for them... (Though it did not always worked then). Having one
"clear" release would be great.

Second, I think we need to keep this 2.4-compatible branch alive. Even
if we don't add a single driver to it for years, we have to think we
still may encounter some critical bug. Next 2.4 kernels may generate
some warnings in our code. Docs may need to be fixed. So, being able to
release some more 2.7.x I2C/LM Sensors packages, even with only slight
changes, would be clever IMHO. We've been dropping 2.2-kernel support
just one release ago, I don't think we can decently do the same with
2.4-kernels right now, considering 90% of the Linux users are relying on
these. Usable 2.6 kernels are still months away.

Then, we'll have to make clear which branch is the default branch and
how one would access the non-default branch. I'm still not used to CVS
(though the LM Sensors and DMI Decode projects helped me a lot)
especially with branches, I don't want to break anything and I don't
plan to stop commiting fixes each time I can.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
