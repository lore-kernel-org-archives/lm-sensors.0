From: Mark Brown <broonie@sirena.org.uk>
Date: Mon, 12 Mar 2012 18:20:13 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (w83627ehf) Fix memory leak in probe function
Message-Id: <20120312182013.GF14020@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331567005-13734-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331567005-13734-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 12, 2012 at 11:04:50AM -0700, Guenter Roeck wrote:

> The only thing I don't know for sure is if platform_set_drvdata(pdev,
> NULL); is still needed. It doesn't hurt, though, so I don't remove it.

Any driver relying on it has always been buggy, anything might happen to
the value while the driver isn't bound.  I keep thinking we should have
a debugging option to write random data there for unbound devices just
in case.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
