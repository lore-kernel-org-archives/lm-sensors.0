From: henk@god.dyndns.org (henk)
Date: Fri, 09 Mar 2007 09:25:07 +0000
Subject: [lm-sensors] Can I help out on supporting chip id 0x3c00?
Message-Id: <20070309092507.GA31850@god.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070307164619.GA21547@god.dyndns.org>
In-Reply-To: <20070307164619.GA21547@god.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, Mar 08, 2007 at 11:39:49AM +0100, Jean Delvare wrote:
> Hi Henk,
> 
> On Wed, 7 Mar 2007 17:46:19 +0100, henk wrote:
> > I am running on an Acer Travelmate 4650 and was wondering if I could add
> > some support for sensors package.
> > 
> > Can anyone point me in the right direction wich chip should be in there,
> > as I am a bit reluctant to open up the laptop.
> > 
> > Does
> > 	Probing Super-I/O at 0x2e/0x2f:
> > 	Found unknown chip with ID 0x3c00
> > 
> > sound familiar to you?
> 
> No. What makes you think that this device includes hardware monitoring
> functions? Not all Super-I/O chips do, especially those found in
> laptops usually do not.
>
I don't know. I was just thinking maybe someone on the list could point
me in the right direction. Currently I am assuming a PC87591 or similar
which has monitoring support.

- henk

