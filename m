From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 06:52:47 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks
Message-Id: <20060902085247.fbfc6512.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F1E5B6.1080105@gmail.com>
In-Reply-To: <44F1E5B6.1080105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

> On Fri, Sep 01, 2006 at 02:33:42PM +0200, Jean Delvare wrote:
> > Beyond the readability of the code, there are some performance issues
> > to consider. For example I wonder how the code above interacts with the
> > CPU cache, compared to 1-level-indexed callbacks, in the typical
> > "sensors" scenario. I don't really have the time to investigate this,
> > unfortunately. Switch/case is usually not recommended in performance
> > terms, even though I'd expect gcc to optimize it relatively nicely if
> > the "func" values are chosen wisely.
> 
> I don't really think it maters at all.  This code is not cache "hot" by
> any means.  It's doing something pretty infrequently,

Could happen once every second or every other second, if the user has a
GUI with sensors data (gkrellm, ksensors, xsensors...) I think it
qualifies as "frequent".

>                                                       and the i2c
> protocol is _so_ slow it's not funny.  These are not high-performance
> things we are dealing with at all.

Not all hardware monitoring chips are i2c-based. I agree that all hwmon
drivers do quite a lot of I/O though, be it on the SMBus or ISA bus. But
it's hardly a reason not to make the rest of the driver code smaller
and faster if we can.

> So please, don't worry about things like this in the i2c drivers, it's
> not an issue.

OK.

-- 
Jean Delvare

