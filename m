From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: i2c-2.6.4 in kernel 2.5.32
Message-Id: <3D6E989E.2C68E179@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D6D80CA.4373486@paradyne.com>
In-Reply-To: <3D6D80CA.4373486@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

will buy surfboards tomorrow and play w/ the chip this 3-day wkend.
DMI detection is done. If Linus will take my dmi_scan kernel patch
then I can fix the #ifdefs in i2c-piix4 so that it will work
both pre- and post-patch.

phil@netroedge.com wrote:
> 
> For a second there, I thought it was lm-sensors which was included.
> Nice to get the I2C update in there in any case.
> 
> BTW- Mark, have you had a chance to play with a sample of that chip
> yet?  Also, it sounded like DMI detection was nearly complete?
> 
> Phil
> 
> On Thu, Aug 29, 2002 at 01:51:32PM -0700, phil@netroedge.com wrote:
> >
> > Wow.  Very, very cool. :')
> >
> >
> > Phil
> >
> > On Wed, Aug 28, 2002 at 10:02:50PM -0400, Mark D. Studebaker wrote:
> > > Great job Albert!
> >
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
