From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 30 Sep 2009 19:44:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Texas Instruments
Message-Id: <20090930124426.4d4528b7.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090923_093247_088063.tomaz.mertelj@guest.arnes.si>
In-Reply-To: <20090923_093247_088063.tomaz.mertelj@guest.arnes.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomaz.mertelj@guest.arnes.si
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 23 Sep 2009 11:32:47 +0200
tomaz.mertelj@guest.arnes.si wrote:

> On Wed, 9 Sep 2009 09:34:35 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > > And then do all the real work in a common function?  Rather than
> > > expanding tens of copies of the same thing?
> >
> > Yes please. We got rid of macro-generated callbacks in most hwmon
> > drivers a couple years ago already.
> 
> Here is an incremental patch to TI amc6821 chip hwmon driver:

The patch is hopelessly wordwrapped.  Please fix and resend?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
