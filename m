From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 16 Jun 2005 19:45:10 +0000
Subject: [lm-sensors] Re: w1-dev
Message-Id: <20050616214402.2adb41ac@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506141239.28609.bgardner@wabtec.com>
In-Reply-To: <200506141239.28609.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 14 Jun 2005 12:39:28 -0500
bgardner@Wabtec.com wrote:

> Hi Evgeniy,

Hello, Ben.

> I've been toying with a dev interface for the w1 bus to allow a user-space 
> program to talk directly to a w1 slave.
> The w1 slave that I am using it with is the DS2433 (family 23 4kb EEPROM).
> The examples in the documentation refer to that chip.
> 
> The dev interface accepts a string as a series of w1 commands.
> You then read back the results.
> Documentation is included in the patch.
> 
> Although it works, I don't think it is quite ready to be considered 'done'.
> There are a few areas that I am not comfortable with: locking, reference 
> counts, etc.
> 
> If you (or anyone else) would like to play with it, feel free to do so.
> 
> The patch is against the latest set of w1 changes that we did.

Sorry for long delay.

I did not studied it quite enough yet to say about locking, 
though access to notify methods is suspicious.

And I have at least three comments:
 - there is kernel policy to not include new functionality without
it's users, so you need to push eeprom driver into w1 subsystem :)
 - I want to move w1 notifications to kernel connector, when it will be
put into mainline (if it will be), so notification part of w1
and new dev interface could be much simplified with it.
 - I personally hate strings :), I do not insist, but why 
strings, but not binary data, like i2c does?

> Thanks,
> Ben


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
