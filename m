From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] 5V voltage incorrect on lm93
Message-Id: <20050310033517.GF4472@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <421E125A.7020300@earthlink.net>
In-Reply-To: <421E125A.7020300@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David:

Sorry it took me so long to get to this, I've been swamped...

* David Knierim <david_knierim@earthlink.net> [2005-02-24 12:43:54 -0500]:
> Hi,
>    I have been hunting down an issue related to the IN10 input of the 
> LM93.   I have observed that there is a rather large error between the 
> actual voltage and the voltage level displayed by sensors(1)  (~ .12V).
> 
> Please find attached a small patch that fixes this problem.   The data 
> sheet is very ambiguous and I and another engineer made the same mistake 
> calculating the voltage per DAC step the first time we read the spec sheet.
> 
> The confusion stems from an entry in the "maximum voltage" column that 
> is higher than the value in the "absolute maximum range" column.  For 5V 
> only, the value in the "register reading at maximum voltage" is for the 
> voltage in the "absolute maximum range", NOT the "maximum voltage".  Whew!

Right.  I seem to remember wondering: "why would just that one channel
have a non-linear scale?"  I should have asked you to test that one 
specifically back when I first wrote the driver.  You might also be
able to get clarification directly from NatSemi.

> I have tested this patch and it fixes the problem I just outlined. 
> This patch is against lm_sensors 2.9.0.

Thanks, I've committed it to CVS.

Regards,


-- 
Mark M. Hoffman
mhoffman@lightlink.com
