From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Mon, 25 May 2009 14:29:19 +0000
Subject: Re: [lm-sensors] [PATCH-tip] x86: hwmon/k8temp.c Add support for
Message-Id: <1243261039.3098.5.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1242979484.8796.7.camel@localhost.localdomain>
	 <4A165F67.3020005@assembler.cz>
	 <1242981748.10642.3.camel@localhost.localdomain>
	 <1242984648.16532.3.camel@localhost.localdomain>
	 <20090525154501.3f251a23@hyperion.delvare>
In-Reply-To: <20090525154501.3f251a23@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Rudolf Marek <r.marek@assembler.cz>, Ingo Molnar <mingo@elte.hu>, x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hello Jean,

On Mon, 2009-05-25 at 15:45 +0200, Jean Delvare wrote:
> Hi Jaswinder,
> 
> On Fri, 22 May 2009 15:00:48 +0530, Jaswinder Singh Rajput wrote:
> > Atleast something is better than nothing ;-)
> 
> Sorry but you are wrong here. When it comes to hardware monitoring (or
> monitoring in general), potentially wrong data is _worse_ than no data
> at all, unless you additionally carry the information that the data
> value may be wrong, and display it in a very visible manner. As our
> sysfs interface doesn't provide any way to pass reliability information
> to the reader (and I don't think it would make sense to add one), it is
> better to not export data that we know can't be trusted.
> 

As I said in my previous email that it seems problem is with few 10H
cpus and 11H are OK.

So better we will fix wrong information or suppress information for
those specific cpus.

On my 11H laptop monitoring seems very reliable. So in the worst case we
drop support for 10H.

Thanks,
--
JSR




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
