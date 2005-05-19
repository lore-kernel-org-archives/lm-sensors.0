From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: lm_sensors i2c-amd756 detection trouble
Message-Id: <Pine.LNX.4.53.0312100416240.22797@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031209143722.46F5.DANIELRJ@mail.dk>
In-Reply-To: <20031209143722.46F5.DANIELRJ@mail.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 10 Dec 2003, Daniel Rune Jensen wrote:

> I have looked at the i2c-viapro module, and changed the i2c-amd756.c
> source code so the module_init looks the same, but it still won't load.
> Gives a:
> /lib/modules/2.4.23/kernel/drivers/i2c/busses/i2c-amd756.o: init_module:
> No such device
> Can anyone clarify this for me ?

Maybe the  other driver has reserved the SMBus I/O region, either for a
reason or due lazy programming. There should be something in the
logfiles. If not,  compare output of the following with and without
amd76x_pm to see what regions it claims. Or read the source..

cat /proc/ioports
cat /proc/iomem
/sbin/lspci -xxx

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
