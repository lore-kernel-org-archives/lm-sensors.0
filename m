From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 01 Jun 2005 03:37:16 +0000
Subject: [lm-sensors] lm_sensors 2.9.1 sensord compile failure on 2.6.11.11
Message-Id: <s34q91lfnuo5uf0gflb0in1bd1l46hpo01@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1lhn91hj2hvhq65un08m8nae3f7fvt3ubv@4ax.com>
In-Reply-To: <1lhn91hj2hvhq65un08m8nae3f7fvt3ubv@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Tue, 31 May 2005 16:27:38 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:
>> Can't compile sensord 2.9.1 with 2.6.11.11 -- neither can my test user,
>> and he's done it before.
>>
>> make clean; make PROG_EXTRA:=sensord
>>
>> make: *** No rule to make target `linux/i2c-proc.h', needed by
>> `kernel/chips/xeontemp.d'.  Stop.
>>
>> Does anyone know a fix?  Or magical incantation?
>>
>> It is probably something stupid, but I cannot see it, make user; make
>> user_install work fine, why not other stuff?
>
>Try:
>make PROG_EXTRA:=sensord user
>
Quoting Dave, the tester:
>Put your DS1780 stuff back into a fresh copy of 2.9.1,

(http://scatter.mine.nu/hwmon/adm9240/libsensors-2.9.1-fix-ds1780.diff.gz)

>uncomment PROG_EXTRA
>change to PREFIX=/usr (my setup)
>compile and install.
>'sensord' runs as advertised.
>
>Thank you, Grant!

Thank you Jean  (o:<
--Grant.

