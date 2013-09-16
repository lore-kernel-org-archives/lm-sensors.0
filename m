From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Sep 2013 19:43:11 +0000
Subject: Re: [lm-sensors] Possible new ITE chip...
Message-Id: <20130916194311.GA8246@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <52375B76.3030906@ece.ucsb.edu>
In-Reply-To: <52375B76.3030906@ece.ucsb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 16, 2013 at 12:26:46PM -0700, Forrest Brewer wrote:
> Just setup new i7 3770 box: lenovo M92p-2988 SFF
> 
> found core temps but no voltage or fans... new versions of
> sensors-detect found unknown
> ITE chip with 0x8731 ID. Would not load it87 driver built in to
> 3.8.0-19-generic (linux Mint).
> 
> If any notion of how to proceed plz let me know.
> 
Yes, there is an IT8731F (and IT8732F). As usual, no datasheet
is available. You could try loading the it87 driver with force_id
parameter, but don't expect too much.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
