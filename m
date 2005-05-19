From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c CVS status for 2.4 kernels
Message-Id: <Pine.OSF.4.50.0301152014240.16986-102000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The latest of 2.4 now has module refcounting using .owner.
These changes were merged back from 2.5.54.

Attached patches to i2c code found in Linus's tree but not in CVS.
Other external sources will have to adapt themselves.

Check 2.4 branch out :

 cvs checkout -r l2-4 i2c

 First patch your kernel i2c modules to use .owner refcounting.
 Attached is a patch for 2.4.20 and 2.4.21-pre3.

 I know this breaks pre-2.4.20 compatibility. If you give a reasonable
 minimum 2.4 we want to support, I may consider creating the
 necessary incremental patches. While it is ugly, the choice was to drag
 along all of that 2.2 style inc/dec_use stuff that is removed for 2.5.

 Run mkpatch as usual. Cross your fingers.

 For lm_sensors compatibility:
 # cvs checkout -r POST-2-4-9-KERNELS i2c

 This will give i2c just before the branch, with inc/dec_use in place.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-2.4.21-pre3-pre4-i2c-1.gz
Type: application/octet-stream
Size: 3436 bytes
Desc: 
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030115/a65127d0/patch-2.4.21-pre3-pre4-i2c-1.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-2.4.20-i2c-1.gz
Type: application/octet-stream
Size: 3749 bytes
Desc: 
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030115/a65127d0/patch-2.4.20-i2c-1.obj
