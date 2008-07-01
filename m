From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 01 Jul 2008 16:47:48 +0000
Subject: Re: [lm-sensors] Call for 2.10.7
Message-Id: <20080701184748.3e789496@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080623132019.549ae84e@hyperion.delvare>
In-Reply-To: <20080623132019.549ae84e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Jun 2008 20:23:04 -0700, Philip Edelbrock wrote:
> 
> On Jun 23, 2008, at 8:50 AM, Jean Delvare wrote:
> 
> > Thinking about it some more, it would probably be better if lm-sensors
> > 2.10.7 was released before kernel 2.6.26. And kernel 2.6.26 could be
> > released soon, as we're at RC7 already. So maybe the following  
> > schedule would be better:
> >
> > * June 25th: SVN freeze
> > * June 26th-30th: testing
> > * July 1st: release
> >
> > This is admittedly tight but OTOH there's little activity on this
> > legacy branch so I do not expect much problems (and I doubt a looser
> > schedule would help find more bugs anyway.)
> >
> > Phil, would that be OK with you? I can do the release if you are busy
> > but you're still the one signing the 2.10.x packages.
> 
> I should be just back from a trip then and be able to handle the  
> release.  I'll put it on my calendar.

OK, I'm done with testing, I think we are ready to release.
libsensors version needs to be bumped to 3.1.6.
i2c needs not be released (only one, minor change.)

Phil, please release as your schedule permits.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
