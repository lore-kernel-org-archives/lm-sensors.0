From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jul 2007 20:05:04 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <20070714220504.6fc8e42a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 13 Jul 2007 14:08:53 +0200, Hans de Goede wrote:
> Notice that I use simple_strtoul, so val will never be < 0, if you write -4096 
> strtoul will not recognize the - and return 0.
> 
> I know it looks strange to store the return value in an int then, but in some 
> of the other store methods I need val to be signed, and for consistency I've 
> thus stored it into an int everywhere.

But wouldn't then a large input value (fitting in a long but not in an
int) be silently turned into a negative value, possibly doing crazy
things in the rest of the code?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
