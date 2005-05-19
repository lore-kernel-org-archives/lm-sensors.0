From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: Backport i2c-ali1563.c from linux-2.6 to linux-2.4
Message-Id: <Pine.LNX.4.58.0503292012440.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE2E5499@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE2E5499@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> Do you have spare time to review my codes and give me some suggestion?
> I attached it in this mail, If you have the environment to test it, it
> will
> be too great!

For me, after quick review, it seems OK.

MODULE_AUTHOR("Patrick Mochel, Chunhao Huang");

Please add emails P.. M.. <.@..>, C... Hu... <..@.. >

And please also yours to the top of document.

It depends if others want to leave ENTER and LEAVE macros. I cant tell
you. If they do not complain after this email, leave them :)

Also I think you can safy remove lines like:
        /* dev_warn(&a->dev,"ali1563: Trying to reset busy device\n");  */
        /* modified by chunhao */
Because functionality is still same, only expressed other way for this 2.4
kernels. Could you always add ali1563 to the logs expect the KERN_DEBUG?

   printk(KERN_WARNING "ali1563: <=this helps to locate correct driver
that wrote this line to kernel log.

Please can you provide me some answers to mail about the EEPROM.
Maybe we will need to modify the driver if there are some more troubles
with driver or SMBUs host.

Thank you

Regards

Rudolf
