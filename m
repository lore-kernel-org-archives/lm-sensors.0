From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 13 Sep 2011 13:45:37 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110913134537.GA26781@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 13, 2011 at 09:28:26AM -0400, R, Durgadoss wrote:
> Hi Guenter,
> 
> > > The temp1_max is supposed to be more than temp1_input and
> > > temp1_max_hyst is supposed to be lesser than temp1_input.
> > > By default the temp1_max_hyst is left at 0.
> > >
> > Should be set to something useful. Also, it does not have to be less
> > than temp1_input, as long as it is less than temp1_max (which was my
> > understanding). Worst case you would get another interrupt (when the
> > temperature crosses temp1_max_hyst from below) which you would ignore.
> 
> Yes. I agree with you.
> I have no clue on what exact value to set to max and max_hyst initially.
> Can we set temp1_max to 70 and temp1_max_hyst to 50 ?
> 
Some constant below Tjmax for each ? Old value for max was 20 C below Tjmax,
as far as I recall. Maybe another 10 C less for max_hyst.
That would make it (64, 74, 94) for my Xeon which seems to make sense.

Jean, any suggestion ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
