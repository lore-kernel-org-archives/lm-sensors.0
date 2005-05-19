From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Keywest detection
Message-Id: <1060193344.593.17.camel@gaston>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806190950.6326aa8f.khali@linux-fr.org>
In-Reply-To: <20030806190950.6326aa8f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2003-08-06 at 19:09, Jean Delvare wrote:
> Hello,
> 
> I would like to add support for the Keywest to our sensors-detect
> script. I wonder if I should add it to the detectable adapters list or
> to the undetectable adapters list. Is there any way to detect it?
> Usually, we detect the adapters by matching a given PCI
> manufacturer:device ID and function.
> 
> Also, since you seem to have much knowledge about Linux PPC, maybe you
> could help us on another problem. We have some dump tools that come with
> the lm_sensors package, and one of them, isadump, doesn't seem to
> compile on PPC. Could you take a look and tell us if you know how to fix
> it? Or maybe this tool is of no use on PPC systems?

Hrm... On 2.4, it's not that simple, there can be 2 keywest controllers,
one on the northbridge, one on the southbridge, driving various parts.

With 2.6, these will be visible in sysfs once i'm done with the porting
of pmac drivers to the new model.

I'm not sure I like the idea of having drivers tapping things on those
i2c busses if those drivers aren't specially designed for the pmacs. I
hate the idea of something preventing proper cooling of the machine and
thus causing HW damage, or around those lines...


Ben.
