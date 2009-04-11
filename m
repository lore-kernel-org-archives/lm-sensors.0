From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 11 Apr 2009 11:25:27 +0000
Subject: Re: [lm-sensors] AMD 10h core temperatures
Message-Id: <49E07E27.30802@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <49DE2B23.90900@aei.mpg.de>
In-Reply-To: <49DE2B23.90900@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Unless I made some mistake in the overview the temps looks like very similar to 
reported IPMI ones right?

So far all fam10h CPUs have same bug making the temps via the k8temp driver 
inaccurate. It might work for you it might not. This is the reason why is still 
there no driver.

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
