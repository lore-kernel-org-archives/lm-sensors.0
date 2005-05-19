From: adal1c@motorola.com (Alexandre D ALTON)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: ADM1030 query
Message-Id: <1081320591.26093.10.camel@marge>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040406215731.401d32c1.khali@linux-fr.org>
In-Reply-To: <20040406215731.401d32c1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok,

Actually I've written a driver from specs yesterday using the pdf
datasheet. It is based on the 2.6.4 kernel sensors driver. I will clean
it up tonight, and, if you are interrested, I'll post it to you.

I have also one question:

	- The ADM1030 can either control the fan speed, by default it is set to
automatic. Is it safe to enable the user to go into manual mode
(dangerous) and how it has to be handled (interface with /sys
filesystem).
	
I've also made modifications to the sensors 2.8.4 package, and I wonder
what is the meaning of the SYSCTL #define's are they related to the
kernel or it is only for program / libsensors interface. 

Thanks for your response.

Alex.

On Tue, 2004-04-06 at 21:57, Jean Delvare wrote:
> Hi Alex,
> 
> > I am interrested in developping the driver for adm1030 as I have one
> > in my MSI Mega651 barebone.
> > 
> > Could you please send me the infos you have ?
> 
> Two persons were supposed to write an adm1030/adm1031 driver one year
> ago but we never had news about the advancement and are now unable to
> contact them.
> 
> Then, we had someone announcing he had been writing a driver for the
> adm1030 some times ago:
>   http://archives.andrew.net.au/lm-sensors/msg07123.html
> But unfortunately it turned out that the driver is far from completion,
> and doesn't follow our driver scheme and interface at all so it's rather
> useless to us. A complete, standard-compliant driver would be
> appreciated.
> 
> Thanks.
