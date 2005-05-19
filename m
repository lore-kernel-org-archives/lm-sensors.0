From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: RFC lmsensors sysfs interface documentation
Message-Id: <20050329211753.022b29c3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9kug41tbmj5kp8bmadk4t7bupgvnl15q0m@4ax.com>
In-Reply-To: <9kug41tbmj5kp8bmadk4t7bupgvnl15q0m@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> > rt[1-3] is now gone thanks to your patch to w83781d.c.
>
> Not gone upstream as far as I know, thought you'd ack it or 
> something.  

When you want Greg to pick a patch, you have to:

1* CC: him explicitely.

2* Make the subject explicit, e.g. "[PATCH 2.6] I2C: Drop useless
w83781d RT feature". In particular, drop any "RFC" or question marks in
the subject.

3* Include a nice comment and a signed-off-by line.

Unless you do that, Greg will not pick your patches.

Thanks,
-- 
Jean Delvare
