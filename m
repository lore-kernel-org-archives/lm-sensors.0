From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 Dec 2011 19:06:59 +0000
Subject: Re: [lm-sensors] Enhancement request: fancontrol error messages to
Message-Id: <20111204200659.268a7ed4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4ED8A09B.20601@catcons.co.uk>
In-Reply-To: <4ED8A09B.20601@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 04 Dec 2011 21:48:21 +0530, Charles wrote:
> On 04/12/11 20:03, Jean Delvare wrote:
> >> > How about modifying the fancontrol script to write error messages to stderr?
> >> > 
> >> > It would be more conventional and, for example could be used to make it
> >> > less verbose -- while allowing any error messages to appear -- when run
> >> > from boot scripts  by something like:
> >> > 
> >> > fancontrol > /dev/null
> > I agree this makes sense. I've made the necessary changes, please give a try to:
> >   http://khali.linux-fr.org/devel/misc/fancontrol
> > Make sure you don't get a cached version, as I just updated it.
> > 
> > If it works OK for you, I'll commit both changes to the repository.
> 
> Thanks Jean :)
> 
> It tests OK (no output) when run by
> 
> fancontrol >/dev/null &

Thanks for the report. Patches committed:
http://www.lm-sensors.org/changeset/6000
http://www.lm-sensors.org/changeset/6001

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
