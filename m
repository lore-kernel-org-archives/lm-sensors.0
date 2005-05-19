From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: bt869 driver
Message-Id: <42026C8A.6080106@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050129234511.5dc19d3b.khali@linux-fr.org>
In-Reply-To: <20050129234511.5dc19d3b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Gerd Knorr wrote:
>>In a nutshell, you set up the video card by getting X going in a  
>>video-compatible mode-line, and then you tell the BT869 the format  
>>(e.g. resolution, broadcast standard, etc.).
> 
> 
> Ah, ok.  That really sounds like the X-Server would be the right place
> to setup that.  The X-Server doing one part of the setup, the driver
> another part and the user must care about doing that in the right order
> is a bit hackish.
> 

Yup.

> Given that x.org is more open than xfree86 it should be easier to get
> bt859 support into the X-Server these days, I'd suggest to try to go
> that route ...
> 

BTW- Does anyone know how the I2C bus/chip driver interfaces work in 
x.org?  Specificly, does it register anything with the kernel, or will 
drivers in the kernel cause nasty race conditions and such with 
corresponding drivers in x.org?


Phil
