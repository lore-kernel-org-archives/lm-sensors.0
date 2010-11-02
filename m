From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Nov 2010 14:29:23 +0000
Subject: Re: [lm-sensors] [RFC v2] Support of chassis intrusion detection
Message-Id: <20101102152923.6de80c44@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310170340.4c63de39@hyperion.delvare>
In-Reply-To: <20090310170340.4c63de39@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2 Nov 2010 07:04:56 -0700, Guenter Roeck wrote:
> On Tue, Nov 02, 2010 at 09:21:02AM -0400, Jean Delvare wrote:
> > Hi Fred,
> > 
> > Please don't top-post.
> > 
> > On Tue, 12 Oct 2010 09:15:03 +0200, Fred . wrote:
> > > I am sorry tha I do not have the nescesary equipment nor skill set in
> > > order to be able to help test
> > > or contribute with code.
> > > 
> > > Now since the interface definition is upstreams, I hope that someone
> > > may implement the feature
> > > in at least one of the drivers.
> > 
> > This is done now: the new w83795 hardware monitoring driver implements
> > the standard intrusion detection interface.
> > 
> > I have written user-space code to use that interface. I have two
> > patches, one for libsensors, one for sensors, both apply on top of
> > lm-sensors SVN, if anyone wants to give them a try. I've attached them.
> > They work OK for me, I'll commit them soon unless someone finds and
> > reports a problem with them.
> > 
> > Then we will have to convert the remaining drivers. I found 3 drivers
> > which need to be converted: adm9240, w83792d and w83793. If there are
> > more, please let me know.
> > 
> Reminds me. I have a set of patches for those almost ready for submission.
> Hope you didn't do the same work ;).

I just did :( I should have read my mail earlier. Well at least we'll
see if we agree on what needs to be done and how to do it.

> 
> Code below looks ok.

Thanks for the review.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
