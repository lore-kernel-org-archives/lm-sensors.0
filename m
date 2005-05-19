From: jmunsin@abo.fi (Jonas Munsin)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <20040512200446.GA16515@nemo.sby.abo.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A042B0.6060907@greystate.com>
In-Reply-To: <40A042B0.6060907@greystate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 12, 2004 at 09:41:43PM +0200, Jean Delvare wrote:
> > All is working now. Thanks again. Do the it87 series of chips ever
> > support pwm?
> 
> Yes, the chip supports and even has automatic fan speed control. The 2.4
> driver has support for both. Takeru was working on adding support to the
> 2.6 driver but suddenly vanished. I hope he's OK...
> 
> Recently, Jonas Munsin started from Takeru's preliminary patch and
> completed the work. You can see his patch here:
>   http://people.debian.org/~jmunsin/it87.patch2
> 
> Hopefully this will be integrated into the main driver soon. Testing is
> welcome!

The manual pwm works in that patch, so that can be tested.

The automatic fan speed sort of works, but isn't really usable yet if
you don't know its misfeatures :). It will probably take a few days
before I have time to fix it properly.
