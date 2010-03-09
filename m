From: "Pearson, Scott" <scott.pearson@intel.com>
Date: Tue, 09 Mar 2010 18:03:31 +0000
Subject: Re: [lm-sensors] Intel(r) Quiet System Technology (QST) SDK Is Now
Message-Id: <D9E26691B3D231438C54820E5AB9FA656B9DE4FD@azsmsx501.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
In-Reply-To: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

The Intel® QST SDK is licensed under BSD 2.0. It looks like the license agreement that they put on the web page is the wrong one (I just contacted them and they are going to correct this). Download the SDK package and look at the license that is actually in the README file; it should be more to your liking...

N. Scott Pearson
S/W Architect, Intel Channel Boards Division (iCBD)
PC Client Group (PCCG), Intel Architecture Group (IAG)
Desk  503-696-7818   Cell    503-702-6412
Fax   503-696-1015   E-Mail  scott.pearson@intel.com


-----Original Message-----
From: Mark M. Hoffman [mailto:mhoffman@lightlink.com] 
Sent: Monday, March 08, 2010 6:06 PM
To: Pearson, Scott
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Intel(r) Quiet System Technology (QST) SDK Is Now Available...

Hi Scott:

* Pearson, Scott <scott.pearson@intel.com> [2010-03-08 15:23:18 -0700]:
>    In case you hadn't seen the notice, the open source release of the Intel�
>    Quiet System Technology (QST) SDK is now available. Go to
>    [1]http://software.intel.com/en-us/articles/Intel_Quiet_System_Technology_Software_Development_Kit/
>    to download both the SDK and the Programmer's Reference Manual (PRM)...

It was pointed out by an lm-sensors user earlier, yes; but thank you.

http://software.intel.com/en-us/articles/intel-quiet-system-technology-intel-qst-sdk-software-license/

I'm not a lawyer, but at a quick glance this does not look GPL compatible.
Thus, this release is of very little value to the developers on this list.

A dual license, with the second license being GPLv2 (or even BSD) would be
the most obvious way to address this problem.  I hope Intel will consider
modifying the license of this SDK so that lm-sensors devs can use it.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
