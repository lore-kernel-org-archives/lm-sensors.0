From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 22 Feb 2008 07:19:21 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Skip "random" I/O port
Message-Id: <20080222081921.2b7b702f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218223317.2142dc16@hyperion.delvare>
In-Reply-To: <20080218223317.2142dc16@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 22 Feb 2008 09:49:18 +1100, Benjamin Herrenschmidt wrote:
> 
> On Thu, 2008-02-21 at 11:09 +0100, Jean Delvare wrote:
> > On Thu, 21 Feb 2008 11:02:55 +0100, Christian Krafft wrote:
> > > I will try to test your patch today, but only have a little time for this.
> > > If I'm not getting it today, I'll continue next monday.
> > 
> > Note that I managed to test the SVN version of sensors-detect myself
> > (on ppc64) so I am confident that it works well now.
> > 
> > > I'm not very convinced, that this is the right solution, but as a
> > > circumvention, it will take the pressure away.
> > 
> > What do you think would be the right solution? I agree that
> > making /dev/port access safer at the kernel level is still needed. Do
> > you have anything else in mind?
> 
> "safer" how so ?
> 
> How can the kernel differenciate between valid and non valid uses of
> it ?

I was referring to the kernel patch Christian submitted earlier this
week which prevents oopses or machine checks when older versions of
sensors-detect access /dev/port in unexpected ways. My update to
sensors-detect was meant as a complement of his patch, not a
replacement.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
