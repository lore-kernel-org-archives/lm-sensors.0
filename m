From: dtor_core@ameritech.net (Dmitry Torokhov)
Date: Sun, 22 May 2005 03:59:09 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <200505212058.14851.dtor_core@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050519213551.GA806@kroah.com> <v0eBIb5C.1116575188.8501740.khali@localhost> <25381867050520015339f02e9b@mail.gmail.com>
In-Reply-To: <25381867050520015339f02e9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, Yani Ioannou <yani.ioannou@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, greg@kroah.com, LKML <linux-kernel@vger.kernel.org>

On Friday 20 May 2005 03:53, Yani Ioannou wrote:
> On 5/20/05, Jean Delvare <khali@linux-fr.org> wrote:
> > 
> > Hi Greg,
> > disabled. While this feature was almost not used so far, I think we
> > should have the driver not create interface files for disabled inputs.
> > In the case of temperature channels which can be dynamically enabled and
> > disabled. it would even make sense to dynamically create and delete
> > related sysfs files. Doing so would allow for memory savings and would
> > also be less error-prone for the user (presenting an interface for
> > disabled features is quite confusing IMHO).
> 
> If you think more than a few hwmon/chip drivers will benefit from
> dynamically creating the attributes, then maybe we can create some
> standard method for doing so, bmcsensors of course needs to
> dynamically allocate things, so I'd be using them too.
> 
> An earlier idea was to create a standard sysfs function(s) for
> dynamically creating device_attributes (and others), but now we will
> have custom structures with an embedded device_attribute, it looks to
> me like each attribute type would require it's own function.
>

I really think that as far as I2C subsystem goes instead of creating
arrays of attributes we should move in direction of drivers registering
individual sensor class devices. So for example it87 would register
3 fans, 3 temp, sensors and 8 voltage sensors...
 
-- 
Dmitry
