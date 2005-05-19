From: jamagallon@able.es (J.A. Magallon)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.2-rc2
Message-Id: <20040129004402.GC5830@werewolf.able.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040127233242.GA28891@kroah.com>
In-Reply-To: <20040127233242.GA28891@kroah.com> (from greg@kroah.com on Wed, Jan 28, 2004 at 00:32:42 +0100)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com


On 2004.01.28, Greg KH wrote:
> Hi,
> 
> Here are some i2c driver fixes for 2.6.2-rc2.  It's all a bit of small
> bugfixes and documentation updates.
> 

After upgrading to sensors 2.8.3 (first I compiled it, then installed the
Makdrake package when appeared), my temperatures are still mutiplied by 10.
I use 2.6.2-rc2-mm1.

Any ideas ?

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc2-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
