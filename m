From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Dec 2010 22:50:19 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: sysfs ABI updates
Message-Id: <20101217235019.250649f6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292434586-7283-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1292434586-7283-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 17 Dec 2010 14:47:11 -0800, Guenter Roeck wrote:
> On Fri, Dec 17, 2010 at 04:40:36PM -0500, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Wed, 15 Dec 2010 09:36:26 -0800, Guenter Roeck wrote:
> > > Add attributes supported by various PMBus devices to hwmon sysfs ABI.
> > > 
> > > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > ---
> > > v2 changes:
> > > Removed power[1-*]_alarm description from power section. Refer to alarms
> > > section instead.
> > > Added power[1-*]_cap_alarm.
> > > 
> > >  Documentation/hwmon/sysfs-interface |   40 ++++++++++++++++++++++++++++------
> > >  1 files changed, 33 insertions(+), 7 deletions(-)
> > > (...)
> > 
> > Looks alright to me, feel free to add to your hwmon tree.
> > 
> hwmon or hwmon-next ? 

hwmon-next seems more reasonable, as we're already late in the .37
cycle and Linus wants to keep rc patches small.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
