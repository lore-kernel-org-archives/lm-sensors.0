From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 29 Nov 2012 05:05:56 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <20121129050556.GB22453@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Nov 28, 2012 at 01:41:03PM -0700, David Hubbard wrote:
> Hi Jean,
> 
> Rudolf and I are collaborating on a new Asus board for coreboot.org,
> the F2A85-M, which has a new ITE chip, the it8603e. sensors-detect
> says:
> 
Hi David,

good luck with that ... I don't find any information about the chip except for
Rudolf's e-mail on the coreboot mailing list. I suspect it may be one of those
special vendor specific ITE chips like the IT877x, for which no documentation is
available at all (though someone in the coreboot project seems to have access
to the datasheet for IT8772F).

Guenter

> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor/ITE'...               No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x8603
>     (logical device 4 has address 0x290, could be sensors)
> 
> I created a quick patch for sensors-detect to recognize the chip. I'd
> like to start poking at it to see if the it87 driver can extract any
> useful information (likely). Rudolf has requested the datasheet from
> ITE, but in the likely event nothing happens, we thought it would be
> worth asking you - you know people in the industry. I would be happy
> to sign an NDA if that will help.
> 
> Thanks,
> David
> 
> --- sensors-detect    2012-11-28 21:15:16.601391282 -0700
> +++ sensors-detect    2012-11-28 21:34:24.392508598 -0700
> @@ -2133,6 +2133,12 @@
>          devid => 0x8772,
>          logdev => 0x04,
>          features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
> +    }, {
> +        name => "ITE IT8603E Super IO Sensors",
> +        driver => "to-be-written",    # it87
> +        devid => 0x8603,
> +        logdev => 0x04,
> +        features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
>      }
>  );
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
