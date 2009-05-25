From: "Rob Bloom" <Rob.Bloom@ca.flextronics.com>
Date: Mon, 25 May 2009 15:17:12 +0000
Subject: [lm-sensors] lm-sensors chip support
Message-Id: <0331509C72A4CE4F925973DC8EC98E1B0165EC68@AMSACEX2.americas.ad.flextronics.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm in a project which is looking at using lm-sensors to monitor the
following chips on various circuit boards:

- ADM1032ARMZ (temp sensor)
- MAX6639 (temp sensor)
- POWR1014A (power monitor)
- SA56004EDP (temp sensor)

I cross-checked these against the lm-sensors list of supported chips
(http://www.lm-sensors.org/wiki/Devices) and find that only the 1st one
is supported.  

Do you know if there are any plans to develop support for the latter 3
in the list?  Or, are any of these compatible with another chip that is
supported?  

If there are no plans and no compatibilities, is there documentation you
can point me to that describes a framework for adding a driver to be
supported by lm-sensors.  I'd like to consider this if this is not
difficult.  

As I understand it, there is no chip-specific code in lm-sensors; to add
support, one must add driver code into the kernel itself (ie. no code is
added to the lm-sensors domain).  Is this correct?  Is there an example
of a driver that was supported recently that I can use as an
example/framework?

Thanks for your help,
...Rob



Legal Disclaimer:
The information contained in this message may be privileged and confidential. It is intended to be read only by the individual or entity to whom it is addressed or by their designee. If the reader of this message is not the intended recipient, you are on notice that any distribution of this message, in any form, is strictly prohibited. If you have received this message in error, please immediately notify the sender and delete or destroy any copy of this message

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
