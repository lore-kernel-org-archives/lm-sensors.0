From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Apr 2012 05:47:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fam15h_power: fix bogus values with current BIOSes
Message-Id: <20120410074725.442d875b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1333840079-13541-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1333840079-13541-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 9 Apr 2012 23:55:56 +0200, Andre Przywara wrote:
> On 04/09/2012 07:39 PM, Jean Delvare wrote:
> > I am a little curious about the code BTW, as the value you write isn't
> > the one you originally checked for, which means that reloading the
> > driver would have to do it again...
> 
> The whole code is about to fix a BIOS flaw. It needs to be done only 
> once after each reset, newer BIOSes will do this at boot time already. 
> So reloading the driver will not fix this again, because it is not 
> needed.

Err, you're right, sorry. Probably I already had fever when I reviewed
this patch but had not noticed yet. Sorry for the noise.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
