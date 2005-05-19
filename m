From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Compile Issue with customized RH installations
Message-Id: <3C5D82A8.EC7800DE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020127182213.A518@mcp>
In-Reply-To: <20020127182213.A518@mcp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks.
Do you have a step-by-step solution we can pass along to others?
mds

David Klipec wrote:
> 
> After having similar problems to others with getting the package to
> compile, I read into your support answers a little more closely.  It
> seems that the issue compiling from I2C_DRIVERID_ADM1024 not being
> defined is due to old header files, but the root cause may be that many
> people have a kernel-i2c rpm installed.  This would get picked up, and
> caught me even though I have long since upgraded kernels, and
> uninstalled their predecessors entirely.
> 
> -Dave
