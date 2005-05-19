From: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: irq, tasklet and i2c
Message-Id: <1044356362.20631.16.camel@newt>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E3F94BE.CD95B34A@plain.de>
In-Reply-To: <3E3F94BE.CD95B34A@plain.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2003-02-04 at 10:23, Markus Schorer wrote:

> 2) i assign a buffer for a single piece of data. reading from the
> device,
> i wait in a wait queue.
> an interrupt schedules a tasklet. the tasklet read the data over i2c, 
> stores it in the buffer and does a wakeup.
> then the read process reads the data out of the buffer.
> works.

In general, it's wrong to sleep in a tasklet. As I understand it,
i2c_master_recv is allowed to sleep (I'm writing my driver on that
assumption, somebody correct me if I'm wrong). I think your first
version is superior, though if you're targeting 2.4 and 2.5 kernels then
a completion is easier than a wait queue.

If you want to do a ringbuffer, consider creating a worker thread and
using semaphores for producer / consumer scheduling.

- Adrian Cox
http://www.humboldt.co.uk/


