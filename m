From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jan 2014 20:02:48 +0000
Subject: Re: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <20140122200248.GA27598@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
In-Reply-To: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 22, 2014 at 08:32:31PM +0100, Mathias Gerber wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello Guenter
> 
> On 22.01.2014 19:34, Guenter Roeck wrote:
> >>> Interesting. Obviously that doesn't help ;-). What is returned 
> >>> back if you read pwm2 after setting it to 0 ?
> >> 0 (zero). Maybe some sort of protection?
> > No idea. Might be the fan itself doing it.
> Unlikely. The same fan model is installed on my other main-board
> (Gigabyte with it8728) and its possible there to bring down the fan to
> 0 rpm with pwm set to 0.
> 
Ok.

> > What happens if you set it to 1 ?
> Set to [0-4] => fan spins up to maximum rpm (~2250rpm)
> Set to > 5 => fan spins at desired rpm (~600rpm upward)
> 
Mathias,

Can you send me the output of "grep . pwm2*" ? I'll see if I can
find anything in the datasheet that might explain this behavior.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
