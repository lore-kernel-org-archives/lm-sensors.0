From: khali@linux-fr.org (Khali)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: CVS write access -- diffs included
Message-Id: <1033130542.3d94522e5fa11@imp.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020920172403.A12232@mookie.cis.brown.edu>
In-Reply-To: <20020920172403.A12232@mookie.cis.brown.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi folks !

> thanks very much for the diffs.
> All look good to me and are checked in, with the exception of the
> dmidecode changes, which you included without comment.

> The code &= ~0x80 changes are obviously correct.
> However, dmidecode is maintained by Alan Cox - we just have a copy for
> our uses.
> Our dmidecode person ("Khali") is currently unavailable to push this to
> Alan. You may wish to forward your patch directly to Alan with comments.

Thought I'm still not really available, I'll try to help.

Dave, did you actually send something to Alan? Reading your patch, which 
however isn't bad, I found many things that could (and should) be fixed better. 
I'm working on it right now, and I plan to send a patch to Alan when I'm done.

Mark, could you please tell me where you found the constant values you used in 
dmi_temp_loc() (still in dmidecode.c)? They aren't part of the smbios 
specification I have. If you have some other specification, please share with 
me.

I'd like to remind everyone that, anyway, I plan to get rid of dmidecode as far 
as sensors-detect is concerned. I will rewrite the part we need someday, 
directly in perl.

Later,
Khali
