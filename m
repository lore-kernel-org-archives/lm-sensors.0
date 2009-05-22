From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 22 May 2009 08:16:39 +0000
Subject: Re: [lm-sensors] [PATCH-tip] x86: hwmon/k8temp.c Add support for
Message-Id: <4A165F67.3020005@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1242979484.8796.7.camel@localhost.localdomain>
In-Reply-To: <1242979484.8796.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi,

The reason why there is no support is that the both 10h and 11h and all of them 
have still the errata which tells that measurements is unreliable. Has it changed?

Thanks,

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
