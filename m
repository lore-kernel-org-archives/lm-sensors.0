From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 26 Jun 2008 04:03:00 +0000
Subject: [lm-sensors] [patch 0/5 v1] hwmon/pc87360 individual alarm files
Message-Id: <486314F4.6080305@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


this patch-set (against mainline de08341a0ef747d607542af3ae441b286f503e35)
adds individual alarm files, per Doc/hwmon/sysfs-interface (IIUC)

0001-Add-CHAN_-constants-to-support-ALM_-MIN-MAX-CRIT-s.patch
0002-Add-vin-min-max-alarm-sysfs-file-decls-and-callbacks.patch
0003-Add-separate-tempX_min-max-crit_alarm-sysfs-files.patch
0004-add-LDNI_MAX-constant-for-3-Logical-Devices-we-handl.patch
0005-Add-dev_dbg-calls-to-show-status-regs-at-module-lo.patch
0006-fix-crap-that-snuck-thru.patch

these are in git, which feels cool.
but Im still kinda new at it, so Im unsure of basic best practices,
nevermind figuring out my optimal workflow,
so Ive deferred fixing the checkpatch warnings for now, figuring
more substantive feedback may be forthcoming.

I plan to re-apply these git-diffs, 1 at a time,
- 1st fix checkpatch complaints
- then whatever your feedback suggests
- fold 0006 into 0005

Is there another approach that someone with more git-fu would use ?

I also need to (I think) rebase against Mark Hoffman's git tree.
I dont want to pull a brand new repo, and I think theres probably a way that
I can keep multiple remote masters (do you detect terminology confusion 
here?)
in my 1 repo, but I dont know how to do it, and I dont want to 
"screw-up" my repository.
Any 2-20 liner tips ?


In an earlier iteration of patch rework, I tried manually cleaning up
a few of the checkpatch warnings (long comment lines) in the git-diff 
itself,
but then I tried to apply them, and git-apply refused them.
(and naturally, I dont have the error saved :(

Does git-apply enforce any cryptographic verification of the patch
that would defeat manual patch hacking ?
Does it preserve the commit messages ?  I recall having to redo them, 
newbie error ?


alright, enough digression
thanks
Jim Cromie

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
