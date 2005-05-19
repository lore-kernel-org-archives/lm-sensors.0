From: jonsmirl@gmail.com (Jon Smirl)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <9e47339104092210173e55bcca@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org> <41506D78.6030106@web.de>
	 <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org>
	 <1095854048.18365.75.camel@localhost>
	 <20040922122848.M14129@linux-fr.org>
	 <9e47339104092208403d9de6f4@mail.gmail.com>
	 <1095868579.18365.105.camel@localhost>
	 <9e4733910409220907727056b4@mail.gmail.com>
	 <1095871863.18365.129.camel@localhost>
In-Reply-To: <1095871863.18365.129.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com, Michael Hunold <hunold-ml@web.de>, Greg KH <greg@kroah.com>

Can this code be implemented in the current framework? Don't I need
the attach/detach_adapter hook which I can't get to from the algo_bit
code?

http://lkml.org/lkml/2004/9/21/181

-- 
Jon Smirl
jonsmirl@gmail.com
