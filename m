From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: mkpatch testing...
Message-Id: <3DFBF5B0.3050302@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DFA6C5A.3050403@paradyne.com>
In-Reply-To: <3DFA6C5A.3050403@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

FYI, Hearing no objections, I just submitted the Freshmeat update.
Let's try and figure out why the ali's arent' compiling in a mkpatched kernel.

Jean Delvare wrote:
>>the trouble is that 'make install' on the i2c side puts the headers in
>>/usr/local/include... Especially now that we are requiring an upgrade
>>to i2c-2.7.0, if we don't point to the same place on i2c and
>>lm_sensors, then people couldn't compile i2c outside the kernel, they
>>would have to mkpatch...
> 
> 
> I definitely agree with this. As long as i2c installs to /usr/local by
> default, I think we should stick to looking for its headers at this
> place (at least if we choose to use a single default). Now, maybe some
> makefile or shell magic can let us know which headers to include. I have
> to admit that I didn't understand what the possibilities are and how to
> choose among them, but if you want to explain it to me, I can work on
> it.
> 

