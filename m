From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 24 Feb 2015 18:51:18 +0000
Subject: Re: [lm-sensors] IT8620E/IT8623E vs. IT8603E
Message-Id: <20150224185118.GB15390@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140316120945.4dc8b28c@endymion.delvare>
In-Reply-To: <20140316120945.4dc8b28c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 24, 2015 at 12:50:43PM +0100, Jean Delvare wrote:
> On Tue, 18 Mar 2014 09:39:02 +0100, Rudolf Marek wrote:
> > Asus has no information about IT8620E.
> 
> For the record: the IT8620E turns out to be a custom chipset made by
> ITE for Gigabyte, so it is no surprise that Asus had no information
> about it. It also explains why the part number doesn't show up on ITE's
> website.
> 
Do we know enough about the chip to add support for it ?

I have a patch adding experimental support for it, but of course
there is a lot of guesswork involved.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
