From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 27 Aug 2007 08:17:14 +0000
Subject: Re: [lm-sensors] [PATCH] Allow writing of negative trigger
Message-Id: <20070827101714.53f2106e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070816081353.GF10132@tweety>
In-Reply-To: <20070816081353.GF10132@tweety>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 26 Aug 2007 14:50:17 -0400, Mark M. Hoffman wrote:
> Hi Jean, Christian:
> 
> * Jean Delvare <khali@linux-fr.org> [2007-08-16 11:40:10 +0200]:
> > I retested w83627ehf and it's now OK for all temperature channels. I
> > also tested adm1021, successfully. I can't test lm77 nor lm93 but the
> > code looks right.
> 
> There's always i2c-stub, but yeah, it looks OK to me too.

Unfortunately, I have neither lm77 nor lm93 dumps to load i2c-stub
with. If anyone has such dumps and could share them...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
