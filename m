From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Jan 2011 18:03:20 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS620
Message-Id: <20110106190320.00f4c2e1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D0FB795.3010006@antcom.de>
In-Reply-To: <4D0FB795.3010006@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 26 Dec 2010 00:05:59 +0100, Roland Stigge wrote:
> Hi,
> 
> thanks again for your valuable feedback!
> 
> Attaching the updated patch including your proposed changes.

Do you actually need the detection function? It's pretty weak, the DS620
has no ID registers, detection can't be reliable, I'd rather not have
it at all.

(The DS1621 is detected for historical reasons, but quite frankly, it
shouldn't have been either, and we might drop that someday.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
