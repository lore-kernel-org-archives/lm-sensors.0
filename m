From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 May 2008 14:40:29 +0000
Subject: Re: [lm-sensors] sensors.conf for the Supermicro PDSMi+
Message-Id: <20080506164029.6fce6197@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <482051E8.605@caps-entreprise.com>
In-Reply-To: <482051E8.605@caps-entreprise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Romain,

On Tue, 06 May 2008 14:41:12 +0200, Romain Dolbeau wrote:
> Same device than the X7DBE, but used differently.

I have a configuration file for this board as well:
http://khali.linux-fr.org/devel/lm-sensors/sensors-Supermicro-PDSMi+.conf

It seems that we agree on most settings, except:

* -12V compute formula. Where did you get yours? Mine gives a better
  value on my system (which doesn't mean it's correct, of course.)

* +5V and 5VSB compute formula. You cancel the 150 mV offset which the
  driver is adding on purpose. Why? Both values were OK on my system
  with the offset.

* The connector for the 6th fan. I thought it was fan6 but you seem to
  believe it's fan7. My system only had 2 fans so I will trust you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
