From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 May 2009 13:45:01 +0000
Subject: Re: [lm-sensors] [PATCH-tip] x86: hwmon/k8temp.c Add support for
Message-Id: <20090525154501.3f251a23@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1242979484.8796.7.camel@localhost.localdomain>
	<4A165F67.3020005@assembler.cz>
	<1242981748.10642.3.camel@localhost.localdomain>
	<1242984648.16532.3.camel@localhost.localdomain>
In-Reply-To: <1242984648.16532.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Rudolf Marek <r.marek@assembler.cz>, Ingo Molnar <mingo@elte.hu>, x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Jaswinder,

On Fri, 22 May 2009 15:00:48 +0530, Jaswinder Singh Rajput wrote:
> Atleast something is better than nothing ;-)

Sorry but you are wrong here. When it comes to hardware monitoring (or
monitoring in general), potentially wrong data is _worse_ than no data
at all, unless you additionally carry the information that the data
value may be wrong, and display it in a very visible manner. As our
sysfs interface doesn't provide any way to pass reliability information
to the reader (and I don't think it would make sense to add one), it is
better to not export data that we know can't be trusted.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
