From: till@harbaum.org (Till Harbaum)
Date: Mon, 27 Nov 2006 17:02:20 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <200611271802.18864.till@harbaum.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Am Montag, 27. November 2006 10:14 schrieb Ulrich Ke?ler:
> I tried to remove the old "SUSE version" with YAST but I get a lot of
> missing dependencies warnings. Is it safe to delete all those things
> (kdebase3-*, amarok-*,kdeaddons-*, susehelp* etc.)?
Uhm, no, don't do that. I think you wouldn't even be able to 
delete them because there are tons of additional packets depending
on these and you'd have to remove them as well. You'd end up deleting nearly 
everything.

You might perhaps try to just overwrite the existing files by setting the 
install prefix to /usr. While this is ugly as well and may cause some problems 
it will likely allow your yast to be able to continue to work. The only real 
solution is of course to build a new package for your suse.

Ciao,
  Till

-- 
Dr. Till Harbaum <Till at Harbaum.org>

