From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: lm75 question
Message-Id: <20050219190549.22ea4a98.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050219175106.F1FC523CFA@ws5-3.us4.outblaze.com>
In-Reply-To: <20050219175106.F1FC523CFA@ws5-3.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mike,

> I'm emailing because I'm starting to fear my trouble with lm75 is that
> my computer is getting long in the tooth.  My problem seems to be
> specifically with lm75 (CPU temp).  I use lm75/78 to get CPU temp/fan
> speed and mb temp/fan speed.  
> 
> I have an Asus a7m266 mb and Athlon 1900+ (both almost five years
> old).  With kernel 2.4 I'm almost positive I never had trouble with
> lm75/78.  I moved to 2.6.3 quite awhile back and am fairly sure I also
> had no/little trouble.  

You must be kidding me. The A7M266 has an AS99127F chip, which is
handled by the w83781d driver. Neither lm75 not lm78.

Just try it... (and do NOT load via686a).

-- 
Jean Delvare
