From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 02 Dec 2007 20:36:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] HWMON: coretemp, suspend fix
Message-Id: <200712022136.48511.rjw@sisk.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <661416096128474967.slaby@pripojeni.net> <200712010051.41227.rjw@sisk.pl> <20071202162814.GZ13717@jupiter.solarsys.private>
In-Reply-To: <20071202162814.GZ13717@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sunday, 2 of December 2007, Mark M. Hoffman wrote:
> Hi:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> [2007-12-01 00:51:40 +0100]:
> > On Saturday, 1 of December 2007, Rafael J. Wysocki wrote:
> > > On Friday, 30 of November 2007, Jiri Slaby wrote:
> > > > On 11/30/2007 11:15 PM, Jean Delvare wrote:

[--snip--]
> 
> PS: while reading kernel/power/disk.c, I saw this...
> 
> 335 static void power_down(void)
> 336 {
> 337         switch (hibernation_mode) {
> 338         case HIBERNATION_TEST:
> 339         case HIBERNATION_TESTPROC:
> 340                 break;
> 341         case HIBERNATION_REBOOT:
> 342                 kernel_restart(NULL);
> 343                 break;
> 344         case HIBERNATION_PLATFORM:
> 345                 hibernation_platform_enter();
> 346         case HIBERNATION_SHUTDOWN:
> 347                 kernel_power_off();
> 348                 break;
> 349         }
> 350         kernel_halt();
> 351         /*
> 352          * Valid image is on the disk, if we continue we risk serious data
> 353          * corruption after resume.
> 354          */
> 355         printk(KERN_CRIT "Please power me down manually\n");
> 356         while(1);
> 357 }
> 
> Shouldn't that be while(1) cpu_relax(); ?

Yes, it should.

Thanks for pointing that out, I'll fix it.

Greetings,
Rafael

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
