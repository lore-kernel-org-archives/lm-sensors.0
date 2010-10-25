From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Oct 2010 07:30:23 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <20101025093023.5fbbd8a0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karsten,

Please keep the list Cc'd!

On Sun, 24 Oct 2010 23:52:54 +0200, Karsten de Freese wrote:
> I did run the new sensors-detect (see attached), and it did find some 
> additional stuff, indicating that I should install jc42. Is there a 
> standalone driver for this?

Now there is:
  http://khali.linux-fr.org/devel/misc/jc42/

Should work fine as long as your kernel is recent enough (2.6.26 or
later.)

> > I also see that sensors-detect suggested to use the k10temp driver,
> > which your kernel doesn't have. You can try the standalone flavor of
> > the drivers which I maintain at:
> >    http://khali.linux-fr.org/devel/misc/k10temp/
> > The accuracy of the CPU internal sensors is limited, but that's still
> > better than nothing.
>
> k10temp works perfectly on 1st try.. a small success at least!

Great :)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
