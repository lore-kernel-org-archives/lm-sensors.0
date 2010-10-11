From: Fenghua Yu <fenghua.yu@intel.com>
Date: Mon, 11 Oct 2010 15:13:00 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: fix reading of microcode
Message-Id: <20101011151259.GA4283@fenghua-desk.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CADB0A1020000780001B335@vpn.id2.novell.com>
In-Reply-To: <4CADB0A1020000780001B335@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 11, 2010 at 05:40:28AM -0700, Guenter Roeck wrote:
> On Mon, Oct 11, 2010 at 02:51:00AM -0400, Jan Beulich wrote:
> > >>> On 09.10.10 at 20:44, Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> > > Turns out the ucode revision is already available via 
> > > ucode_cpu_info[cpu].cpu_sig.rev
> > > unless I am missing something.
> > 
> > But you're not suggesting to make coretemp.ko depend on
> > microcode.ko, are you?
> > 
> I am not really suggesting anything. Personally, I think the code is just fine
> as it is. I would just like someone to Ack it before I would want to apply
> it, and I happened to notice the above while I was looking for other places
> where the microcode version is retrieved.
> 
> On the contrary, the added dependency (which I had not realized) would be
> a good argument against using ucode_cpu_info[].
> 
> Guenter
> 
Acked-by: Fenghua Yu <fenghua.yu@intel.com>

---
We can apply Jan's clean v2 patch for coretemp.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
