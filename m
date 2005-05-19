From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: i2c for Alpha
Message-Id: <3F8ADBC8.3030807@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Most (all?) of the code is CPU independant.  You'll need to figure out 
what the I2C/SMBus host is and see if it is supported 
(http://secure.netroedge.com/~lm78/supported.html).  If not, then you 
could try to get a datasheet and try to hack up a new driver.  The nice 
thing is that once you have a working bus, all the chip drivers should 
automaticly work on it.


Phil

Jeff Sacksteder wrote:

>I am now the proud parent of a Digital Server 5000, based on a 533Mhz Alpha. 
>This is the 'Rawhide' platform and was designed for NT on Alpha 
>installations. It most certainly has an I2C bus of some sort on it. I have a 
>functioning Linux install on it now and would like to experiment with 
>hardware monitoring. I will most likely need some coaching as I work my way 
>through the problems I encounter. Is there a list where I should direct my 
>questions? Alternately, does anyone want to volunteer to work with me on 
>this?  
>
>  
>
