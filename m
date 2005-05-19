From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: fan speed for it87?? chips added
Message-Id: <3F7D59AF.9CA3243C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

agreed

Greg KH wrote:
> 
> On Wed, Sep 24, 2003 at 11:10:30PM +0200, Jean Delvare wrote:
> >
> > My position is that the driver should change as few things as possible.
> > Hardware monitoring chips are a sensible realm. Enabling or disabling an
> > interrupt line or the like can cause the hardware to react (fan to full
> > speed or even shutdown) and we have had many reports that this happened.
> > So I think that the chip drivers should, by default, consider that the
> > chip is well configured for the hardware/bios settings, and initialize
> > very few things. My drivers work that way (not for the limits yet, but
> > for the rest).
> 
> I agree, this should be our policy.  Any current 2.6 drivers that
> violate this?
> 
> thanks,
> 
> greg k-h
