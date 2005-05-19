From: ADharankar@attbi.com (Arun Dharankar)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: I2C driver for MPC8260.
Message-Id: <200304131907.42332.ADharankar@ATTBI.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304122045.58665.ADharankar@ATTBI.Com>
In-Reply-To: <200304122045.58665.ADharankar@ATTBI.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the reply. I had also posted the question to the LinuxPPC
mailing list, and two replies. Here is one. Looks like very little work
on my part to get it working on 2.4.20, which I use.

Best regards,
-Arun.
--------------------------------------------------------------------------------------------------------
> 
> I could find the MPC860 algo driver for I2C, but dont
> know how well it adapts to MPC8260. Can anyone provide
> any pointers? Also, any test app to work with it?

We use the i2c-algo-8260  driver  on  a  couple  of  8250/8260  based
boards;  see  for example the configurations for the CPU86, PM825 and
PM826 boards in our  source  tree  (see  the  files  i2c-cpu86.c  and
i2c-pm826.c in drivers/i2c)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There is no distinctly American criminal class except Congress."
- Mark Twain
--------------------------------------------------------------------------------------------------------
On Sunday 13 April 2003 06:50 pm, Mark D. Studebaker wrote:
> I suspect that the 860 and 8260 controllers are different.
> You should check the datasheets to verify.
> Sorry, I'm not aware of an 8260 driver.
> mds
>
> Arun Dharankar wrote:
> > Hello...
> >
> > I could find the MPC860 algo driver for I2C, but dont
> > know how well it adapts to MPC8260. Can anyone provide
> > any pointers? Also, any test app to work with it?
> > This is for Linux kernel 2.4.x.
> >
> > Best regards,
> > -Arun.
