From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Nov 2009 12:18:55 +0000
Subject: Re: [lm-sensors] [PATCH v2] k10temp: temperature sensor for AMD
Message-Id: <20091120131855.7f8f8722@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AF91F70.10106@ladisch.de>
	<4B06501B.8080509@ladisch.de>
	<87ws1l5wcl.fsf@depni.sinp.msu.ru>
	<4B0673D7.5010006@ladisch.de>
	<20091120123016.19d98ab4@hyperion.delvare>
	<4B068402.7020606@ladisch.de>
In-Reply-To: <4B068402.7020606@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Serge Belyshev <belyshev@depni.sinp.msu.ru>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 20 Nov 2009 12:56:50 +0100, Clemens Ladisch wrote:
> Jean Delvare wrote:
> > On Fri, 20 Nov 2009 11:47:51 +0100, Clemens Ladisch wrote:
> > > v2: Erratum 319 now results in a warning, not an error, because it cannot
> > >     be reliably detected; Serge Belyshev reports that his CPU sensor works.
> > 
> > Nack. Unreliable sensors -> the default must be to NOT bind to these
> > CPUs. ... Otherwise your driver will _never_ make it into the
> > kernel tree.
> 
> Then how did the k8temp driver make it into the kernel tree?  :-)

For the K8 family, the history is the other way around: early models
worked fine, while later models did not. So there was no objection to
the k8temp driver initially, there really was no reason for it.

It is much harder to remove a driver from the kernel tree than to add
it. Likewise, it is much harder to reject specific models if you have
been supporting them before, because some users may see it as a
regression. This is the reason why I would like us to be much more
cautious with the family 10h CPU support than we have been for the K8
family. Let us learn from our past errors.

> > Feel free to provide a way to force the bind to happen (and still
> > print a big fat warning that this is a very bad idea), but do NOT make
> > it the default. 
> 
> Okay, I'll add a force parameter.
> I'd guess k8temp should get the same?

It would make sense, yes, even though you will get complaints from some
users.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
