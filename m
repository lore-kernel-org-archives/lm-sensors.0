From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Sat, 06 Jun 2009 10:48:34 +0000
Subject: Re: [lm-sensors] [PATCH-tip] x86: hwmon/k8temp.c Add support for
Message-Id: <1244284594.2475.53.camel@ht.satnam>
List-Id: <lm-sensors.vger.kernel.org>
References: <1242979484.8796.7.camel@localhost.localdomain>
	 <4A165F67.3020005@assembler.cz>
	 <1242981748.10642.3.camel@localhost.localdomain>
	 <1242984648.16532.3.camel@localhost.localdomain>
	 <4A182B61.5010503@assembler.cz>
	 <1243339833.12303.2.camel@localhost.localdomain>
	 <4A1C08C6.7060103@assembler.cz>
	 <1243352672.31783.10.camel@localhost.localdomain>
In-Reply-To: <1243352672.31783.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: Ingo Molnar <mingo@elte.hu>, x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hello Rudolf,

On Tue, 2009-05-26 at 21:14 +0530, Jaswinder Singh Rajput wrote:
> On Tue, 2009-05-26 at 17:20 +0200, Rudolf Marek wrote:
> > Hello,
> > 
> > Sorry I disagree. Lets skip whole 10H. I failed many times to get some useful 
> > info from AMD about this issue. I'm strongly against to impose some limits which 
> > might indicate what is OK and what is not.
> > 
> 
> OK, So here is new patch after skipping 10H. I hope I will get ack
> now ;-)
> 
> Subject: [PATCH] x86: hwmon/k8temp.c Add support for AMD 11H
> 
> This patch will also work for AMD 10H. But we are skipping it as :
> 
> AMD 10H cpus reports Inaccurate Temperature Measurement:
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/41322.pdf
> Errata #319
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> ---

As per your suggestion I skipped whole 10H. Have you queued this patch
or there is still some issues left.

Thanks,
--
JSR


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
