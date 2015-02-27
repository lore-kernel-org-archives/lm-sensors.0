From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Feb 2015 21:30:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct7904) Strenghten detect function
Message-Id: <20150227213044.GA1661@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1425054979-27598-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1425054979-27598-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 27, 2015 at 08:27:04PM +0300, Vadim V. Vlasov wrote:
> Hi Guenter!
> 
> Yes, I can confirm that the bits are always zero, even if the bank
> is set to an invalid number.
> 
> I used i2cset/i2cdump and regardless of the bank selection
> (I tried 5, 6, 0x32, 0x66 and 0xff) the higher bits are read back
> as zero. However, the lower bits return the selected bank
> number even if it is invalid (i.e. 5, 6, 2, 6 and 7 for the above
> tests).
> 
That is what I suspected.

> The ID bytes (0x7a-0x7c) are always correct (0x50, 0xc5, 0x51) for
> invalid banks as well (the rest of the bytes are 0xff's).
> 
Great, thanks,

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
