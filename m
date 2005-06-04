From: rvinson@mvista.com (Randy Vinson)
Date: Sat, 04 Jun 2005 07:59:29 +0000
Subject: [lm-sensors] Re: [PATCH 1/2] Add support for Maxim/Dallas DS1374
Message-Id: <42A0D714.1050601@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42A0CD46.60300@mvista.com>
	<20050603214653.GA15314@gate.ebshome.net>
In-Reply-To: <20050603214653.GA15314@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com, linuxppc-embedded@ozlabs.org

Eugene Surovegin wrote:
[snip]
> 
> I wonder, why you chose to use those 1-byte SMBus transfers instead of 
> i2c transfer.

I was simply following the guidelines in 
Documentation/i2c/writing-clients as noted in the driver header. This 
note was in the driver I used as my base, so I just followed along.

> 
> I wrote similar DS1374 driver some time ago which used those transfers 
> and they worked just fine.

I checked http://secure.netroedge.com/~lm78/supported.html, 
http://secure.netroedge.com/~lm78/newdrivers.html and looked in the 
lm_sensors-2.9.1 tarball before I started and didn't see a driver for 
the DS1374 listed. That's why I threw mine together. Maybe I missed it.

I would have used I2C transfers myself, but was simply following what I 
thought were current practices. Since this is my first I2C client, I 
just blindly followed the documentation :) Oh well, wouldn't be the 
first time I wandered down the wrong path.

		Randy Vinson


