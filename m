From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jun 2010 10:03:56 +0000
Subject: Re: [lm-sensors] Issue with SMSC EMC2700LPC
Message-Id: <20100616120356.689af7b6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1276681506.2903.104.camel@basilisk>
In-Reply-To: <1276681506.2903.104.camel@basilisk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juan,

On Wed, 16 Jun 2010 11:45:06 +0200, Juan A. Moya wrote:
> Hi list!
> I can see that from version 3.0.3 you support SMSC EMC2700LPC part. But

No. From version 3.0.3 we support _detection of_ the SMSC EMC2700LPC
part in sensors-detect. Nothing more.

> I don't see in the available drivers list any entry to tell the linux
> kernel module I must load.
> 
> sensors-detect tool says:
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `SMSC'...                                     Yes
> Found `SMSC EMC2700LPC Super IO'                            
>     (no information available)
> 
> Any idea?

We don't even know if this part includes hardware monitoring features.
Do you have any reason to believe it does?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
