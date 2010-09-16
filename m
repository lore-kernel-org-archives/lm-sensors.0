From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Sep 2010 13:48:03 +0000
Subject: Re: [lm-sensors] [PATCH v3 0/7] hwmon: Add support for MAX6695/6696
Message-Id: <20100916134803.GD13976@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284601950-7381-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284601950-7381-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 16, 2010 at 09:32:03AM -0400, Jean Delvare wrote:
> On Thu, 16 Sep 2010 06:11:35 -0700, Guenter Roeck wrote:
> > On Thu, Sep 16, 2010 at 08:18:49AM -0400, Jean Delvare wrote:
> > > On Wed, 15 Sep 2010 18:52:23 -0700, Guenter Roeck wrote:
> > > > This patchset cleans up the lm90 driver and adds support for
> > > > Maxim MAX6695/6696 temperature sensors.
> > > 
> > > Series applied, thanks!
> > > 
> > > Please make sure wiki/Devices and sensors-detect are up-to-date.
> > > 
> > Is the patch going to make it into 2.6.36, or will it be 2.6.37 ?
> 
> 2.6.37. The merge window for 2.6.36 closed like 4 weeks ago, and none
> of these patches is fixing any bug.
> 
Ok, makes sense. Wasn't sure how the rules are for additions to existing drivers.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
