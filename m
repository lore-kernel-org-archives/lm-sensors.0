From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Why this output?
Message-Id: <B9F94C6E.4430%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F92C49.4411%zdavatz@ywesee.com>
In-Reply-To: <B9F92C49.4411%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 14.11.2002 12:21 Uhr, "Jean Delvare" <khali@linux-fr.org> wrote:

> 
>>> One important thing to notice is that i2c and lm_sensors will use
>>> information found un /usr/src/linux to
>> What information will it look for here? For the source-tree (.config)?
> Yes, kernel configuration options in .config, amongst other things.
> Also, some things depend on the kernel version itself, and some
> constants defined in the linux kernel sources are used.
Can you tell me exactly witch files need to be in /usr/src/linux? Or can you
point me to a HOWTO or some other link?

I need to know what files are there cause I installed the Debian
kernel-image-2.4.18... And so far I only found the config file for that
kernel.

Obviously I am missing some more files but I do not know witch ones.

Thanks for your help.

Zeno
