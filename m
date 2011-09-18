From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 18 Sep 2011 19:53:57 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6681D/NCT7802 Support?
Message-Id: <20110918195357.GA31728@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFqD5d+OcNEF0KoPn9qUNomYvmH14EuoRtVv-59xG5hcYrGduw@mail.gmail.com>
In-Reply-To: <CAFqD5d+OcNEF0KoPn9qUNomYvmH14EuoRtVv-59xG5hcYrGduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 17, 2011 at 09:10:11PM -0400, Jeffrey Chenkus wrote:
> 
> Is there any plan to add support for the Nuvoton NCT6681D and NCT7802 chips? I
> need to find a way to read those sensors in the next few months, if lm-sensors
> is not going to have support then I need to come up with a different plan. If
> anyone were working on either I could try testing them on my hardware.
> 
Not right now, at least not afaik. NCT7802Y (assuming that is what you mean)
is all new and will need a completely new driver. I don't have a datasheet for
NCT6681D, so I have no idea if support can be added to one of the existing drivers.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
