From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: call for 2.6.6
Message-Id: <3DD7ECCB.E6BD710E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DD5999A.49A03347@paradyne.com>
In-Reply-To: <3DD5999A.49A03347@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> (Resending.)
> 
> > > I don't know about the adm1021 module. What would it cost not to use
> > > the SENSORS_INSMOD_8 thing?
> > It was added for mc1066 support in adm1021. The only way around it
> > is to combine support for some of the 8 different chips and report
> > only 7 different chip types max.
> OK I get it. This workaround isn't acceptable IMHO (makes things more
> complex to understand with no benefit except the dependency issue).
> 
> The fact that you need to have one macro for each possible number of
> chips associated with one driver is weird. What if there's another chip
> supported by adm1021? And then another again? We break the dependencies
> each time. Could we find some cleaner method? I have no idea for now,
> but there's a need.

good idea, I don't know how either though.

> 
> > > Does 2.7.0 mean "developement/unstable tree" for you? I think it
> > > will sound like that for almost everyone, including me. And if this
> > > means less support issues, it also means less feedback IMHO, so it's
> > > worth discussing.
> > Doesn't mean unstable to me. We don't use the odd/even system, we've
> > been stable for years :)
> 
> Well, the SENSORS_INSMOD_42 issue together with the need for dynamic
> allocations for bmcsensors makes me think that we could want a 2.7.0
> release, with the unstable meaning associated. Try to move back to
> cleaner code (I read that there are a lot of hacks in the recent code
> you commited, right?), even if it means a one-on-one dependency between
> i2c and lm_sensors releases for some time. When we're OK, we move to
> 2.8.0. Simple suggestion of course, my knowledge of the code and
> possibilities to enhance it is really thin. If there is no way to clean
> the code or you don't think we (globally) have the time/manpower
> required to do so, we keep the things the way they are.
> 

Well, I disagree a) that we are unstable, and b) that it is prevailing
usage
in the linux community that odd numbers imply unstable.

a) the dynamic allocations are isolated to ipmi. Our core code is
stable.
   new drivers come in all the time, that doesn't make the existing
drivers
   or core code unstable.

b) is my opinion. I know the kernel does it - but do _most_ projects do
it?
   If I'm wrong, then let's skip 2.7 and go to 2.8.
