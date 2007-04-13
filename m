From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Apr 2007 06:51:54 +0000
Subject: Re: [lm-sensors] Taking a closer look at lm-sensors,
Message-Id: <20070413085154.4b99020e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070412091354.10f4bef7@hyperion.delvare>
In-Reply-To: <20070412091354.10f4bef7@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

On Thu, 12 Apr 2007 12:07:51 +0200, Hans de Goede wrote:
> You are right, still I seem to remember patching Makefiles myself because of := 
> causing passing stuff on the cmdline to not work. Maybe this has changed and 
> the patched used by opensuse / slackware (and Fedora) were there because this 
> didn't use to work??

Could be. I noticed that the distributions are usually better at adding
workarounds in their builds than at cleaning them up when they are no
longer necessary. That being said, I've tested GNU make 2.78.1, which
is quite old now, it was released in September 1999, and it does not
exhibit the behavior you describe. So I'm a bit skeptical.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
