From: socialhacker@socialhacker.com (anton)
Date: Tue, 22 Nov 2005 01:23:56 +0000
Subject: [lm-sensors] it87.c fan_div patch
Message-Id: <Pine.LNX.4.21.0511211816160.8297-100000@sterling.propagation.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0511210218160.2818-200000@sterling.propagation.net>
In-Reply-To: <Pine.LNX.4.21.0511210218160.2818-200000@sterling.propagation.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


	:) Excellent.  Glad to be of help.

	-Anton

On Mon, 21 Nov 2005, Jean Delvare wrote:

> 
> Hi Anton,
> 
> On 2005-11-21, Anton V. Staaf wrote:
> > 	Hi, I just got lm_sensors (v2.9.2) up and running on my Shuttle
> > (SN41G) and am loving it.  In setting things up I found what I think is a
> > bug in the it87_fan_div setting code.  I've included a patch vs. TOT
> > CVS.  What was happening was that the check to make sure the third fan's
> > divisor was either 2 or 8 was using the wrong member of the it87 data
> > structure.  This was causing the if to always fail and thus always force
> > the divisor to 2.
> 
> Good catch! You're all correct. We'll commit your patch to lm_sensors
> CVS shortly. Amazing this bug was left unnoticed while the driver is
> widely used and more than 4 year old.
> 
> At least the Linux 2.6 driver isn't affected by this problem.
> 
> Thanks,
> --
> Jean Delvare
> 

