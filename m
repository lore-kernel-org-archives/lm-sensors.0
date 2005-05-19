From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid
Message-Id: <phf2819eap0brvk3hkbnmrd86ifkhmmh2t@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
In-Reply-To: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 May 2005 20:30:31 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>> This small patch changes two drivers, adm1025 and adm1026, to 
>> report vid as cpu0_vid sysfs name as used by the other drivers.
>
>This patch (alone) doesn't please me. For one thing, you should
>duplicate, not rename, the attributes, so as to not break compatibility.

Oops, forgot that aspect.  I need to change adm9240 in libsensors too
'cos I renamed analog_out, does it need chassis_clear?  Nothing else 
has it.  I only put it in the driver 'cos old comment said they 
couldn't get chassis clear it to work, Intel doc. error :)  

>Tag the old ones as "to remove after <some date>". Also, a patch to
>libsensors to accept the new names is obviously needed.

What sort of timeframe you suggest for remove after?

--Grant
