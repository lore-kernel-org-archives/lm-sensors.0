From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 02 Sep 2009 02:10:40 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <191fb4ca0909011910y6f3c44a0y9e50ea846c0a6c97@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

>> and what shows dmesg?
>
>
> dmesg output after sensors-detect:
> [ 1815.988770] i2c /dev entries driver
>
> dmesg output after sensors:
> (blank)


Please send the output of dmesg after you load the dme1737 driver. It
should at least spit out a message like "Found a SCH5027 chip at xyz".

...juerg


>
> The bundled Linux image does not appear to use the dme1737 module or
> lmsensors. The web interface loads several closed source libraries, and
> I'm not sure how they access the hardware.
>
> Is there something I should try to determine why sensors-detect sees the
> chip but sensors does not?
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
