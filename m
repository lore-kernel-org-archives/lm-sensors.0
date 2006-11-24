From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Fri, 24 Nov 2006 13:27:55 +0000
Subject: [lm-sensors] DS2450 1-wire family driver
Message-Id: <20061124132754.GA27484@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200611030904.29206.hans@rubico.se>
In-Reply-To: <200611030904.29206.hans@rubico.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 24, 2006 at 02:21:29PM +0100, Rudolf Marek (r.marek at assembler.cz) wrote:
> Hi,

Hello.

> >We are a team working with uClinux for Blackfin DSPs and sensor 
> >networking, we are currently in the stadium of investigating Linux 
> >capabilites on sensors over i2c and 1-wire buses. I have been assigned to 
> >try out the DS2450 quad A/D converter(1-wire slave device):
> >
> >http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2921
> >
> >I Tried to search the lm-sensors list archive but could not find any 
> >related drivers. Has there been any work on that family?
> 
> Hmm we have lot i2c drivers not so may W1. I'm CCing  Evgeniy Polyakov  as 
> he might have more clue. I think you will need also a driver for the W1 
> master, besides the driver for the slave.

Depending on where w1 slave device is connected - if bus master device is
already supported, then you have less work.

I definitely appreciate steps to create and integrate w1 device drivers
into mainline tree.

Feel free to ask for comments if something is behind Documentation/w1
and other drivers sources.

-- 
	Evgeniy Polyakov

