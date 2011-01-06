From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 06 Jan 2011 18:10:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add humidity attribute to sysfs ABI
Message-Id: <1294337423.9786.62.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294329642-9282-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1294329642-9282-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-01-06 at 12:48 -0500, Jonathan Cameron wrote:
> On 01/06/11 16:50, Guenter Roeck wrote:
> > On Thu, Jan 06, 2011 at 11:33:00AM -0500, Jean Delvare wrote:
> >> On Thu, 6 Jan 2011 08:00:42 -0800, Guenter Roeck wrote:
> >>> The humidity attribute is already supported by the sht15 driver, and another
> >>> driver supporting it is about to be added. Make it official.
> >>>
> >>> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> >>> ---
> >>>  Documentation/hwmon/sysfs-interface |    9 +++++++++
> >>>  1 files changed, 9 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> >>> index 5997b5e..033fe76 100644
> >>> --- a/Documentation/hwmon/sysfs-interface
> >>> +++ b/Documentation/hwmon/sysfs-interface
> >>> @@ -505,6 +505,15 @@ energy[1-*]_input		Cumulative energy use
> >>>  				RO
> >>>  
> >>>  
> >>> +************
> >>> +* Humidity *
> >>> +************
> >>> +
> >>> +humidity[1-*]_input		Humidity
> >>> +				Unit: percent
> >>
> >> Are you sure? The sht15 driver source code suggests millipercent.
> >> Jonathan?
> Oops, not one of my better bits of reviewing...
> >>
> > Yes, you are right. Just noticed that as well.
> > 
> > What would be the best term to use ? millipercent ? milli-percent ? per cent mille ?
> > The latter is the official term. How about 
> > 	Unit: per cent mille (pcm, milli-percent)
> could multiply values by 10 then use Permyriad :)
> Otherwise maybe just write it out clearly as 'thousandth of a percent'?

Thought about that, but "a percent" sounds odd (what is "a percent" ?),
and "thousandth of percent" may be confused with "thousands of percent".
I think I'll go with "milli-percent (per cent mille, pcm)".

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
