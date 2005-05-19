From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: I2C CVS metamorphosis
Message-Id: <20030724180413.158e4cb5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

I am about to move all the changes made to the lk2-4 CVS branch to the
trunk (HEAD). This is quite a heavy process so I'd like to make sure
everyone agrees about what should be done.

First, I took a quick look at the differencies between two trees. The
following is in the lk2-4 branch but not in HEAD:

etc/config.c

I think we have to keep it.

The following are in HEAD but not in the lk2-4 branch:

CVS/Entries.Log
kernel/i2c-iop3xx.c
prog/ (directory)

I think CVS/Entries.Log is unimportant (although I'm curious on why it
shows here and not there). The prog/ directory is empty so I think we
can delete it. What about the i2c-iop3xx.c driver? Do we simply drop it,
or should it be integrated?

Once we agree on these details, I'll generate the patch and apply it to
head. This means that:

1* The development will move to HEAD.

2* The lk2-4 will be stopped (I don't know if there is a CVS way to do
that).

3* Someone wanting details about changes that occured in the lk2-4
branch won't see them unless he/she specifically checks the repository
out with -r lk2-4. All that will be present at the merge point is a
message saying "Replaced with the file from the lk2-4 branch". If we
want the logs to be added to the trunk as well, we have to use the cvs
merge command, but on the other hand I'm not sure I understand how to do
that (if only possible). We would need to cut the trunk back to the
branching (do we mind losing that?) and then merge. If we don't cut
before merging, we will merge our changes on top of HEAD's ones and the
result will be just awful.

The third possibility is to create a new branch (lk2-5) and merge all
changes from HEAD to this point (that way we don't lose anything). Then
cut the trunk. Then merge lk2-4's changes into the "empty" trunk. Then
remove the lk2-4 branch. This is exactly the same as just renaming HEAD
to lk2-5 and lk2-4 to HEAD. Note that I'm not sure about how to do this
either, but I was just thinking it was the right thing to do, so I
better tell everyone about it.

I have been trying to get some help about how to handle the problem with
CVS but how to do it at best still isn't very clear to me. If anyone can
help, it'll be welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
