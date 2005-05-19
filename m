From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Question about algorithms
Message-Id: <3F50D7AA.4040203@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030828114654.54830ad2.khali@linux-fr.org>
In-Reply-To: <20030828114654.54830ad2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Usually a "bus" driver is a combined "algorithm" and "adapter" driver.

Where it makes sense to share the low-level "algoritm" part across multiple
"adapter" drivers these can be separated.

All "bit-banger" drivers use a common algorithm layer i2c-algo-bit,
which exports functions to directly manipulate the clock and data lines
and get the timing right. The adapter drivers in these cases
are responsible for finding the chip and the correct register locations.

Some of the other drivers in i2c are separated into algo and adap.
Some also share the algorithm driver, others I think don't really,
perhaps they were separated because of intent to share the algorithm
driver and others were just written that way.


If our explanation on this page wasn't clear feel free to enhance :)


http://www2.lm-sensors.nu/~lm78/docs.html



Jean Delvare wrote:
> Hi all,
> 
> Could someone please explain to me what i2c-algo-* are for? I understand
> what bus drivers and chip drivers are and work together, but I can't
> figure out how and where the algo files do work with the first two.
> 
> Also, what are the i2c-adap-* files for?
> 
> Thanks.
> 
