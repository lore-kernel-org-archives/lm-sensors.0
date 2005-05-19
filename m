From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc4 14/15]
Message-Id: <253818670505172040f303003@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051703463587a54@mail.gmail.com>
	 <253818670505171959f5cecb@mail.gmail.com>
	 <393213cd05051720137cc562b0@mail.gmail.com>
In-Reply-To: <393213cd05051720137cc562b0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Raj Gupta <gupta.raj@gmail.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

You will want to start a new thread (change the subject line) since
this post is completely unrelated to the patch it references.

As for your question I'm probably not the best person to ask, about
those topics, but if you are looking for a kernel reference
http://lxr.linux.no/ is invaluable. Linux Device Drivers 3 looks like
a good reference for driver coding too, I just bought it. Greg KH
would certainly recommend it to you since he is a co-author ;-).

Good luck,
Yani

On 5/17/05, Raj Gupta <gupta.raj@gmail.com> wrote:
> Hi,
> I am joined as reseach scholar and going to work in the feild of wireless
> technology in sensors with use of linux OS. Can someone suggest me good
> material for tutorial on linux kernel and implementation of wireless
> technology in linux middleware
> 
>  On 5/17/05, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> >
> > Oops..I caught this simple typo while compile testing the adm1026
> > patch with everything, but it looks like I forgot to update the patch,
> > here is the corrected version (just adding the missing '=' ):
> >
> > Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
> >
> > Yani
> >
> > On 5/17/05, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> > > This patch creates a new header with a potential standard i2c sensor
> > > attribute type (which simply includes an int representing the sensor
> > > number/index) and the associated macros, SENSOR_DEVICE_ATTR to define
> > > a static attribute and to_sensor_dev_attr to get a
> > > sensor_device_attribute reference from an embedded device_attribute
> > > reference.
> > >
> > > Please see the next patch to see how these can be used.
> > >
> > > Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
> > >
> > > ---
> > >
> > >
> > >
> >
> >
> >
> 
> --
> thanks and regards
> Raj Gupta
> 
> M.S. Research Scholar,
> Residence, Distributed and Object Systems Lab.,
> 545 Sector 15 - I , Department of CS & E,
> Gurgaon - 122001, INDIA IIT Madras, Chennai - 600036,
> Ph: +91-124-2301918 Tamil Nadu, INDIA
> 9840623332 Ph: x5343 (Lab)
> Email: gupta.raj@gmail.com Email: rgupta@cs.iitm.ernet.in
> 
> "Some things you just don't talk about | Hold on tight and pray for the best
> "
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
