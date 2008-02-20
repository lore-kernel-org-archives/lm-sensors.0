From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 20 Feb 2008 10:54:59 +0000
Subject: Re: [lm-sensors] adt7475 support status update?
Message-Id: <Pine.LNX.4.64.0802200425550.30622@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B32CEF.40405@hhs.nl>
In-Reply-To: <47B32CEF.40405@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Feb 2008, Jean Delvare wrote:
> We will have to update all the links on the wiki/Devices pages, and
> ideally we would also update the references in the source code of all
> related drivers.

One one hand, it sucks to chase pointers when one of the pointers is bad
or missing - see the general argument against sites like tinyurl.com.  On
the other hand, it might avoid some work if it was possible to give URLs
like http://www.lm-sensors.org/wiki/Devices#ali-m1533 or
http://www.lm-sensors.org/wiki/Devices#ad-adt7475 in the source code.
This way the links on the wiki could be kept up to date, which means they
wouldn't *have* to be changed in the source code so often.

> This is a non-trivial amount of work, volunteers are welcome.

Maybe I'm missing something, but how does one edit the wiki?  I can't
find the usual "edit this page" links.  Do you have to be a developer
or otherwise have an account?

A quick check of the current lm-sensors and i2c-tools code doesn't show
that many links that would need revising.  The kernel i2c drivers aren't
too bad but the hwmon drivers have lots of datasheet links.  (Quick
check, that removes some of the common non-datasheet links, was done with
grep -i -r -h http * | sed -e 's/^.*http/http/g' | grep -v 'lm-sensors\.org' | grep -v '\.gmane\.org' | grep -v oetiker | sort -u
.)

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
