From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Mar 2008 16:26:17 +0000
Subject: Re: [lm-sensors] No sensors found >2.6.21, w83627hf, ICH6
Message-Id: <20080305172617.517dcd3e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47CD5B89.1070302@gmx.de>
In-Reply-To: <47CD5B89.1070302@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 05 Mar 2008 17:09:02 +0100, Stefan Sassenberg wrote:
> Bad news for me:
> 
> Probing for `Analog Devices ADT7467 or ADT7468'...          Success!
>      (confidence 7, driver `to-be-written')

No driver yet and nobody working on it as far as I know - but in the
meantime you may try forcing the lm85 driver, with chip type adm1027,
you should get some basic results.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
