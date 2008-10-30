From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Thu, 30 Oct 2008 20:16:37 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081030201637.GA29976@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 30 Oct 2008, Jean Delvare wrote:
> On Wed, 29 Oct 2008 18:45:36 -0700 (PDT), Trent Piepho wrote:
> > On Thu, 30 Oct 2008, Matthew Garrett wrote:
> > > On Wed, Oct 29, 2008 at 04:33:19PM -0700, Trent Piepho wrote:
> > >> On Wed, 22 Oct 2008, Matthew Garrett wrote:
> > >>> Mnf. I'm not convinced general kernel upstream would be enthusiastic.
> > >>
> > >> Any reason for that?
> > >
> > > Because any interface that basically enforces integer->string->integer
> > > conversion is an indication that you're already doing it wrong.
> 
> I wholeheartedly second Matthew here. Making the string-based sysfs
> interface available to the kernel would certainly be easy, but that
> would be damn inefficient. If we have to do that then let's do it right.

I third it, and it is extremely bad taste, so I would hate to see the Linus
special on that one if he noticed it before/while pulling.

ACPI almost introduced some integer->string->integer APIs like this, and it
was changed _really_ fast...

> > Instead of hwmon providing this stuff, sysfs could always do it.  There are a
> > lot of non-hwmon attributes that could make use of it.
> 
> If sysfs ever offers a facility for this then yes, the hwmon subsystem
> should be converted to make use of it.

Agreed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
