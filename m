From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2012 17:57:28 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <20121202185728.720eed38@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 28 Nov 2012 13:41:03 -0700, David Hubbard wrote:
> I created a quick patch for sensors-detect to recognize the chip. I'd
> like to start poking at it to see if the it87 driver can extract any
> useful information (likely). Rudolf has requested the datasheet from
> ITE, but in the likely event nothing happens, we thought it would be
> worth asking you - you know people in the industry. I would be happy
> to sign an NDA if that will help.

The information I was able to get from my contact at ITE:

* The IT8603E does supports hardware monitoring.

* The chip has a built-in 8-bit ADC, two thermal inputs with mode
  selection (thermistor / transistor), 5 external voltage inputs +
  3VSB, AVCC3 and VBAT measured internally. It features limits for all
  measured values (although probably not for VBAT) and fetching of
  external temperature values over SST/PECI/AMDSTI/PCH SM-Link.

* The IT8603E does support automatic fan speed control.

* The IT8603E is compatible to some degree with the IT87xxF family.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
