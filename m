From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Tue, 18 Nov 2008 08:55:29 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081118085529.GF12095@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 09, 2008 at 09:54:39PM +0100, Jean Delvare wrote:
> Hi Rudolf,
> 
> On Sun, 09 Nov 2008 20:56:54 +0100, Rudolf Marek wrote:
> > Thanks for the review. I'm attaching fixed version.
> >
> > Following patch adds warning about wrong CPU temperature readouts on all fam f
> > rev f revision of CPUs.
> > 
> > Used switch statement, more code changes follows.
> > 
> > Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> I've applied it, thanks. Note that I added a "break" at the end of the
> case 0xf, otherwise it's an invitation to get things wrong in the next
> patch...

Hi Jean,

your git tree is at git://jdelvare.pck.nerim.net/jdelvare-2.6, correct?
At least that's what you have used in your pull requests.
Did you apply Rudolf's patch to this git tree?

I just want to know against which tree I need to create patches when adapting
k8temp.


Thanks,

Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
