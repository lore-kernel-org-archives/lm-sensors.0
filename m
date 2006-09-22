From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 22 Sep 2006 04:31:16 +0000
Subject: [lm-sensors] [patch] hwmon: w83781d - check return code of
Message-Id: <45136714.3010504@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F70D89.30409@gmail.com>
In-Reply-To: <44F70D89.30409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Add 2 attr-file groups (for base and model-specific attrs respectively),
create the base group with single call to sysfs_create_group,
check the return code on individual calls to device_create_file for each
of the model-specific attr-files.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

---

This is compile-tested only, needs validation on hardware, or
very thorough inspection.

diffstat hwmon-unchecked-return-status-fixes-w83781d.patch
 w83781d.c |  292 
++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 155 insertions(+), 137 deletions(-)

> Can you please get rid of all these macros while you're here? I didn't
> like them much before, but now it's even worse as they are never
> functions not constants but random code exerpts, which is quite
> misleading and could cause a lot of confusion later. This would also
> let you return the error values properly.
>
>   

theyre gone. (the file_<foo> macros)

There are several distasteful macro-function-decl-expansions still there :

show_in_reg(in);
show_in_reg(in_min);
show_in_reg(in_max);

store_in_reg(MIN, min);
store_in_reg(MAX, max);

and also a compound one:  This one in particular is crying for a 
2D-callback implementation.
Ill do it (its my axe, Ill grind it some more ;-), IFF you find a tester 
for it.
Anyway, thats not for 19.

#define sysfs_in_offsets(offset) \
sysfs_in_offset(offset); \
sysfs_in_reg_offset(min, offset); \
sysfs_in_reg_offset(max, offset);

sysfs_in_offsets(0);
sysfs_in_offsets(1);
sysfs_in_offsets(2);
sysfs_in_offsets(3);
sysfs_in_offsets(4);
sysfs_in_offsets(5);
sysfs_in_offsets(6);
sysfs_in_offsets(7);
sysfs_in_offsets(8);



These all addressed :
> No blank line here please.
>
>   
> Nor here.
>
>   
> And no comma here.
>   
>
> Mark and I went for _group_opt and _attributes_opt suffixes. It's of
> course arbitrary, but maybe you can do the same for consistency?
>   

> This should be inside the if (data) conditional - subclients have no
> sysfs files.
>
>   
>
> Care to respin a patch? I'd like to have all these fixes in -mm soon.
>
> Thanks,
>   

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-unchecked-return-status-fixes-w83781d.patch
Type: text/x-patch
Size: 15978 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060921/4f41ee3c/attachment-0001.bin 
