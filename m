From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: lm_sensors i2c-amd756 detection trouble
Message-Id: <Pine.LNX.4.53.0312092038250.22797@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031209143722.46F5.DANIELRJ@mail.dk>
In-Reply-To: <20031209143722.46F5.DANIELRJ@mail.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 9 Dec 2003, Daniel Rune Jensen wrote:

> i was using lm_sensors 2.8.1 but when i booted no sensors was found. I
> searched the net around for answers and found that the amd76x is
> using the bridge where lm_sensors would like to be, and thus lm_sensors
> suddenly can't find any smbus. Also it should be possible to revert back
> into lm_sensors 2.7.0 which would fix problems. I have tried the cvs
> version 2, as i saw there were some fixes for amd756.
>
> Can this be fixed in lm_sensors, or does it need to be i the kernel tree
> where the experimental apmd resides, or is it simply unfixable ?

Fixable in lm_sensors, I'd say. The i2c-amd756 driver tries to claim the
complete PCI function, while it only needs to reserve the I/O region for
the SMBus controller.

See i2c-viapro module_init, it seems to have a similar fix already
applied.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
