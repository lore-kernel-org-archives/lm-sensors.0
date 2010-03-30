From: "Pearson, Scott" <scott.pearson@intel.com>
Date: Tue, 30 Mar 2010 00:38:15 +0000
Subject: Re: [lm-sensors] Intel(r) Quiet System Technology (QST) SDK Is Now
Message-Id: <0D16118992D42940A6D6ED3288CE63CF0C986D0B1E@orsmsx510.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
In-Reply-To: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Gabriel,

I was on the periphery for the driver effort and certainly not privy to any of the discussions that took place regarding commitments and support, so I cannot respond well to your query. A fact of life is that we do not have enough people to do everything and we must make - sometimes painful - decisions regarding what we can and cannot commit to doing/supporting. This is one of those places where resources were put in place for a period of time but, following that, had to be committed to other tasks...

What I can tell you is that the Intel(r) Management Engine Interface (MEI) is a hardware interface that supports communications between software entities executing on the main processor and firmware entities executing on the Intel(r) Management Engine. The MEI (HECI) driver facilitates the use of this hardware interface - and that's all it does. As such, it is agnostic to the "features" of firmware entities such as Intel(r) AMT or Intel(r) QST. Upper layer software would, of course, need to understand the features and communications protocols of the particular firmware subsystems that they are communicating with but, strictly from the standpoint of the driver, the only difference from one chipset generation to another is the PCI id(s) for the MEI in the different flavor(s) of the newer generation chipset. Thus, in theory, to support (for example) the Series 5 chipset, all you should need to do is add support for the appropriate ids and you are done. If you look in the driver source at file heci.h, you will see a list of definitions for the ids that are supported. In file heci_main.c, you will see these definitions used to form a search list. Simply expand the definitions and list to include the id(s) for the missing generation(s) and you should be good to go. The ids can typically be found in the particular chipset's Specification Update document...

N. Scott Pearson
S/W Architect, Intel Channel Boards Division (iCBD)
PC Client Group (PCCG), Intel Architecture Group (IAG)
Desk  503-696-7818   Cell    503-702-6412
Fax   503-696-1015   E-Mail  scott.pearson@intel.com


-----Original Message-----
From: Gabriel C [mailto:nix.or.die@googlemail.com] 
Sent: Wednesday, March 10, 2010 8:24 AM
To: Pearson, Scott
Cc: Mark M. Hoffman; lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Intel(r) Quiet System Technology (QST) SDK Is Now Available...

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
