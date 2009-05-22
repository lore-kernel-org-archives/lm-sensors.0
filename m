From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Fri, 22 May 2009 09:42:48 +0000
Subject: Re: [lm-sensors] [PATCH-tip] x86: hwmon/k8temp.c Add support for
Message-Id: <1242984648.16532.3.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1242979484.8796.7.camel@localhost.localdomain>
	 <4A165F67.3020005@assembler.cz>
	 <1242981748.10642.3.camel@localhost.localdomain>
In-Reply-To: <1242981748.10642.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: Ingo Molnar <mingo@elte.hu>, x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Fri, 2009-05-22 at 14:12 +0530, Jaswinder Singh Rajput wrote:
> On Fri, 2009-05-22 at 10:16 +0200, Rudolf Marek wrote:
> > Hi,
> > 
> > The reason why there is no support is that the both 10h and 11h and all of them 
> > have still the errata which tells that measurements is unreliable. Has it changed?
> > 
> 
> On my 11h laptop I am getting reading from 56-70 degree C and it seems
> to correct and reliable to me.
> 
> Can you share the problem you faced with 10h and 11h, so that I can
> check on my side.

On further testing I am getting 52 - 88 degree C and I am quite happy
with these readings.

Atleast something is better than nothing ;-)

Thanks,
--
JSR


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
