From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040220223736.3eee0773.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks for finding the problem in i2cdetect -l which
> is the code in i2cbusses.c, which I wrote but am not particularly
> proud of.

It could be worse. And you're not reponsible for sysfs not providing
what procfs used to give us.

> Remember that my one and only goal was to reproduce, exactly,
> what was in /proc/bus/i2c.

Yes, I got it. Reason for it is obvious and I have to agree.

> As we discussed before one problem is that adapter numbers don't match
> device numbers.

This is the main problem for sure. I guess (hope) that Greg will take a
look someday if he has some free time?

> (somewhat reviewing to make sure I understand the problem)
> But in this case the simpler problem is that there is no 'name' entry
> in /sys/class/i2c-dev/i2c-x/ directories.
> Instead it is in /sys/class/i2c-dev/i2c-x/device/i2c-y/ directory
> where x != y in the general case. Which is still fine unless a
> device has more than one bus, then you don't know which 'y'.
> And the i2cbusses.c code assumes only one bus.

Correct.

> So can we move, link, or create an additional 'name' entry in
> each directory /sys/class/i2c-dev/i2c-x ??

This is the kind of question we want to ask to Greg (which supposes you
CC him ;)).

> Then we know what device it is. Problem solved.

This would solve the i2cdetect -l issue. Not the sensors vs. i2cdump
one, which is more important, methinks.

> Can this be done in sysfs?

I'm sure it is. The question is: how uneasy will it be?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
