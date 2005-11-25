From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 25 Nov 2005 17:57:09 +0000
Subject: [lm-sensors] +5V line... and Stdby fixable?
Message-Id: <20051125165654.GD9425@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b0511180346s58c38f67p465b9e2adad74bc@mail.gmail.com>
In-Reply-To: <ea9ff50b0511180346s58c38f67p465b9e2adad74bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Filip:

* Filip Tsachev <filip.tsachev@gmail.com> [2005-11-23 16:05:08 +0200]:
> I really want to thank you guys (Jean, Rudolf), you were so helpful
> and the work you're doing for non-profit is awesome!
> 
> About that "hddtemp" (http://freshmeat.net/projects/hddtemp/) tool,
> can it be included somehow? I'm *not* fully aware of GPLs and stuff
> but maybe it is a good idea to have it *build-in* when you type
> sensors to show even hdd temp?

It's not a good fit technically. E.g. smartmontools needs root privs
to read the disk temps.  I imagine hddtemp does also; I've never used
it.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

