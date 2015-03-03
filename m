From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 03 Mar 2015 15:03:38 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Nuvoton chip updates
Message-Id: <20150303160338.4c8ad310@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404094141-28146-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404094141-28146-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 03 Mar 2015 16:10:49 +0300, Vadim V. Vlasov wrote:
> Hi Jean!
> 
> On Tue, 2015-03-03 at 09:15 +0100, Jean Delvare wrote:
> 
> > Do you have a full register dump of the NCT7904D that you could share
> > with me? Or maybe Vadim does?
> > 
> 
> Please find the dump below.
> The rest of the banks are the same as bank 5 (except for the bank
> number at 0xff).

Thanks Vadim. FYI you can pass the bank register and value to i2cdump
so you don't need to call i2cset beforehand.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
