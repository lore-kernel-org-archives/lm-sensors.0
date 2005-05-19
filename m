From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: call for 2.6.6
Message-Id: <3DD68CA1.702D4602@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DD5999A.49A03347@paradyne.com>
In-Reply-To: <3DD5999A.49A03347@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> I don't know about the adm1021 module. What would it cost not to use the
> SENSORS_INSMOD_8 thing?
> 

It was added for mc1066 support in adm1021. The only way around it
is to combine support for some of the 8 different chips and report
only 7 different chip types max.

> I don't think we have to care about the dependency issue. 15 months is
> really much, there were many fixes to i2c since, and having people
> upgrade can't hurt. If for any reason they don't want to, 2.6.3 to 2.6.5
> are working for almost everyone (at least, one of these is working for
> each one).
> 
> Does 2.7.0 mean "developement/unstable tree" for you? I think it will
> sound like that for almost everyone, including me. And if this means
> less support issues, it also means less feedback IMHO, so it's worth
> discussing.
> 

Doesn't mean unstable to me. We don't use the odd/even system, we've
been
stable for years :)
