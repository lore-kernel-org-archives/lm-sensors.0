From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 18 Nov 2010 20:31:52 +0000
Subject: Re: [lm-sensors] [RFC] [PATCH v2] ltc4215: Save the fault register
Message-Id: <20101118203152.GA27904@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1290110595-29227-1-git-send-email-RichardRetanubun@RuggedCom.com>
In-Reply-To: <1290110595-29227-1-git-send-email-RichardRetanubun@RuggedCom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 18, 2010 at 03:03:15PM -0500, Richard Retanubun wrote:
> Some bits in the fault register can be useful to differentiate
> between a planned reset (reboot) or an unplanned reset (pwr-loss).
> The EN bit can be used for this detection when a board's planned
> reboot action toggles the EN bit and cuts the regulated voltage
> (but keeping the hotswap device alive), meanwhile an unplanned
> reset (pwr-loss) will not have the EN bit set because even the
> hotswap device got powered off.
> 
> So, before clearing the fault register at boot, save the contents
> of the fault register so that other tools can use it as a forensic
> marker to differentiate events that preceeds this boot.
> 
> One proposed method to make this information available is via
> sysfs device attributes.
> ---
> Hi Ira & Guenter,
> 
> Wow, thanks for the lively discussions, I never expected this corner
> of the kernel to be so actively monitored :)
> 
> Here is the proposed V2 of the patch, allowing the values to be
> accessed via sysfs.
> 
> Now, to answer/comment on your feeback so far:
> 
> [Guenter]
> * This violates sysfs abi: 
> Well, is this not a living document/spec? Maybe my choice of path/variable
> does not map well into the existing abi, but this is not to say it cannot be
> extended, no? (I must admit I am a bit unaware of all the rules/convention of the ABI)
> 
We don't change the sysfs ABI without good reason. Sure, it is a living document,
and I have extended it myself several times. But that doesn't mean we change it easily.

[ ... ]
> 
> So here is v2; I realize this have little hope of mainlining,
> I know its an ugly hack on the sysfs ABI, if someone have an
> idea of a better sysfs path to pick, do let me know.
> 

and the "ugly hack", as you admit yourself, makes this a NACK, without even looking
at the code.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
