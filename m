From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 30 Oct 2008 02:12:19 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081030021219.GA8064@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 29, 2008 at 06:45:36PM -0700, Trent Piepho wrote:
> On Thu, 30 Oct 2008, Matthew Garrett wrote:
> > Because any interface that basically enforces integer->string->integer
> > conversion is an indication that you're already doing it wrong.
> 
> Many if not most users of the sysfs interface from userspace are doing
> int->string->int.  Yeah, 'cat' and 'echo' aren't, but most apps more
> sophisticated than that do.  So it's no more wrong than sysfs already is.

That's fine. It's an unavoidable result of one of the sysfs design goals 
being for as much as possible to be human readable. That doesn't hold 
when you're looking at kernel subsystems that are perfectly capable of 
exporting their functionality to the rest of the kernel.

> Instead of hwmon providing this stuff, sysfs could always do it.  There are a
> lot of non-hwmon attributes that could make use of it.

If you want to press for that then please feel free to do so, but it's 
not an argument I'm interested in having with upstream.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
