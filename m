From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: Hard disk temperature
Message-Id: <3C43546D.7E1A8F47@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E16PrMy-0005FT-00@localhost>
In-Reply-To: <E16PrMy-0005FT-00@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Interesting idea, we could do a pseudo-i2c adapter like i2c-isa and make it
work. I'll look into it further.
mds

Aurelien Jarno wrote:
> 
> Hello,
> 
> On this website (http://linuxfr.org/2002/01/11/6644,0,0,0,1.php3 - sorry, it
> is in french), a person has announced that he has written a small application
> (http://coredump.free.fr/linux/hddtemp-0.2.tar.gz) to read temperature of IDE
> disk drives, using the S.M.A.R.T. function.
> 
> Maybe, it can be integrated into lm-sensors, so a lot of applets using
> lm-sensors (for kde, gnome or window-maker) can see the hard disk
> temperatures. But this application doesn't use the I2C or lmbus, so I don't
> know if it is easily integrable into lm-sensors.
> 
> So I want to have your opinion about that.
> 
> Aurelien
> 
> P.S. : Sorry for my bad English
