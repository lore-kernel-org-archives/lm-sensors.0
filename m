From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: pca9540 driver question
Message-Id: <Pine.LNX.4.58.0406181758580.19803@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I am working on a board that has a PCA9541 I2C Mux, and is recognized
by sensors-detect as the pca9540.  The driver loads fine, but I have 
yet to really test it.  I guess my question is what was what functionality 
was the driver attempting to provide?  Does it actually allow for 
the phillips arbitration protocol when trying to talk to any sensors on 
the I2C bus, or does it only show what channel is selected at the 
time?  I looked in the code, and I could not see how it was actually
allowing for the arbitration of the bus, but I very well could have
missed something.

Thanks...james
