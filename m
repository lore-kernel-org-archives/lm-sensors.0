From: Mathias Gerber <mathias_g@tuxedo.ath.cx>
Date: Wed, 22 Jan 2014 19:32:31 +0000
Subject: Re: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <52E01CCF.7010705@tuxedo.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
In-Reply-To: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Guenter

On 22.01.2014 19:34, Guenter Roeck wrote:
>>> Interesting. Obviously that doesn't help ;-). What is returned 
>>> back if you read pwm2 after setting it to 0 ?
>> 0 (zero). Maybe some sort of protection?
> No idea. Might be the fan itself doing it.
Unlikely. The same fan model is installed on my other main-board
(Gigabyte with it8728) and its possible there to bring down the fan to
0 rpm with pwm set to 0.

> What happens if you set it to 1 ?
Set to [0-4] => fan spins up to maximum rpm (~2250rpm)
Set to > 5 => fan spins at desired rpm (~600rpm upward)

> Excellent. Note there is one problem in the driver - any changed
> pwm settings will revert to the default after a suspend/resume
> cycle. That requires a major change to the driver to fix, so it
> will take a while. Until then, you'll have to re-apply the changed
> configuration after suspend/resume.
No problem for me. This box runs all the time with no suspend mode
anyway :-)
- -- 
kind regards
 Mathias
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLgHM8ACgkQnfTEjDUZ2fPDWwCgmX5ztf4MPGbchLRGlZL56q17
6xUAn3ZZnpOJOpbB8hAGi4PQZdX3Py3y
=EYT1
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
