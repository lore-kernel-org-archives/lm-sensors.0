From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 21:09:28 +0000
Subject: Re: [lm-sensors] [PATCH] hdaps - switch to using input-polldev
Message-Id: <20070525230928.3c9863b3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200705250038.35585.dtor@insightbb.com>
In-Reply-To: <200705250038.35585.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 May 2007 08:33:07 -0400, Dmitry Torokhov wrote:
> Hi Jean,
> 
> On 5/25/07, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi Dmitry,
> >
> > On Fri, 25 May 2007 00:38:34 -0400, Dmitry Torokhov wrote:
> > > Not tested - no hardware...
> >
> > Neither do I. Please send these patches to the maintainers of the
> > affected drivers, I don't think they are reading the lm-sensors list
> > (which wasn't the best list for these patches anyway, as they affect
> > the input functions, not the hardware monitoring functions):
> 
> What list do you think would suit better? LKML? I doubt they read
> linux-input either...

I'd say linux-input + Cc to the driver maintainer.

> > hdaps -> Robert Love
> 
> Will do.
> 
> > ams -> Stelian Pop
> 
> Check.

Sorry, I missed that. I stupidly assumed that the other patches were
looking the same as the first one.

> > applesmc -> Nicolas Boichat
> 
> Check. But for some reason Nicolas always bounces by email. ;(

Strange, it works for me. I'll forward your post to him to make sure.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
