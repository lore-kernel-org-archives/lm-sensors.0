From: juergh@gmail.com (Juerg Haefliger)
Date: Fri, 23 Mar 2007 04:12:25 +0000
Subject: [lm-sensors] #2195: Fails to detect ITE family chip with ID
Message-Id: <191fb4ca0703222112p3fdaee39hcf4619238feebe2b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
In-Reply-To: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 3/22/07, Jean Delvare <khali at linux-fr.org> wrote:
> On Thu, 22 Mar 2007 12:45:11 -0700, Juerg Haefliger wrote:
> > > That and possibly fixing other mistakes I made. You wrote the dme1737
> > > driver, so I assume you have (or have access to) a DME1737 device or
> > > compatible for testing, while I don't.
> >
> > Ok. Can I roll libsensor/sensors support for the dme1737 into the same
> > patch or do I need to hold off until the driver is accepted?
>
> I'm fine with a single patch for both, yes.

OK, started looking at it and noticed 2 things:

1) The ITE superio enter sequence also works for the SMSC, so
sensor-detects reports both an (unknown) ITE and a dme1737 SMSC chip.
I guess there's nothing we can do about this, can we?

2) Even though the datasheet shows a device ID of 0x78 which matches
the sensor-detect output of the ticket reporter, my DME1737 returns
0x77. Should I just add another entry for a DME1737 with dev id 0x77?


...juerg


>
> --
> Jean Delvare
>

