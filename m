From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Mar 2012 19:05:13 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (w83627ehf) Fix memory leak in probe function
Message-Id: <20120312200513.3bb2e585@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331567005-13734-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331567005-13734-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 Mar 2012 18:20:13 +0000, Mark Brown wrote:
> On Mon, Mar 12, 2012 at 11:04:50AM -0700, Guenter Roeck wrote:
> 
> > The only thing I don't know for sure is if platform_set_drvdata(pdev,
> > NULL); is still needed. It doesn't hurt, though, so I don't remove it.

I checked if the devm infrastructure was doing it but it appears it
doesn't, which is why I didn't object to keeping it.

In the i2c subsystem, we have moved this to i2c-core itself, and I
would tend to think every subsystem should do the same. Or even the
driver core...

> Any driver relying on it has always been buggy, anything might happen to
> the value while the driver isn't bound.  I keep thinking we should have
> a debugging option to write random data there for unbound devices just
> in case.

Writing a random value isn't going to help you spot anything. If
anything, you'd have to write a well-defined poison value so that you
can spot problems. But then NULL is just as good a poison value as any
other - and that's what we are using today. Just, I'd prefer if every
driver didn't have to do it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
