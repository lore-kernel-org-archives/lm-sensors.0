From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <oQxau3pR.1099576565.2330000.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Quoting myself:

> I don't think your analysis is correct. My feeling is that *_detect
> functions found in the client drivers should NOT return non-zero values
> on "misdetections". A misdetection is not an error per se, and
> obviously the i2c_detect function was written with that in mind. So I
> believe that the asb100 driver, not i2c_detect, would need to be fixed.

Just found the confirmation in Documentation/i2c/writing-clients:

"The detect client function
--------------------------

The detect client function is called by i2c_probe or i2c_detect.
(...)
This function should only return an error (any value != 0) if there is
some reason why no more detection should be done anymore. If the
detection just fails for this address, return 0."

So we are simply not doing the correct thing in various clients.

Thanks,
Jean
