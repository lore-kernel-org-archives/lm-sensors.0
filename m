From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: Patch to allow retrieval of magnitude from user space
Message-Id: <3E87CC0E.8010109@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So I'm writing my second chip driver and generating 100+ additional entries in 
lib/chips.c for my new chip (ADM1026)...

Two things annoy me...

One, is the VALUE() macro.  I don't see the point.  We never exchange anything 
but an array of long's.  Why not just have the array index (0, 1, 2, etc.).

The second is the duplicated magnitude entry.  If the magnitude changes in the 
driver or is variable ?!? we can't handle it.  But if we could make a sysctl 
call to retrieve the magnitude from user space then we wouldn't need the 
duplicated data.  So then how to retrieve the magnitude....

I got to looking at the sysctl code and I think I have an idea.  If we take 
the special case of calling sysctl to read the old values, but don't provide a 
place to put the values, then we return the (magnitude + 32) to allow for 
negative values (since oldlen is size_t and unsigned) in the supplied "length" 
buffer.  I think this will work because the old code would have done nothing 
in this case.

So here is a patch against the CVS i2c to implement this.  Once this is in 
place, I can make the more major changes to libsensors if everyone is agreed.

Even if we don't use this in libsensors, I think it's a worthwhile 
change/addition.

Thanks,
:v)

PS.  I've got a working ADM1026 driver now and I should have the libsensors 
and sensors support in a few days.


diff -ru i2c-2.7.0/./kernel/i2c-proc.c i2c-2.7.0.adm1026/./kernel/i2c-proc.c
--- i2c-2.7.0/./kernel/i2c-proc.c	Sun Nov 10 11:39:38 2002
+++ i2c-2.7.0.adm1026/./kernel/i2c-proc.c	Sat Mar 29 12:54:29 2003
@@ -465,6 +465,19 @@
  	 
	return -EFAULT;
  	}

+ 
/* Special case to retrieve the magnitude */
+ 
if( oldval = NULL && oldlenp && !((ret=get_user(oldlen, oldlenp))) ) {
+ 
	callback(client, SENSORS_PROC_REAL_INFO, table->ctl_name, &nrels, results);
+ 
	/* NOTE: nrels is an int (signed), but oldlen is
+ 
	 *    size_t (aka unsigned) so we offset the value
+ 
	 *    by adding 32.
+ 
	 */
+ 
	oldlen = nrels + 32 ;
+
+ 
	if(put_user(oldlen, oldlenp))
+ 
		return -EFAULT;
+ 
}
+
  	if (newval && newlen) {
  		/* Note the rounding factor! */
  		newlen -= newlen % sizeof(long);
