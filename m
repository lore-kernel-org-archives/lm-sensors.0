From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 13 Dec 2006 22:45:19 +0000
Subject: [lm-sensors] [RFC] new MSR r/w functions per CPU
Message-Id: <4580827F.8080703@zytor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45807469.6040609@assembler.cz> <20061213221026.GF2418@redhat.com> <45807C88.6060807@zytor.com> <20061213222616.GJ2418@redhat.com>
In-Reply-To: <20061213222616.GJ2418@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Rudolf Marek <r.marek@assembler.cz>, norsk5@xmission.com, lkml <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, bluesmoke-devel@lists.sourceforge.net

Dave Jones wrote:
> 
> Can you explain this a little further? I'm fairly certain
> there are places in the kernel already doing this (or similar).
> In fact, I cut-n-pasted most of the above from similar code in the
> powernow-k8 driver.  What exactly can we deadlock on?
> 

I wanted to change the MSR driver to do the above, and Alan Cox objected 
that with realtime priority routines and/or user set affinity, that code 
might never be executed, so I retained the IPI-based code (which 
executes at the target processor at interrupt priority.)

	-hpa

