From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Mar 2007 19:56:24 +0000
Subject: [lm-sensors] #2195: Fails to detect ITE family chip with ID
Message-Id: <20070322205624.9863a75c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
In-Reply-To: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 22 Mar 2007 12:45:11 -0700, Juerg Haefliger wrote:
> > That and possibly fixing other mistakes I made. You wrote the dme1737
> > driver, so I assume you have (or have access to) a DME1737 device or
> > compatible for testing, while I don't.
> 
> Ok. Can I roll libsensor/sensors support for the dme1737 into the same
> patch or do I need to hold off until the driver is accepted?

I'm fine with a single patch for both, yes.

-- 
Jean Delvare

