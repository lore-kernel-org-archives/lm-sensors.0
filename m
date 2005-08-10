From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 10 Aug 2005 17:20:40 +0000
Subject: [lm-sensors] Using i2c for inventory/asset management.
Message-Id: <1123687188.13258.61.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
References: <42FA1706.8010608@winmutt.com>
In-Reply-To: <42FA1706.8010608@winmutt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2005-08-10 at 15:02 +0000, Rolf wrote:
> Error: No i2c-bus specified!
> Syntax: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]
>         i2cdetect -l
>         i2cdetect -V
>   I2CBUS is an integer

Did you pass an i2c bus number on the command line? If I don't then I
get this same message...

Ian.

-- 
Ian Campbell
Current Noise: Pentagram - Prayer For An Exit Before The Dead End

If you can count your money, you don't have a billion dollars.
		-- J. Paul Getty

