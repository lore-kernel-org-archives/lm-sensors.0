From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 22 Mar 2007 19:45:11 +0000
Subject: [lm-sensors] #2195: Fails to detect ITE family chip with ID
Message-Id: <191fb4ca0703221245l6dfe850u70d6c6737e6bfcb9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
In-Reply-To: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > > Can you please provide a patch fixing sensors-detect for the DME1737?
> >
> > Do you mean just fixing the 0x55?
>
> That and possibly fixing other mistakes I made. You wrote the dme1737
> driver, so I assume you have (or have access to) a DME1737 device or
> compatible for testing, while I don't.

Ok. Can I roll libsensor/sensors support for the dme1737 into the same
patch or do I need to hold off until the driver is accepted?

...juerg


> Thanks,
> --
> Jean Delvare
>

