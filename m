From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 08 Sep 2006 00:06:03 +0000
Subject: [lm-sensors] TODO: unchecked return codes from
Message-Id: <4500B3EB.10309@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060830030828.GB5104@jupiter.solarsys.private>
In-Reply-To: <20060830030828.GB5104@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Restarting the list from scratch for clarity:
>
> Done by Mark M. Hoffman:
>  o adm1021
>  o adm1025
>  o adm1026
>  o adm1031
>  o adm9240
>  o asb100
>  o lm75
>  o lm77
>  o lm78
>  o lm80
>  o lm85
>  o lm87
>  o lm92
>  o smsc47b397
>  o w83627hf
>
> Done by Jim Cromie:
>  o pc87360
>
> Done by David Hubbard:
>  o w83627ehf
>
> Done by Jean Delvare:
>  o f71805f
>  o fscher
>  o fscpos
>  o gl518sm
>  o gl520sm
>  o it87
>  o lm63
>  o lm83
>  o lm90
>
> This leaves the following list:
>  o abituguru
>  o atxp1
>  o ds1621
>  o max1619
>  o sis5595
>  o smsc47m1
>  o smsc47m192
>  o via686a
>  o vt8231
>  o w83781d
>  o w83791d
>  o w83792d
>  o w83l785ts
>
> I'd like to remind everyone that this is an easy task, just look at the
> patches submitted by either Mark of me, and do the same. So if you are
> using one of the remaining drivers, please consider converting it and
> sending the patch back to us.
>
> Thanks,
>   

heres patch for w83781d, compile-tested only.
hopefully you can find someone to test it.

---

replace many calls to device_create_file by adding them to a sysfs_group.
check return status from remaining calls to device_create_file(), which are
still needed for device-model dependent attr-files.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

---
 w83781d.c |  196 
+++++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 117 insertions(+), 79 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-unchecked-return-status-fixes-w83781d.patch
Type: text/x-patch
Size: 10015 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060907/d962e076/attachment.bin 
