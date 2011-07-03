From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 03 Jul 2011 17:42:44 +0000
Subject: Re: [lm-sensors] Call for 3.3.1
Message-Id: <20110703174244.GA16277@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110703141426.0537b880@endymion.delvare>
In-Reply-To: <20110703141426.0537b880@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 03, 2011 at 08:14:26AM -0400, Jean Delvare wrote:
> Hi all,
> 
> According to trac [1], we're running late on the release schedule.
> There aren't many changes in the queue [2], but shipping an up-to-date
> version of sensors-detect alone seems to warrant a maintenance release
> every 3 or 4 months.
> 
> [1] http://www.lm-sensors.org/roadmap
> [2] http://www.lm-sensors.org/browser/lm-sensors/trunk/CHANGES
> 
> We will also have to replace every reference to the Linux 2.6 kernel to
> "2.6 or 3" or "2.6 or later". Volunteers welcome...
> 
> I propose the following schedule:
> * July 13th: repository freeze
> * July 14th-18th: testing and documentation updates
> * July 19th: release
> 

Hi Jean,

there is an update for sensors-detect in your review queue, and I'll another one
for for a couple of National devices after that. Would be great if you could find
the time to review the pending patch. Alternatively, I could just go ahead and commit
the changes - just let me know.

I'll see if I find the time for the 2.6->3,0 changes. No promises, though.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
