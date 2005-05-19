From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Linear Technology LTC-4302-1
Message-Id: <4138CABE.4090206@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


No.  To me, it looks too application specific to have a generic driver. 
  It does, however, look simple enough to write a simple control app. 
Take a look at some of the example programs in our package (like 
i2cdetect).  I think you'll see that if you know some C, that it 
wouldn't be hard to whip up a simple command-line app which would 
control a chip like this.


Phil

Jim Sommers wrote:
> Is there a driver in the works for this part?
> 
> http://www.linear.com/prod/datasheet.html?datasheet47
> 
> Thank you.
> 
> Regards,
> 
> Jim Sommers
> 
> 
