From: arvidjaar@mail.ru (Andrey Borzenkov)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: sensord 2.8.2 on 2.6.0/ASUS chip - subclient problem
Message-Id: <200401180012.04803.arvidjaar@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401111319.18817.arvidjaar@mail.ru>
In-Reply-To: <200401111319.18817.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 14 January 2004 05:32, Mark Studebaker wrote:
> The names of clients and the addresses of their subclients are "well known"
> so in prog/sensors/main.c we just look for them (see that file for more
> info). Your proposal to look for the string "subclient" will work equally
> well. Feel free to submit a sensord patch to us using either technique.

If I understood you correctly (subclient does not provide this information) 
here is patch. It simply ignores any chip that has a space in name. To my 
best knowledge every chip has single name without spaces except for special 
case of subclients (at least that what I have done in my kernel patch). If 
this is not true any more - tell so and I change it to look for "subclient" 
substring.

regards

-andrey

> mds
>
> Greg KH wrote:
> > On Sun, Jan 11, 2004 at 01:19:18PM +0300, Andrey Borzenkov wrote:
> >>I do not know if it is a sensord (should not attempt to read subclient)
> >> or kernel (does not provide sufficient information) problem. Subclient
> >> can be determined by its name:
> >>
> >>{pts/1}% for i in /sys/bus/i2c/devices/*
> >>do
> >>echo ${i:t}:$(<$i/name)
> >>done
> >>0-002d:as99127f
> >>0-0048:as99127f subclient
> >>0-0049:as99127f subclient
> >>
> >>Greg, this is supposed to be established convention now?
> >
> > I think so, yes.  I'll let the userspace people answer your other
> > questions.
> >
> > thanks,
> >
> > greg k-h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.8.2-subclient.patch
Type: text/x-diff
Size: 570 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040118/67b1eafe/lm_sensors-2.8.2-subclient.bin
