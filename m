From: list0570@paradise.net.nz (Volker Kuhlmann)
Date: Mon, 14 Nov 2005 02:08:34 +0000
Subject: [lm-sensors] SiS630 sensors.conf errors
Message-Id: <20051114010739.GE18834@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051030235843.GF26397@paradise.net.nz>
In-Reply-To: <20051030235843.GF26397@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed 02 Nov 2005 10:59:11 NZDT +1300, Jean Delvare wrote:

Hi Jean,

Thanks for your reply.

> > I had posted my complete settings. IMHO sensors-detect should not
> > require any user interaction for coming up with a correct and functional
> > configuration. The average Linux (and other) desktop user doesn't know
> > how to edit a configuration file anyway.

> If sensors-detect isn't supposed to be interactive and users are not
> supposed to edit configuration files, then we need a complete database
> of configuration files for all motherboards out there. Are you going to
> provide this?

I was unclear. What I meant was that running sensors-detect should
always find a functional configuration, or it's not much use for the
desktop user. Of course it's not going to happen any time soon,
unfortunately. In view of the lack of support from the board makers I
don't see how this goal can be achieved without a collection of
information on the various board models. Collecting functional
configuration files for boards would not be too difficult, and
sensors-detect should be capable of picking the correct one, if
available. This prevents duplication of effort, and really helps the
majority of users who don't have the education to be able to construct
their own. Ship the board config files with the software, and have a
"get the latest from". It's not so different from scanModem, and lspci
and lsusb work the same way.

> Face it, hardware monitoring is not meant for the average user.

Sure, I can see it is not for the average user. But it should be, and
regardless of whether it is like that under you-know-OS.

> Things will improve greatly the day motherboard manufacturers ship
> BIOSes which do setup the hardware monitoring chip properly.

Oh yes. Blast them.

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.
