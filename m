From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: call for 2.6.6
Message-Id: <3DD93CD2.CFC84BB@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DD5999A.49A03347@paradyne.com>
In-Reply-To: <3DD5999A.49A03347@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> > > The fact that you need to have one macro for each possible number of
> > > chips associated with one driver is weird. What if there's another
> > > chip supported by adm1021? And then another again? We break the
> > > dependencies each time. Could we find some cleaner method? I have no
> > > idea for now, but there's a need.
> >
> > good idea, I don't know how either though.
> 
> Seems impossible with the C preprocessor only. We would need something
> more powerful and flexible such as m4, but I don't think we want to rely
> on one more tool.
> 
> The question I ask myself now is: "Why are these macros in the i2c tree
> while they are used only in the lm_sensors2 tree?" I guess there are
> historical reasons, and also this helps other people to create i2c
> clients
> more easily. But is it worth the dependency problem? We could define
> these macros on the lm_sensors2 side (if they are not already defined by
> some older i2c) and remove them from i2c. It doesn't cause any
> dependency problem for now (until the new i2c code reaches the kernel,
> but it will take months). And even then, what will it break? i2c clients
> we don't control, there aren't that many as far as I know.
> 
> Does it sound OK to you? (I doubt it, but who knows...)
> 

i2c-proc.[ch] were moved from lm_sensors to i2c in 2.6.0.
This allowed other drivers (particularly non-sensors drivers)
to easily use our /proc interface.

One unfortunate consequence was increased dependencies on i2c.
But I don't think we want to take i2c-proc back.

> > a) the dynamic allocations are isolated to ipmi. Our core code is
> > stable. new drivers come in all the time, that doesn't make the
> > existing drivers or core code unstable.
> Agreed.
> 
> > b) is my opinion. I know the kernel does it - but do _most_ projects
> > do it?
> >    If I'm wrong, then let's skip 2.7 and go to 2.8.
> 
> I can't say if most do or not. Gtk+, Gimp, XMMS, SDL, Galeon do. Some
> others do, many others don't. And so many never leave the 0.x stage, we
> can't say ;) Indeed there's no obligation. Probably what matters here is
> wether i2c and lm_sensors 2.1, 2.3 and 2.5 have been considered unstable
> or not. If they have been, then 2.7, if it exists, will mean unstable,
> and we better skip it. If they have not, we are free to decide.
> 
> Anyway, if we decide to go for 2.7, I want us to explain on the download
> page that it doesn't have the unstable meaning, just in case people
> would think it has.
> 

2.1, 2.3, 2.5 were not considered unstable for us.
