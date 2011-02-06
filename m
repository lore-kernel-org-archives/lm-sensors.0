From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 06 Feb 2011 16:13:02 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110206161302.GB30271@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Ian,
On Sun, Feb 06, 2011 at 04:36:10AM -0500, Ian Dobson wrote:
[ ... ]
> >> temp2:       -60.0°C  (high = +50.0°C, hyst = +55.0°C)  sensor = diode
> >
> > This doesn't look good either. Can you report the raw values you get when 
> > reading
> > registers 0x150/0x151, 0x75/0x76, 0x152, and 0x200 ?
> >
> > I have been wondering if I should retrieve the temperature values from 
> > 0x73/0x75/0x77.
> > This is another set of temperature registers supported by both chips and 
> > used as
> > fan monitoring source. 0x150 and 0x200 specify the temperature source for 
> > 0x151 and
> > 0x75, respectively.
> >
> > Thanks,
> > Guenter
> 
>  0x150 = 0
>  0x151 = 0
>  0x075 = 31
>  0x076 = 0
>  0x152 = 0
>  0x200 = c
> 
Looks like they are using PECI agent 0 as monitoring source. Odd, though, that 0x150 
reads zero but reports -60 degrees C. Is that fluctuating ?

Also, can you dump registers 0x100, 0x200, 0x300, and 0x621 to 0x626 ? Those registers
define the mapping from temperature sources to registers (0x152 was wrong; should have said 0x622).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
