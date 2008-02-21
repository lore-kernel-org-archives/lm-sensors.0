From: Matt Roberds <mattroberds@cox.net>
Date: Thu, 21 Feb 2008 00:21:46 +0000
Subject: Re: [lm-sensors] adt7475 support status update?
Message-Id: <Pine.LNX.4.64.0802201818270.29092@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B32CEF.40405@hhs.nl>
In-Reply-To: <47B32CEF.40405@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 Feb 2008, Jordan Crouse wrote:
> Updated patch against HEAD is attached.  Thanks.

Something I noticed while hacking on sensors.conf: naming it adt7475
would align better with the names of most of the other chips.  In other
words, change

> static struct adt7475_chip {
> 	const char *name;
> 	struct attribute_group group;
> } adt7475_chips[ADT7475_MAX_ID] = {
> 	{ .name = "ADT7475",
> 	  .group = {
> 		  .attrs = adt7475_attrs,
> 	  }
> 	},
> };

to

 	{ .name = "adt7475",
.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
