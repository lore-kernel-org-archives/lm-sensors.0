From: Kevin Lo <kevlo@kevlo.org>
Date: Sat, 01 Dec 2007 09:01:36 +0000
Subject: Re: [lm-sensors] [PATCH] Driver for Winbond W83L786NG/NR
Message-Id: <1196499696.6417.22.camel@monet>
List-Id: <lm-sensors.vger.kernel.org>
References: <1188522272.5885.8.camel@monet>
In-Reply-To: <1188522272.5885.8.camel@monet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Kevin Lo wrote:
> Jean Delvare wrote:
> > Hi Kevin,
> 
> Hi Jean,
> 
> > On Mon, 26 Nov 2007 09:38:54 +0800, Kevin Lo wrote:
> > > On Sun, 2007-11-25 at 13:39 +0100, Jean Delvare wrote:
> > > > On Fri, 23 Nov 2007 09:31:52 +0800, Kevin Lo wrote:
> > > > > Here is the revised patch which fixes the issues that you mentioned.
> > > > > 
> > > > > Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> > > > 
> > > > Dave, can you please test this new iteration of Kevin's driver and
> > > > confirm that it works fine for you?
> > > > 
> > > > The patch is here if you're not subscribed to the list:
> > > > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/021975.html
> > > > 
> > > > Kevin, did you test your driver with lm-sensors 3.0.0?
> > > 
> > > No, but I tested my patch with lm-sensors 2.10.5, it worked fine. 
> > 
> > I don't get it. For lm-sensors 2.10.5, you need chip-specific code for
> > every new driver, and there's no such code for the W83L786NG yet. So I
> > don't quite see how you could have tested it. Or do you have a patch
> > for lm-sensors that adds support? If so, please post it so that it can
> > be reviewed and applied.
> 
> First off, sorry for the confusion. I had the w83l786ng driver patch for
> lm-sensors 2.10.5. I lost the patch due to my hard disk crash, that's
> why
> I didn't submit it :-( 
> 
> > Anyway, lm-sensors 3.0.0 only supports the standard kernel interface,
> > so it is a very interesting test to make sure that your driver
> > implements the standard interface properly. Please give it a try.
> 
> I'll try lm-sensors 3.0.0 in a couple of days, thanks.

Hi Jean,

I tested lm-sensors 3.0.0, it works fine for me :-)

> > Thanks,
> > -- 
> > Jean Delvare
> 
> Regards,
> Kevin.

	Kevin


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
