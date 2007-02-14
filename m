From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 14 Feb 2007 19:10:24 +0000
Subject: [lm-sensors] can lm_sensors get data from this pci card
Message-Id: <4dfa50520702141110o7ccaaf2uf29d1a739d094d37@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <36ba31bd0702140219p73b6359bte98542508356ba0d@mail.gmail.com>
In-Reply-To: <36ba31bd0702140219p73b6359bte98542508356ba0d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nick,

First, here is the actual manufacturer's website:
http://www.sunbeamtech.com/PRODUCTS/Theta/theta_tp101.htm

Second, no, lm_sensors does not currently have support for the
sunbeamtech theta tp101.

But, if you want to get the relevant hardware documentation from them,
I'll write a driver for it.

Some companies are reluctant to give out such hardware documentation.
You may be able to negotiate with them to send me the necessary
information under an NDA (Non-Disclosure Agreement).

If you aren't interested, or if sunbeamtech is unable to provide the
necessary documentation before 1 April 2007, then let's not worry
about it. Most new motherboards have similar hardware monitoring
capabilities, and are supported by lm_sensors.

David

