From: corbet@lwn.net (Jonathan Corbet)
Date: Fri, 26 Aug 2005 01:54:48 +0000
Subject: [lm-sensors] Re: [PATCH] drivers/hwmon/*: kfree() correct pointers
Message-Id: <20050825235354.10376.qmail@lwn.net>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: Your message of "Fri, 26 Aug 2005 00:02:31 +0200."
             <20050826000231.35b97af9.khali@linux-fr.org> 
References: <20050825214913.GA31605@mipter.zuzino.mipt.ru>
In-Reply-To: <20050825214913.GA31605@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jonathan Corbet <corbet@lwn.net>, Alexey Dobriyan <adobriyan@gmail.com>

> Already fixed in Greg's i2c tree and -mm for quite some time now...

So it is.  The comment says, however, that "the existing code works
somewhat by accident."  In the case of the 9240 driver, however, the
existing code demonstrably does not work - it oopsed on me.  The patch
in Greg's tree looks fine (it's a straightforward fix, after all); I'd
recommend that it be merged before 2.6.13.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

