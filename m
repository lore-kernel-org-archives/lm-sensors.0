From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 04 Nov 2009 19:17:42 +0000
Subject: Re: [lm-sensors] [PATCH v3 0/8] sensord: Cleanup of the
Message-Id: <20091104191741.GA4334@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Nov 04, 2009 at 10:11:12AM +0100, Jean Delvare wrote:
> Hi Andre,

Hi Jean,

> On Tue, 3 Nov 2009 21:01:44 +0100, Andre Prendel wrote:
> > Another week another patch series :)
> > 
> > There are two new patches. To make you happy I split up the change of
> > the function pointer signature into a separate patch (5/8). Patch 7/8
> > fixes the unhandled return value of idChip (see your comment in Patch
> > v2 5/8). I've ignored the strcat() issue for now (also from v2 5/8). I
> > hope I don't have missed one of the minor issues. The changes are
> > explained in the patches too.
> > 
> > BTW thanks for your effort to review my patches.
> 
> You're welcome. I've made some more minor comments, but in general I
> think your patch series is ready to be merged now. Go ahead!

I've just merged the patches with the minor changes due to your
comments.

Thanks,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
