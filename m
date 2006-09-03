From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Sep 2006 06:08:02 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks
Message-Id: <20060903080802.41e2c2b0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F1E5B6.1080105@gmail.com>
In-Reply-To: <44F1E5B6.1080105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg KH wrote:
> On Sat, Sep 02, 2006 at 10:57:03PM +0200, Jean Delvare wrote:
> > The bus driver msleep()s, so it's rather an uninterruptible sleep?
> 
> Yes it is.
> 
> > Not that I know what different it makes in that context.
> 
> When you sleep in the kernel, in an uninterruptable state, it increases
> the load average spit out by the kernel by 1.  Now this really doesn't
> make that much sense, as the code is sleeping and not doing anything at
> all, but it plays havoc on tools that look at the load average of the
> machine to see what is going on.
> 
> That might be why users think the driver is taking up more cpu time than
> it really is, but it all depends on how they were measuring it.

OK, Thanks for the explanation. Isn't it possible to change the kernel
to not count sleeping processes in the load? That'd make people happier,
and the value more meaningful.

We still should convert our drivers to be interrupt-driven anyway, as
the SMBus transactions would be much faster that way. If it makes the
average load _look_ lower, it can't hurt from a marketing point of
view ;)

-- 
Jean Delvare

