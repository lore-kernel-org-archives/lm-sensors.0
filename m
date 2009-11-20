From: Clemens Ladisch <clemens@ladisch.de>
Date: Fri, 20 Nov 2009 11:56:50 +0000
Subject: Re: [lm-sensors] [PATCH v2] k10temp: temperature sensor for AMD
Message-Id: <4B068402.7020606@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AF91F70.10106@ladisch.de>	<4B06501B.8080509@ladisch.de>	<87ws1l5wcl.fsf@depni.sinp.msu.ru>	<4B0673D7.5010006@ladisch.de> <20091120123016.19d98ab4@hyperion.delvare>
In-Reply-To: <20091120123016.19d98ab4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Serge Belyshev <belyshev@depni.sinp.msu.ru>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Jean Delvare wrote:
> On Fri, 20 Nov 2009 11:47:51 +0100, Clemens Ladisch wrote:
> > v2: Erratum 319 now results in a warning, not an error, because it cannot
> >     be reliably detected; Serge Belyshev reports that his CPU sensor works.
> 
> Nack. Unreliable sensors -> the default must be to NOT bind to these
> CPUs. ... Otherwise your driver will _never_ make it into the
> kernel tree.

Then how did the k8temp driver make it into the kernel tree?  :-)

> Feel free to provide a way to force the bind to happen (and still
> print a big fat warning that this is a very bad idea), but do NOT make
> it the default. 

Okay, I'll add a force parameter.
I'd guess k8temp should get the same?


Best regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
