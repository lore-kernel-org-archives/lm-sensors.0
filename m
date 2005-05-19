From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Hangs with w83781d
Message-Id: <20040220204501.18721faf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
In-Reply-To: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Keith,

Nice to see you around again :)

> I've finally gotten around to upgrading my kernel, and the immediate
> resume problem also exists in kernel 2.6.3. I've tracked down the
> problem to the line
> 
> w83781d_write_value(client, W83781D_REG_IRQ, 0x41);

Interesting. This demonstrates (once again) that reseting chips and then
setting registers to artibrary values is *bad.

> in the file w83781d.c, introduced in lm_sensors 2.6.4; with this line
> commented out, suspend works fine again.

I'd like to refine the fix a bit, and then commit it to Linux 2.6 and
our CVS lm_sensors2 repository. Could you please tell me:

1* Which chipset you have exactly.

2* Which value is present in the register 0x4C before you load w83781d
for the first time. (Load the bus driver and use i2cdump to dump the
chip contents.)

3* The value present in the same register after you load and unload the
w83781d driver *with your modification* (i.e. we'll get the value
resulting from the reset operation).

With this information, I should be able to adapt the write to the
register instead of plain removing it.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
