From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 02 Apr 2013 13:05:10 +0000
Subject: Re: [lm-sensors] Nuvoton NCT5572D incorrectly detected as NCT6775F
Message-Id: <20130402130510.GB7216@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364894666.7911.23.camel@mattotaupa>
In-Reply-To: <1364894666.7911.23.camel@mattotaupa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 02, 2013 at 11:24:26AM +0200, Paul Menzel wrote:
> (please CC me as I am not subscribed)
> 
> 
> Dear Linux hwmon folks,
> 
> 
> lately I was fooled to think my board ASRock E350M1 has a Nuvoton 6775F.
> 
>                 w83627ehf: Found NCT6775F chip at 0x290
> 
> Then I was pointed out that it actually has a Nuvoton NCT 5572D and
> looking at the board, this is actually written on the chip. Searching
> for that on the Web this was confirmed too [1][2][3].
> 
> Should the Linux message be changed to the following?
> 
>         w83627ehf: Found NCT6775F (or NCT5572D) chip at 0x290
> 
> Is it planned to add support for that the NCT5572D?
> 
I don't think so. Many of the superio chips have different labels - we would
end up spending a lot of time trying to keep the labels up to date.
Besides, that chip can also be labeled as NCT6772F or NCT6771F.
So it should read

    w83627ehf: Found NCT6775F, or NCT6771F, or NCT6772F, or NCT5572D chip at 0x290

which would get a bit awkward. And then there is its original name, W83677HG-I,
which we would presumably have to add as well.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
