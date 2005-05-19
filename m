From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040214095413.52d8b492.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It's not a sysfs issue, it's an issue with the following line in
> i2c_add_adapter():
> 	adap->nr = nr++;
> 
> We need to be smarter about how to number our adapters instead of just
> picking the next number.  Something that matches the logic in
> get_free_i2c_dev() in i2c-dev.c.
> 
> Or we can modify i2c-dev.c to use the adapter number in it's device
> id. But if we do that we will eventually run out of minor numbers if
> we insert and remove adapters all of the time...
> 
> Any opinions on which would be better?

Unless solution #1 is technically awful or even impossible, I vote for
it, mainly because of the minor runout issue you mention with solution
#2, and also because it will bring us back to the policy we had in 2.4.

If I'm not mistaking, this basically requires that we can access the
already registered adapters list from i2c_add_adapter(). Depending on
the form in which it is stored, the algorithm to get the lowest
available number will be more or less sympathetic. In get_free_i2c_dev()
this is a simple array of pointers, all we need to look for is a NULL
value, so the complexity is O(N). I fear it won't be that simple with
adapters.

If you could tell me how we do access the adapters list, so that I could
take a look...

BTW, I found something to be fixed in i2c-core:

--- linux-2.6.3-rc2/drivers/i2c/i2c-core.c.orig	Tue Feb 10 19:09:09 2004
+++ linux-2.6.3-rc2/drivers/i2c/i2c-core.c	Sat Feb 14 09:51:55 2004
@@ -175,7 +175,7 @@
 		driver = list_entry(item, struct i2c_driver, list);
 		if (driver->detach_adapter)
 			if ((res = driver->detach_adapter(adap))) {
-				dev_warn(&adap->dev, "can't detach adapter"
+				dev_warn(&adap->dev, "can't detach adapter "
 					 "while detaching driver %s: driver not "
 					 "detached!", driver->name);
 				goto out_unlock;


Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
