From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 08 Jan 2012 18:58:54 +0000
Subject: Re: [lm-sensors] next 17 checkpatch patches
Message-Id: <20120108185854.GB23747@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CACW_hTZ1cYLXJS3cpsQ8fDTrr40PqPc654892a7FRR7VNng9GA@mail.gmail.com>
In-Reply-To: <CACW_hTZ1cYLXJS3cpsQ8fDTrr40PqPc654892a7FRR7VNng9GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Sun, Jan 08, 2012 at 01:15:22PM -0500, Frans Meulenbroeks wrote:
> 
[ ... ]
> 
> Will fix, thanks for the quick reply.
> It'll take an hour or so, I need to revert all paches and regenerate the
> checkpatch output (I already nuked that one)

If you use git, "git rebase -i <baseline>" is your friend here. It gives you the list of patches
to apply in your editor. Tag every patch with "r", and you'll get the opportunity to edit
each commit message. Tag a patch with "e", and you can amend before continuing the rebase.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
