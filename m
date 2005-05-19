From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: sysfs names
Message-Id: <20040126230447.09700886.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

The more I work with new sysfs names, the more I wonder why the naming
scheme was chosen the way it is. We had features named
<type><number>_<subitem> for years, and now end up with files named
<type>_<subitem><number>. Not only I don't see why a change was needed,
but I definitely prefer the old naming scheme. It was much more logical,
since "ls" would order them in a very logical way (grouping by type and
sub-grouping by "physical entity").

What's more, the libsensors tweaks would be much more simple if we had
stuck to the old scheme. Most of the required conversions are just
moving from old scheme to new scheme with no other change.

Since the sysfs interface is obviously still not stabilized and we are
still on early 2.6 kernels, I think we should consider moving back to
the "old" names for the sake of consistency, beauty and logic.

Greg, don't look at me that way please. I am serious!

I know this is quite an important change, but precisely, we'd better
change before porting the missing 30 chip drivers than after. I know how
much work it will be - especially since I'll obviously be the one to
cope with it - still I think we should do it.

Comments, thunder and rocks welcome ;)
Thanks.

NB: May I know the name of the brilliant chooser of the new naming
scheme? Not to blame him/her (oh well... ;)) but to know the reasons of
his/her choice.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
