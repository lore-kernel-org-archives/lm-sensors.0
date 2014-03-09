From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 09 Mar 2014 09:38:05 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <20140309103805.10ea3f7d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 19 Feb 2014 10:20:16 -0800 (PST), ianp wrote:
> > On Thursday, February 20, 2014 12:35 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > Yeah, I had the same problem. Ironically, having a good, stable PSU
> > makes the job harder. A crappy PSU oscillating between 5 different
> > values in the BIOS would be much better ;-)
> 
> Almost twenty minutes into just staring at the monitor, I thought about replacing the PSU with a generic unit that I have lying around here just to get it moving. But then I had an idea that maybe I could introduce a tiny ripple if I open and close my optical drive's tray. And that did the trick and gave me a quick 5.040 reading. :-)

This is a good trick, I've added it to the guide :) Thanks!

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
