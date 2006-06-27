From: gimeshell@web.de (gimeshell at web.de)
Date: Tue, 27 Jun 2006 23:40:22 +0000
Subject: [lm-sensors] better temp2 computation for asus CUSL2C
Message-Id: <20060628014022.dd15c4a0.gimeshell@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060618021736.f08a39bb.gimeshell@web.de>
In-Reply-To: <20060618021736.f08a39bb.gimeshell@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Jun 2006 22:17:15 +0200
Jean Delvare <khali at linux-fr.org> wrote:

> > my BIOS does have such an idle loop, too.
> > Temperature is increasing from about 35 degrees immidiately after
> > entering BIOS up to 46 degrees met after a few minutes.
> > Looking at sensors output while linux is idle, i get shown about 30
> > degrees with sensors default computation line for asus CUSL.
> 
> So I'd say the compute line is correct and you don't need to change
> it.
> 

Hi,

i did make some tests (sorry for late reply):

CPU busy
====
Linux: (mprime cpu stressing): lm-sensors: 44? C
BIOS: (instantly reset switch): 43? C

CPU idle
====
Linux: lm-sensors: 38? C
BIOS: (instantly reset switch): 36? C

BIOS
==
(probably cpu load, loop) 45? C

sensors.conf compute line:
compute temp2 (@*30/43)+34, (@-25)*43/30 

instead of default:
compute temp2 (@*30/43)+25, (@-25)*43/30 

Motherboard: Asus CUSL2C

Or did i overlook anything?

regards,
gimeshell

