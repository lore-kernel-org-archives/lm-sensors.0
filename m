From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: i2cdetect -l is broken
Message-Id: <40358AAC.9090300@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for finding the problem in i2cdetect -l which
is the code in i2cbusses.c, which I wrote but am not particularly proud of.

Remember that my one and only goal was to reproduce, exactly,
what was in /proc/bus/i2c.

As we discussed before one problem is that adapter numbers don't match device
numbers.

(somewhat reviewing to make sure I understand the problem)
But in this case the simpler problem is that there is no 'name' entry
in /sys/class/i2c-dev/i2c-x/ directories.
Instead it is in /sys/class/i2c-dev/i2c-x/device/i2c-y/ directory
where x != y in the general case. Which is still fine unless a
device has more than one bus, then you don't know which 'y'.
And the i2cbusses.c code assumes only one bus.

So can we move, link, or create an additional 'name' entry in
each directory /sys/class/i2c-dev/i2c-x ??

Then we know what device it is. Problem solved.
Can this be done in sysfs?



Jean Delvare wrote:
>>It's not a sysfs issue, it's an issue with the following line in
>>i2c_add_adapter():
>>	adap->nr = nr++;
>>
>>We need to be smarter about how to number our adapters instead of just
>>picking the next number.  Something that matches the logic in
>>get_free_i2c_dev() in i2c-dev.c.
>>
>>Or we can modify i2c-dev.c to use the adapter number in it's device
>>id. But if we do that we will eventually run out of minor numbers if
>>we insert and remove adapters all of the time...
>>
>>Any opinions on which would be better?
> 
> 
> Unless solution #1 is technically awful or even impossible, I vote for
> it, mainly because of the minor runout issue you mention with solution
> #2, and also because it will bring us back to the policy we had in 2.4.
> 
> If I'm not mistaking, this basically requires that we can access the
> already registered adapters list from i2c_add_adapter(). Depending on
> the form in which it is stored, the algorithm to get the lowest
> available number will be more or less sympathetic. In get_free_i2c_dev()
> this is a simple array of pointers, all we need to look for is a NULL
> value, so the complexity is O(N). I fear it won't be that simple with
> adapters.
> 
> If you could tell me how we do access the adapters list, so that I could
> take a look...
> 
> BTW, I found something to be fixed in i2c-core:
> 
> --- linux-2.6.3-rc2/drivers/i2c/i2c-core.c.orig	Tue Feb 10 19:09:09 2004
> +++ linux-2.6.3-rc2/drivers/i2c/i2c-core.c	Sat Feb 14 09:51:55 2004
> @@ -175,7 +175,7 @@
>  		driver = list_entry(item, struct i2c_driver, list);
>  		if (driver->detach_adapter)
>  			if ((res = driver->detach_adapter(adap))) {
> -				dev_warn(&adap->dev, "can't detach adapter"
> +				dev_warn(&adap->dev, "can't detach adapter "
>  					 "while detaching driver %s: driver not "
>  					 "detached!", driver->name);
>  				goto out_unlock;
> 
> 
> Thanks.
> 
