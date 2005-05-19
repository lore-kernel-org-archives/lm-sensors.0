From: jonsmirl@gmail.com (Jon Smirl)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <9e47339104092208403d9de6f4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>
	 <41506099.8000307@web.de> <41506D78.6030106@web.de>
	 <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org>
	 <1095854048.18365.75.camel@localhost>
	 <20040922122848.M14129@linux-fr.org>
In-Reply-To: <20040922122848.M14129@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com
Cc: Adrian Cox <adrian@humboldt.co.uk>, Michael Hunold <hunold-ml@web.de>, Greg KH <greg@kroah.com>

On Wed, 22 Sep 2004 14:38:46 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> Aha, this is an interesting point (which was missing from your previous
> explanation). The base of your proposal would be to have several small i2c
> "trees" (where a tree is a list of adapters and a list of clients) instead of
> a larger, unique one. This would indeed solve a number of problems, and I
> admit that it is somehow equivalent to Michael's classes in that it
> efficiently prevents the hardware monitoring clients from probing the video
> stuff. The rest is just details internal to each "tree". As I understand it,
> each video device would be a tree on itself, while the whole hardware
> monitoring stuff would constitute one (bigger) tree. Correct?

Any DDC solution needs to leave the data visible in sysfs and
accessible from user space. I'm trying to move the EDID parsing code
out of the kernel.

-- 
Jon Smirl
jonsmirl@gmail.com
