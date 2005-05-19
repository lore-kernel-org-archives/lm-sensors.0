From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: serverworks CSB6 pci info
Message-Id: <1063708941.3f66e90d1b87a@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> hello, i have read you need Datasheet or confimation of PCI ID.
> 
> so i am sending output of lspci -vv and lspci -vvn

Thanks a lot. We'll update the page.

Now, without a datasheet, the only thing we can do is add the new IDs to the
i2c-piix4 driver, and then try loading it. We suppose it could work, but are of
course not sure. We'd need a courageous volunteer. Would you by any chance be
that one? Please understand that if the CSB6 isn't compatible with the CSB5,
loading the driver would have unpredictable results, which means that the
operation should not be attempted on a sensible system such as a production server.

If you want to be our tester, let us know and we'll send you a patch to apply
and try.

Jean Delvare


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
