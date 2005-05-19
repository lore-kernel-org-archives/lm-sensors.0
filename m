From: bobr@casco.net (Bob Riegelmann)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <opsa8rb6g8othr9z@mail.peak.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10898500322333@kroah.com> <10898500321009@kroah.com> <20040716170716.GD8264@openzaurus.ucw.cz> <20040716171702.GA10598@kroah.com>
In-Reply-To: <20040716171702.GA10598@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Fri, 16 Jul 2004 10:17:03 -0700, Greg KH <greg@kroah.com> wrote:

> On Fri, Jul 16, 2004 at 07:07:16PM +0200, Pavel Machek wrote:
<snip>
>> Just out of curiosity... are such devices really connected using one 
>> wire only,
>> or is it GND+5V+one data wire, or GND+power&data wire?
>
> I'm pretty sure it's just 1 wire, at least for the devices I've seen.

I work with these all the time - it's power & data one one pin, and some 
kind of a ground.  They also make some in 3 terminal packages (pinouts can 
be had on the Maxim site). That said, I'm really pleased to see this in 
the kernel - as I'm in the process of developing all the firmware to port 
one of our product to use Linux! The application guys are way ahead of me, 
however...

Enjoy

Bob Riegelmann
