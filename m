From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jun 2007 21:08:38 +0000
Subject: Re: [lm-sensors] VRM value in libsensors/sensors
Message-Id: <20070629230838.39cb21fa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070629134434.66d96ab3@hyperion.delvare>
In-Reply-To: <20070629134434.66d96ab3@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 Jun 2007 10:52:10 -0700, Juerg Haefliger wrote:
> On 6/29/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> > Jean Delvare wrote:
> > > Hi all,
> > >
> > > I am thinking of removing SENSORS_FEATURE_VRM from the new libsensors.
> > > A first reason for that is that the newer VRM codes as used in the 2.6
> > > kernel are arbitrary numbers and don't match the Intel specification
> > > numbers as the first ones did. So we may display things like "VRM
> > > version 1.3" and that's confusing because it doesn't correspond to
> > > anything real. A second reason is that Rudolf Marek added code to set
> > > the VRM version automatically depending on the CPU model some times ago
> > > already, and it works very well, so the users no longer have to care
> > > about VRM versions.
> > >
> > > I would even go as far as switching the vrm attribute of the hwmon
> > > kernel drivers to read-only... or even remove them entirely.
> >
> > I think that removing VRM support is a good idea, its called libsensors, so
> > lets stick to sensors.
> 
> I second that.

Just to make it clear: VRM tables _are_ related to sensors, as they are
needed to compute a voltage value from VID pin values, and this voltage
value can be used to set the Vcore channel limits. My reason for
removing it from libsensors is not that it doesn't belong there, but
that users shouldn't need to care about it, as the kernel does the right
thing automatically now.

Glad to see that everyone agrees with me, but I'd like to make sure
it's for the good reasons ;)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
