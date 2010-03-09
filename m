From: "Pearson, Scott" <scott.pearson@intel.com>
Date: Tue, 09 Mar 2010 18:56:01 +0000
Subject: Re: [lm-sensors] Intel(r) Quiet System Technology (QST) SDK Is Now
Message-Id: <D9E26691B3D231438C54820E5AB9FA656B9DE660@azsmsx501.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
In-Reply-To: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

No problem. At the same time, I also wanted to make you are aware of some other changes that occurred in conjunction with this SDK release...

In many desktop motherboards that utilize the just-released 5 Series chipset, version 2.0 of the Intel(R) Quiet System Technology (QST) firmware is included. Within this firmware, we significantly revamped the command packet protocol that is used for communicating with and querying Intel(R) QST. Any support that you may have implemented for the Intel(R) 965, Intel(R) 3 Series and/or Intel(R) 4 Series chipsets will not work with the new firmware. Within the SDK, we have included a compatibility layer that will allow software that is written to use the new 2.0 command protocol to also support the older chipsets and firmware versions. Since we have provided the full source for this compatibility layer in the SDK (the SDK actually contains no binaries; everything is in source form), you should be able to move to the new protocol - and still retain support for the legacy chipsets - quite easily...

Let me know what questions you have...

N. Scott Pearson
S/W Architect, Intel Channel Boards Division (iCBD)
PC Client Group (PCCG), Intel Architecture Group (IAG)
Desk  503-696-7818   Cell    503-702-6412
Fax   503-696-1015   E-Mail  scott.pearson@intel.com


-----Original Message-----
From: Mark M. Hoffman [mailto:mhoffman@lightlink.com] 
Sent: Tuesday, March 09, 2010 10:29 AM
To: Pearson, Scott
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Intel(r) Quiet System Technology (QST) SDK Is Now Available...

Hi Scott:

* Pearson, Scott <scott.pearson@intel.com> [2010-03-09 11:03:31 -0700]:
> The Intel(r) QST SDK is licensed under BSD 2.0. It looks like the license
> agreement that they put on the web page is the wrong one (I just contacted
> them and they are going to correct this). Download the SDK package and look
> at the license that is actually in the README file; it should be more to your
> liking...

That's great news!  Thanks for your reply.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
