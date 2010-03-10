From: Gabriel C <nix.or.die@googlemail.com>
Date: Wed, 10 Mar 2010 15:25:14 +0000
Subject: Re: [lm-sensors] Intel(r) Quiet System Technology (QST) SDK Is Now
Message-Id: <4B97C7AE.80106@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
In-Reply-To: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09.03.2010 19:56, Pearson, Scott wrote:

> No problem. At the same time, I also wanted to make you are aware of some other changes that occurred in conjunction with this SDK release...
> 
> In many desktop motherboards that utilize the just-released 5 Series chipset, version 2.0 of the Intel(R) Quiet System Technology (QST) firmware

> is included. Within this firmware, we significantly revamped the command packet protocol that is used for communicating with and querying Intel(R) QST. 

> Any support that you may have implemented for the Intel(R) 965, Intel(R) 3 Series and/or Intel(R) 4 Series chipsets will not work with the new firmware. 

> Within the SDK, we have included a compatibility layer that will allow software that is written to use the new 2.0 command protocol to also support the 
> older chipsets and firmware versions. Since we have provided the full source for this compatibility layer in the SDK (the SDK actually contains no binaries; 
> everything is in source form), you should be able to move to the new protocol - and still retain support for the legacy chipsets - quite easily...

> 
> Let me know what questions you have...
> 


Hi Scott,

I think in first place we need an HECI driver for Linux ?:)

There isn't any 'officially' HECI support for Linux at all. Last release from openamt is back in 2008 and broken 
( and even patched up to work somewhat it does not support AMT 6.0 probably not even all of AMT 5 features ).. 

Last commit to openamts source tree is 17 months back and it seems any development on this stopped.(?)

Also 'heci' was in the staging tree of the kernel for a short time but since no-one from Intel cared it was removed.
See : http://lkml.org/lkml/2009/9/3/3

What is the status of the HECI driver(s) for Linux please ? I mean this situation is somewhat weird.. Now the SDK is there but the HECI driver(s) .. heh
 

> N. Scott Pearson
> S/W Architect, Intel Channel Boards Division (iCBD)
> PC Client Group (PCCG), Intel Architecture Group (IAG)
> Desk  503-696-7818   Cell    503-702-6412
> Fax   503-696-1015   E-Mail  scott.pearson@intel.com

Best Regards,

Gabriel C

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
