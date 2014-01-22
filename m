From: Mathias Gerber <mathias_g@tuxedo.ath.cx>
Date: Wed, 22 Jan 2014 16:01:28 +0000
Subject: Re: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <52DFEB58.9060604@tuxedo.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
In-Reply-To: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Michael

On 22.01.2014 15:43, Michael Vorburger wrote:> Do I need any special
drivers or other settings, for this motherboard? -
> Thank you for any tips!
Same mainboard here :-) Debian 7.3. My logfile looked almost the same.
The chip on the mainboard is a NCT5538D. You have to get the module
nct6775 from: https://github.com/groeck/nct6775

Build, install it and load the module. Run sensors to ensure that
values are shown now. dmesg should something like:
nct6775: Found NCT6791D or compatible chip at 0x2e:0x290

I had some issues with pwmconfig. The script tries to stop the fans
completely. This does not work for the cpu fan (pwm2). I had to assign
the pwm output pwm2 by hand to the inputs fan2_input.

This is my !! preliminary !! config for the mainboard:
http://pastebin.com/JhysG21x
- -- 
kind regards
 Mathias

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLf61EACgkQnfTEjDUZ2fMaSACgy8/xw9ANDS87mS4xax7jvy3J
BvUAoLPfbWf3ykwVnYlZxMvxRe6sbbFX
=QRsd
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
