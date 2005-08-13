From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sat, 13 Aug 2005 07:17:07 +0000
Subject: [lm-sensors] wrong temperature values
Message-Id: <25381867050812221677f33dcb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1123669211.4125.7.camel@localhost.localdomain>
In-Reply-To: <1123669211.4125.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan,

> > On 8/10/05, jonathan <support-squid@bfinance.fr> wrote:
> > > hi ,
> > > I have installed lm-sensors with i2c, ipmi and bmcsensors modules but
> > > the sensors command give me wrong values :
> > >
<snip>
> > Well I don't think they aren't 'wrong' but they do need scaling :-)
> > (although the negative ones are strange), see the example sensors.conf
> > (http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/sensors.conf.eg)
> > for how to do so, specifically the compute lines. You will need to
> > have some idea of what they normally should be, and if your bios gives
> > you the same info you can compare with that. Also try ipmitool and see
> > what it reads, it will probably give you the same thing though.
> >
> > Yani
> 
> thanks Yani
> but I don't understand why you are telling me that I have to scale the
> result, because in the example sensors.conf it's written :
> 
> chip "bmc-*"
> #
> # You should not need compute lines here, the driver will
> # do all the conversions.
> 
> So I don't need to scale anything with thic bmc chip, no ?
> 

Good point, according to the IPMI spec the BMC threshold sensors
should return a computed/scaled value rather than the raw value, and
hence a compute line in sensors.conf would seem unnecessary.

However it seems that the theory doesn't match reality, and I often
have seen people's temperature output from bmcsensors (2.6) need
scaling, whether this is due to strange BMCs or a fault in bmcsensors.
On the system I originally ported the driver on the values are fine,
but with all the people who need to use compute lines I wonder if I'm
the one with the bad implementation. I think my new system needs the
temperatures scaled.

MDS wrote that line though (and that code) so maybe he can enlighten
us :-), any input Mark?

Thanks,
Yani
