From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 May 2009 07:14:16 +0000
Subject: Re: [lm-sensors] Patch: Darwin (Mac OS X) support for decode-dimms
Message-Id: <20090515091416.75809e60@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.1.00.0905142254120.24797@fjelljo.puffin.lb.shuttle.de>
In-Reply-To: <alpine.OSX.1.00.0905142254120.24797@fjelljo.puffin.lb.shuttle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Michael,

On Thu, 14 May 2009 23:15:08 +0200 (CEST), Michael Klein wrote:
> Here's a small patch for the decode-dimms script to make it work on OS 
> X.  Instead of device nodes, the EEPROM content can be read with the 
> ioreg(8) command there.

Wrong mailing list. decode-dimms is part of i2c-tools now, bug reports
and patches should go to the linux-i2c mailing list:

http://vger.kernel.org/vger-lists.html#linux-i2c

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
