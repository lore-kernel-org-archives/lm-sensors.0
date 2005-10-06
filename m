From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 06 Oct 2005 11:57:55 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <fqsd8T9n.1128591999.3452220.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Andrew,

> > The conditional would not be needed if you were using an s8 to store the
> > value rather than an u8.
>
> Unfortunately two of the temperatures are stored in variables also
> used for the voltage inputs, which are unsigned when being used for
> that function.  Should these variables be a union of an s8 and a u8?

Good point, I had missed that. Using a union would be technically correct
but would make the code somewhat more complex. I guess you can keep
things as they are.

> In fact, I may be missing something obvious, but why does the code
> maintain all these variables and read all the chip registers every time
> any value is read?  Wouldn't it be more efficient to just read the
> register that was actually requested?

All hardware monitoring drivers work that way because some chips stop
monitoring when they are accessed for register I/O. If we were reading
all registers individually, it could happen that the chip can never
actually refresh the monitored values. Using burst reads solve the
problem. Additionally, as any user can read the monitored values through
sysfs, we have to cache them, else any random user could saturate the
bus by continuously reading from these sysfs files, causing a DoS.
Caching is easy with burst reads, but would be much more complex with
individual reads.

Note that burst reads with caching does not really cause much loss over
individual reads. Most of the time, you want to read all the values at
the same time anyway (when you run "sensors" for example), so the
first request will trigger the burst read, the cache will be refreshed
if needed, and all other values will be read from the cache.

Also note that some drivers (lm85 at least) split the registers into two
groups with separate cache expiration delay. I think this is a good idea
for I2C/SMBus chips with many registers, as it spares some bus bandwidth
and speeds up the readings refresh operation.

--
Jean Delvare
