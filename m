From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Missing PGP keys? (revisited)
Message-Id: <200406291011.i5TABlTa067370@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c45dbe$5b185ff0$07dc6551@endyvlwz58nhmy>
In-Reply-To: <000001c45dbe$5b185ff0$07dc6551@endyvlwz58nhmy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Bernard,

>        I'm glad the problem could be
>reproduced, and that you no longer see it.
>Unfortunately, I see no change at this end...
>(I've forced re-loading of everything
>which seems relevant, and it makes no
>difference).

I confirm that I do see the keys now on the same system I got empty pages
yesterday, so the server-side problem is solved.

>Quick reference:
>
>	All links to PGP keys from the page
>	http://www2.lm-sensors.nu/~lm78/download.html
>	lead to apparently empty pages.
>
>I'm suffering from Someone Else's network
>connexion right now.
>With a proper system I could see more
>clearly what's going on.  It's possible
>that "Save as..." on IE5 is rejecting
>an empty file merely because it's
>empty, which sound like Microsoft all
>over.  (Did you know that WinCE/
>PocketPC won't sent empty network
>packets?).

Here are a few things you might want to experience:
1* Empty IE's cache, restart IE and retry. You should not believe IE whn
it pretends it reloaded a page.
2* Edit the files associations. I think I remember that IE uses
extensions instead of MIME types (or maybe some random mix of both). The
files have extension .asc and are of type text/plain. I doubt that any
special treatment is done on text/plain files, but .asc files may be
associated with some special treatment.
3* Install Firefox.
http://www.mozilla.org/products/firefox/
Whoever owns the machine you are using, he/she will have to thank you for
the dozens viruses, worms, spywares etc... that will not break his/her
computer down thanks to you.
4* Use some file downloader such as getright.

Good luck,
Jean Delvare
