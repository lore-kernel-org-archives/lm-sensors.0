From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Jun 2007 18:25:33 +0000
Subject: Re: [lm-sensors] dme1737 and sch311x similarities
Message-Id: <20070615202533.64e9a199@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706120929k2b63b7afy25e5e92b2dec756b@mail.gmail.com>
In-Reply-To: <191fb4ca0706120929k2b63b7afy25e5e92b2dec756b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 14 Jun 2007 11:53:07 -0700, Juerg Haefliger wrote:
> On 6/14/07, Jean Delvare <khali@linux-fr.org> wrote:
> > A different approach was taken for the ams driver, which also support
> > two access methods, but support is in separate files, which can be
> > selected (or not) through Kconfig.
> >
> > The ideal way would be separate kernel modules, so that you don't have
> > to exclude options at compilation time, and still don't have to load
> > i2c-core if you don't need it.
> 
> Or a split approach with a common module providing all the brains and
> two separate modules for i2c/lpc access.

Err, yes, that's exactly what I had in mind, actually, even though what
I wrote was particularly unclear.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
