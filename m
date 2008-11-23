From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 23 Nov 2008 08:39:44 +0000
Subject: Re: [lm-sensors] Ticket #2323 - Preliminary support for DDR3 in
Message-Id: <20081123093944.2cc375c5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.NEB.4.64.0811221332170.8571@quicky.whooppee.com>
In-Reply-To: <Pine.NEB.4.64.0811221332170.8571@quicky.whooppee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Sat, 22 Nov 2008 13:36:48 -0800 (PST), Paul Goyette wrote:
> The attached diffs provide some preliminary decode of the DDR3 SPD...
> 
> Warning:  I'm no perl expert.  The code I've written is probably ugly to 
> most of the readers of this list.  But it does work!

The decode-dimms script has moved to package i2c-tools:
  http://www.lm-sensors.org/wiki/I2CTools
Please make sure your patch applies to the version of the decode-dimms
script that is found in this package, then post it to the linux-i2c list:
  http://vger.kernel.org/vger-lists.html#linux-i2c

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
