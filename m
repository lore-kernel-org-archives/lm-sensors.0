From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: bmcsensors port to 2.6
Message-Id: <2538186705031521277ca98720@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FA095C015271B64E99B197937712FD02510AFF@freedom.grz.icomedias.com>
In-Reply-To: <FA095C015271B64E99B197937712FD02510AFF@freedom.grz.icomedias.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Glad to see I'm not alone, I'm going to have a good look into this
this week/weekend as soon as I get the time (working on updating the
bmcsensors patch right now).

Last time I looked briefly into it I thought the only way might be to
change the sysfs code described in device.h (where it appears the
extra parameter described in sysfs.h is removed) due to the kobject
hierarchy. I hope I was wrong though and there is some other (far more
feasible) way around it.

I'm open to suggestions from anyone who has any ideas of course :-).

Yani

On Tue, 15 Mar 2005 18:01:21 -0800, Greg KH <greg@kroah.com> wrote:
> On Sun, Mar 13, 2005 at 05:51:06PM +0100, Jean Delvare wrote:
> > So what I had been asking for some times ago, and Yani is asking for
> > again now, is an extension of the sysfs interface that would let us have
> > a single callback function for several interface files, with that
> > additional parameter, whatever form it takes. Is there a chance such an
> > extension could be accepted?
> 
> Yes, it would be accepted, as you are not the only ones asking for this
> :)
> 
> > How this would have to be done, if you already have an idea on this?
> > Or any reason why this isn't a good idea?
> 
> I don't really have any ideas about this can be implemented, because I
> really haven't given it much thought, sorry.
> 
> Good luck,
> 
> greg k-h
>
