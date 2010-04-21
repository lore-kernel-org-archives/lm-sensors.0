From: Daniel Mack <daniel@caiaq.de>
Date: Wed, 21 Apr 2010 12:10:03 +0000
Subject: Re: [lm-sensors] [RFC PATCH 09/10] lis3: Scale output values to mg
Message-Id: <20100421121003.GQ30801@buzzloop.caiaq.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Samu,

On Tue, Nov 03, 2009 at 01:30:07PM +0100, samu.p.onkalo@nokia.com wrote:
> Date: Tue, 3 Nov 2009 13:30:07 +0100
> From: samu.p.onkalo@nokia.com
> To: daniel@caiaq.de
> CC: eric.piel@tremplin-utc.net, kalhan.trisal@intel.com,
> 	lm-sensors@lm-sensors.org
> Subject: RE: [RFC PATCH 09/10] lis3: Scale output values to mg
> Message-ID: <62697B07E9803846BC582181BD6FB6B8256DACE233@NOK-EUMSG-02.mgdnok.nokia.com>
> 
> >On Tue, Nov 03, 2009 at 02:09:44PM +0200, Samu Onkalo wrote:
> >> Report output values as 1/1000 of earth gravity.
> >
> >Without having tried that, I assume that changes the values 
> >for all events reported? That would break all userspace 
> >clients of this device, right?
> >
> 
> Yes. That is one thing which need to agreed here. One possibility is to
> implement this as a configurable feature for example using platform data.
> In that kind of solution default value must be the old way.

This hits us now in user space applictions. No big deal, we will just
change our parsers. But I wonder whether you have a fix factor at hand
to apply here for calculation? I'm too lazy to reverse all the thinking
behind the conversion in order to get that number ;)

Thanks,
Daniel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
