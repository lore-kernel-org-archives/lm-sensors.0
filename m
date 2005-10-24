From: ch@westend.com (Christian Hammers)
Date: Mon, 24 Oct 2005 10:11:58 +0000
Subject: [lm-sensors] [Ticket #2078] sensor values are sometimes wrong
Message-Id: <20051024081121.GB10262@westend.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051021083606.GB19748@westend.com>
In-Reply-To: <20051021083606.GB19748@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

On Sun, Oct 23, 2005 at 10:40:38PM +0200, Rudolf Marek wrote:
> > My problem is that sensors sometimes reports confusing values i.e.
> > - it prints ALERT although the corresponding values are fine, the ALERT
> >   then vanished in the next read
> > - sensor values give suddenly 0 or arbitrary values
> > - configured limits are 0 for one or two reads and then go back to the
> >   defined value
> 
> This sounds like there might be something else accessing the chip. Did
> you check log if there are no i2c bus related problems?
There are no related syslog messages and I'm not aware of any other
application using the i2c bus. There's no TV card in this server, are
there other likely candidates?

> We may also implement some checks to asb100 read routine to be sure
> that the reads actualy succeed instead of failing silencely.

bye,

-christian-

-- 
Christian Hammers             WESTEND GmbH  |  Internet-Business-Provider
Technik                       CISCO Systems Partner - Authorized Reseller
                              L?tticher Stra?e 10      Tel 0241/701333-11
ch@westend.com                D-52064 Aachen              Fax 0241/911879

