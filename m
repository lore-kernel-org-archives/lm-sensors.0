From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 23 May 2009 16:59:13 +0000
Subject: Re: [lm-sensors] [PATCH-tip] x86: hwmon/k8temp.c Add support for
Message-Id: <4A182B61.5010503@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1242979484.8796.7.camel@localhost.localdomain>	 <4A165F67.3020005@assembler.cz>	 <1242981748.10642.3.camel@localhost.localdomain> <1242984648.16532.3.camel@localhost.localdomain>
In-Reply-To: <1242984648.16532.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi,

Yes it works for most CPUs, but for unlucky users we might get complains from 
them - and false alarms.

I'm talking about:

http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/41322.pdf

Errata #319

So far all CPUs have the issue.

Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
