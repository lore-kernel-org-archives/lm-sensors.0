From: gtj.devel@peakin.com (George T. Joseph (development))
Date: Fri, 29 Dec 2006 03:05:39 +0000
Subject: [lm-sensors] Working on a driver for the Andigilog aSC7621
Message-Id: <22E26940476D1E48AA6F292B5316C9C3376D@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All comments welcomed David, thanks.

I actually agree and I'll go through and rename the ones that already
have established names. It does make sense in the larger picture.

george 

> -----Original Message-----
> From: David Hubbard [mailto:david.c.hubbard at gmail.com] 
> Sent: Thursday, December 28, 2006 7:44 PM
> To: George T. Joseph (development); Rudolf Marek; LM Sensors
> Subject: Re: [lm-sensors] Working on a driver for the 
> Andigilog aSC7621
> 
> Hi George,
> 
> I'm the developer for the w83627ehf driver, which has many of the same
> features as the Andigilog chips. So I don't have any influence in this
> discussion, but I'll chime in and you can ignore me if you want.
> 
> > I followed the naming conventions where I could but chose to use
> > the data sheet's names where there was nothing close or that made
> > sense.  I can change some of them if you want.
> 
> I think there are some important standards for user space tools,
> including temp1_auto_point1_pwm. Okay, maybe you picked a bad example.
> But most hardware monitoring chips are going to implement the same set
> of features in different ways. For example, the auto point for temp1.
> Since some drivers already export this file and other drivers (like
> mine) which have the functionality will export it soon (because I'm
> slow) -- it becomes much easier to write a generic tool in user space,
> like the pwmconfig script.
> 
> Just my two cents.
> 
> David
> 

