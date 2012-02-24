From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 24 Feb 2012 07:25:13 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <20120224082513.2950a509@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 23 Feb 2012 21:03:37 -0800, Kenneth Cox wrote:
> So is it just a "wait for further developments" kind of thing? Thanks for
> all your help on this. You've been excellent.

No, I'm not done with you yet :p

I think the problem here is that you ended up using the sensors-detect
script from upstream while Debian/Ubuntu normally makes integration
changes to that script. So you ran the script but it did not update the
configuration files as it should have.

Please check file /etc/modules , see if you can see the following line:

w83627ehf

If it isn't present, add it, and reboot. This is how Debian loads hwmon
drivers and I presume Ubuntu does the same.

As root, you can also load the w83627ehf driver manually:

# modprobe w83627ehf

and see if the NCT6776F shows in the output of "sensors" then.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
