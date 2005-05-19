From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: I2C driver for MPC8260.
Message-Id: <3E99E9D3.9080806@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304122045.58665.ADharankar@ATTBI.Com>
In-Reply-To: <200304122045.58665.ADharankar@ATTBI.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I suspect that the 860 and 8260 controllers are different.
You should check the datasheets to verify.
Sorry, I'm not aware of an 8260 driver.
mds

Arun Dharankar wrote:
> Hello...
> 
> I could find the MPC860 algo driver for I2C, but dont
> know how well it adapts to MPC8260. Can anyone provide
> any pointers? Also, any test app to work with it?
> This is for Linux kernel 2.4.x.
> 
> Best regards,
> -Arun.
> 
