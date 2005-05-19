From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: mkpatch testing...
Message-Id: <3DFA6E86.5030602@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DFA6C5A.3050403@paradyne.com>
In-Reply-To: <3DFA6C5A.3050403@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



That's how I did it (mkpatch'ed i2c against my kernel), although my 
sensors bin is segfaulting... ;')  Keep in mind that the I2C header 
variable in the lm_sensors makefile is hardcoded to /usr/local/include, 
which is not great imho.


Phil


Mark Studebaker wrote:

> did anybody test mkpatched kernels?
> here's one ticket...
> perhaps we should do some mkpatch testing before putting the 
> announcement on freshmeat?
>
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket87
>
