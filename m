From: Mark Brown <broonie@sirena.org.uk>
Date: Sat, 21 Jan 2012 17:47:00 +0000
Subject: Re: [lm-sensors] [PATCH 82/82] hwmon: (wm831x-hwmon) Fix multi-line comments
Message-Id: <20120121174700.GC20505@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327017376-20466-83-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327017376-20466-83-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 21, 2012 at 09:03:05AM -0800, Guenter Roeck wrote:

I've reflowed your text into 80 columns.

> On Sat, Jan 21, 2012 at 08:31:48AM -0500, Mark Brown wrote:

> > I suspect you might not get a lot of the acks you're waiting for as you
> > didn't CC folks...

> I tried to add Cc: whenever there was a maintainer listed, but with
> that many patches I may have overlooked some. As for this one, you are
> the author, but you have not listed yourself as maintainer. Maybe you
> overlooked it, but how am I to know ?

TBH given that I wrote the driver, work for the relevant silicon vendor
and am generally pretty active it seems odd that you would see the lack
of a MAINTAINERS entry as a lack of interest.  The people who get
annoyed about getting CCed on stuff are those doing obviously generic
janatorial work rather than those who have spent time on the particular
bit of code - if you rely on MAINTAINERS you're going to miss a lot of
people.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
