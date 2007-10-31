From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Oct 2007 21:06:01 +0000
Subject: Re: [lm-sensors] Utility for creating computate sensors.conf lines
Message-Id: <20071031220601.198f5e10@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <472841C2.5060701@hhs.nl>
In-Reply-To: <472841C2.5060701@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 31 Oct 2007 21:38:45 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > You could use dmidecode's command line parameters to ease your parsing
> > work or at least speed it up. In particular, option -t, and maybe -u.
> 
> I tried using -t, but although it works for types that dmidecode knows about 
> like 20, it does not work for type 185, when I specify -t 185 I get no output.

Really? That would be a bug. Which version of dmidecode are you using?
An equivalent test case works fine here with both 2.8 and CVS.

Can you please send me (in private) a copy of the memory-mapped BIOS
area, so that I can reproduce the problem? The following command should
capture it:

dd if=/dev/mem of=/tmp/mem-fscher bsdk skip count=2

> (...)
> > The "+="s above should IMHO be "|="s. Granted, it only makes a
> > difference if the same entity is described twice, which shouldn't
> > happen, but I still think it's cleaner that way.
> 
> Actually they are += deliberately, and the bits used are sparse deliberately, 
> so that if there is more then one occurrence of an entity entities_found won't 
> match, as I don't think thats supposed to happen (most of this is reverse 
> engineered, all I have is the fscher "datasheet" which doesn't give much 
> details about the layout of the dmi data).

I'm fine with returning an error in this case, but failing silently is
confusing. Also, with a more straightforward bitfield you could fail
directly, rather than storing the error and having to wait until the
end.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
