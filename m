From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: 2.6 - sysfs sensor nameing inconsistency
Message-Id: <20030818213112.GB3478@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307152214.38825.arvidjaar@mail.ru> <200308161938.47935.arvidjaar@mail.ru> <20030816165016.GE9735@kroah.com> <200308182049.57093.arvidjaar@mail.ru>
In-Reply-To: <200308182049.57093.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Mon, Aug 18, 2003 at 08:49:57PM +0400, Andrey Borzenkov wrote:
> On Saturday 16 August 2003 20:50, Greg KH wrote:
> > > > I like this idea, but now that the name logic has changed in the i2c
> > > > code, care to re-do this patch?  Just set the name field instead of
> > > > creating a new file in sysfs.
> > >
> > > something like attached patch? I like it as well :)
> >
> > Why rename local variables?  Your patch would be a lot smaller if you
> > just keep the same local name variable, and fix up the name strings.
> >
> 
> To make it clear for anyone porting other drivers that we are using type_name 
> and not client_name or whatever. In 2.4 every driver have both; mixing name, 
> type_name and client_name will just add to confusion.

No, we don't need both a "type_name" and a "client_name" anymore, right?
So it's just a simple "name" for the i2c client device.  "type_name" is
handled by the name of the client driver now.

> I will redo patch if you insist but I really prefer having things consistent 
> if possible.

I prefer having things make sense :)
So yes, I'd prefer if you change your patch.

I've cced the sensors mailing list to get any feedback from them.

thanks,

greg k-h
