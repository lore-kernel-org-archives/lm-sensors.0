From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 08 Jul 2014 09:32:07 +0000
Subject: Re: [lm-sensors] monitor ddc/ci over i2c
Message-Id: <20140708113207.01354cad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <53BA86F9.5090903@minsoft.com>
In-Reply-To: <53BA86F9.5090903@minsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sanford,

On Mon, 07 Jul 2014 04:39:37 -0700, Sanford Rockowitz wrote:
> I've been trying to use driver i2c-dev to read and control monitor 
> settings, using the DDC/CI protocol to communicate with address 0x37 on 
> device /dev/i2c-n.  Things are sort of working (details below), But it's 
> not clear to me to what extent I'm hitting real limits, or if I just 
> don't know what I'm doing.  Perhaps I shouldn't even be trying to use 
> i2c-dev for this application.  Advice appreciated. And if there's a more 
> appropriate place to post this question, I'd appreciate hearing that as 
> well. (...)

This is indeed off-topic for this list, as it doesn't have anything to
do with hardware monitoring. Better post this to the linux-i2c list [1]
(you can Cc me.)

[1] http://vger.kernel.org/vger-lists.html#linux-i2c

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
