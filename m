From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Feb 2009 10:53:22 +0000
Subject: Re: [lm-sensors] Does lm-sensors support chassis intrusion for
Message-Id: <20090217115322.7e9b0823@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f188924b0902150713q43addf9g94851a4d581b411e@mail.gmail.com>
In-Reply-To: <f188924b0902150713q43addf9g94851a4d581b411e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

Once again: please keep the mailing list Cc'd.

On Tue, 17 Feb 2009 02:14:02 +0100, Fred . wrote:
> On Mon, Feb 16, 2009 at 10:43 AM, Jean Delvare <khali@linux-fr.org> wrote:
> >> Does lm-sensors support this feature on my motherboard/superio?
> >
> > Not yet.
>
> Then why does it say that lm-sensors does support chassis intrusion?
> Source: http://www.lm-sensors.org/wiki/ProjectInformation
> Or is that just for the old lm-sensors 2 or something?

This is indeed a leftover from the lm-sensors 2 era. I've just fixed
that, thanks for reporting.

> When will lm-sensors have support for chassis intrusion?
> I hope soon. Please add support for it.

Spare time doesn't grow on tree, you know? It will take some time to
properly implement that, and it's not the most popular feature out
there (most probably because you need a case with a micro-switch and
most cases out there do not have one.)

I have created a ticket in our support system:
http://www.lm-sensors.org/ticket/2370

What do you have to offer? 

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
