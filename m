From: greg@kroah.com (Greg KH)
Date: Fri, 01 Sep 2006 22:08:12 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks
Message-Id: <20060901220812.GB3615@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F1E5B6.1080105@gmail.com>
In-Reply-To: <44F1E5B6.1080105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 01, 2006 at 02:33:42PM +0200, Jean Delvare wrote:
> Beyond the readability of the code, there are some performance issues
> to consider. For example I wonder how the code above interacts with the
> CPU cache, compared to 1-level-indexed callbacks, in the typical
> "sensors" scenario. I don't really have the time to investigate this,
> unfortunately. Switch/case is usually not recommended in performance
> terms, even though I'd expect gcc to optimize it relatively nicely if
> the "func" values are chosen wisely.

I don't really think it maters at all.  This code is not cache "hot" by
any means.  It's doing something pretty infrequently, and the i2c
protocol is _so_ slow it's not funny.  These are not high-performance
things we are dealing with at all.

So please, don't worry about things like this in the i2c drivers, it's
not an issue.

Also, please note that cache issues are _very_ CPU specific.  Any tuning
you do for a desktop will be pretty useless for an embedded ARM board.
Embedded systems running Linux in a tiny amount of memory with small
batteries (like in phones), need to worry about these things, but even
then, it's sometimes better to make the code big, and the variables
small, recomputing things all the time.  It all depends on the
situation.

thanks,

greg k-h

