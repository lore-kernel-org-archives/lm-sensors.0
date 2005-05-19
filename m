From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Kill another macro abuse in via686a
Message-Id: <lnuk81l2jlhikf9nb3k76ensq1pk2e2d8u@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050517223857.531710cd.khali@linux-fr.org>
In-Reply-To: <20050517223857.531710cd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Tue, 17 May 2005 22:38:57 +0200, Jean Delvare <khali@linux-fr.org> wrote:
>This patch kills another macro abuse in the via686a hardware monitoring
>driver. Using a macro just to alias an array is quite useless, isn't it?

Can I go kill some macros too?  Silly conversion macros, make like 
adm9240?  Was planning to put SCALING() in with SENSORS_LIMIT() in 
the header somewhere, as those two static functions can be used for 
most of the scaling conversions.

As well, do something with the LM75 include, I see now I duplicated 
some of the code there, with exception that I right justify signed 
9-bit temp on read to local store, rather than on delivery to sysfs.

Stomping macros makes the code so much more colourful in vim :)  

--Grant.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
