From: d.juergens@tu-bs.de (Dominik =?ISO-8859-1?Q?J=FCrgens?=)
Date: Wed, 15 Feb 2006 13:17:50 +0000
Subject: [lm-sensors] sysfs
Message-Id: <1140009470.4260.18.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo lm-sensors-list.
Long time ago I adapted a simple Program named varyfan to the use of
sysfs.
Since I did it the first time, I had to adapt many things over the time
again and again, because there were many changes in the i2c part of
sysfs.

Now I again installed the current kernel onto my machine and nothing of
my stuff works any more. There were adaptions made in the kernel code
again, I think. No Problem, but as I wanted to read the documentation
in the kernel sources I found some black-holes ;-)

porting-clients says:

Use the file names specified in
  Documentation/i2c/sysfs-interface 

But this file does not exist in the Tree since 2.6.13 .

So you see... I need help... since I don't want to use old informations
from 2.6.12 kernel tree to adapt to an already changed interface.

To which (future) point in time do you see some convergence in the
interface. Why do you generally ever touch a running system? 

Never the less... Thanks for your work in this field 

Greetings and Thanks


-- 
Dominik J?rgens <d.juergens at tu-bs.de>


